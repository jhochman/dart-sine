library SineCanvas;

import 'dart:html';
import 'dart:math' as Math;
import 'dart:web_gl';

import 'package:stats/stats.dart';

String PI = new String.fromCharCode(960);

class SineCanvas {
  double seconds = 0.0, t = 0.0;
  CanvasElement canvas;
  var unit = 100,
  context, canvas2, context2,
  height, width, xAxis, yAxis;

  void init (var id) {

    canvas = document.getElementById(id) as CanvasElement;

    canvas.width = 800;
    canvas.height = 300;

    context = canvas.getContext("2d");
    context.font = '14px serif';
    context.strokeStyle = '#000';
    context.lineJoin = 'round';

    height = canvas.height;
    width = canvas.width;

    xAxis = (height/2).floor();
    yAxis = (width/4).floor();

    context.save();
  }

  void draw () {
    // Clear the canvas
    context.clearRect(0, 0, width, height);

    // Draw the axes in their own path
    context.beginPath();
    drawAxes();
    context.stroke();

    // Set styles for animated graphics
    context.save();
    context.strokeStyle = '#00f';
    context.fillStyle = '#fff';
    context.lineWidth = 2;

    // Draw the sine curve at time draw.t, as well as the circle.
    context.beginPath();
    drawSine(t);
    drawCircle();
    context.stroke();

    // Draw the arrow at time t in its own path.
    drawArrow(t);

    // Restore original styles
    context.restore();

    // Draw the xAxis Math.PI tick and the time
    context.fillText(PI, xAxis + 59+3*unit, 18+xAxis);
    int ft = ((seconds).abs()).floor();
    context.fillText("t = $ft", 0, 20);

    // Update the time and draw again
    seconds = seconds - .005;
    t = seconds * Math.pi;
    //setTimeout(draw, 35);
  }

  void drawAxes() {

    // Draw X and Y axes
    context.moveTo(0, xAxis);
    context.lineTo(width, xAxis);
    context.moveTo(yAxis, 0);
    context.lineTo(yAxis, height);

    // Draw X axis tick at Math.PI
    context.moveTo(yAxis+Math.pi*unit, xAxis+5);
    context.lineTo(yAxis+Math.pi*unit, xAxis-5);

  }

  void drawSine(t) {

    // Set the initial x and y, starting at 0,0 and translating to the origin on
    // the canvas.
    var x = t;
    var y = Math.sin(x);
    context.moveTo(yAxis, unit*y+xAxis);

    // Loop to draw segments
    for (int i = yAxis; i <= width; i += 10) {
      x = t+(-yAxis+i)/unit;
      y = Math.sin(x);
      context.lineTo(i, unit*y+xAxis);
    }
  }

  void drawCircle() {
    context.moveTo(yAxis+unit, xAxis);
    context.arc(yAxis, xAxis, unit, 0, 2*Math.pi, false);
  }

  void drawArrow(t) {

    // Cache position of arrow on the circle
    var x = yAxis+unit*Math.cos(t);
    var y = xAxis+unit*Math.sin(t);

    // Draw the arrow line
    context.beginPath();
    context.moveTo(yAxis, xAxis);
    context.lineTo(x, y);
    context.stroke();

    // Draw the arrow bead
    context.beginPath();
    context.arc(x, y, 5, 0, 2*Math.pi, false);
    context.fill();
    context.stroke();

    // Draw dashed line to yAxis
    context.beginPath();
    var direction = (Math.cos(t) < 0) ? 1 : -1;

    for (var i = x;  direction*i < direction*yAxis-5; i = i+direction*10) {
      context.moveTo(i+direction*5, y);
      context.lineTo(i+direction*10, y);
    }
    context.stroke();

    // Draw yAxis bead
    context.beginPath();
    context.arc(yAxis, y, 5, 0, 2*Math.pi, false);
    context.fill();
    context.stroke();
  }

}