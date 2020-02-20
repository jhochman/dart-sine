library SineSVG;

import 'dart:math' as Math;

import 'package:d3/scale/scale.dart';
import 'package:d3/selection/selection.dart';

import '../lib/line.dart';

class SineSVG {

  String PI = new String.fromCharCode(960);

  static var width   = 800;
  static var height  = 300;
  static var xmin    = -2;
  static var xmax    = 6;
  static var ymin    = -height * (xmax - xmin) / width / 2;
  static var ymax    = -ymin;
  static var xScale  = new Linear();
  static var yScale  = new Linear();
  static var vis     = new Selection.selector('#sineSVG').append('svg:svg');
  static var decor   = vis.append('svg:g');
  static var graph   = vis.append('svg:g');
  static var circle  = graph.append('svg:circle');
  static Selection b       = graph.append('svg:line');
  static Selection c       = graph.append('svg:line');
  static var label   = graph.append('svg:text');
  static Line sine = new Line();
  static Selection path    = graph.append('svg:path');
  static Selection dot     = graph.append('svg:circle');
  static Selection dot2     = graph.append('svg:circle');
  static var time    = 0;
  static var i;
  static var X1      = 'x1';
  static var X2      = 'x2';
  static var Y1      = 'y1';
  static var Y2      = 'y2';

  SineSVG () {

    xScale
     ..domain = [xmin,xmax]
     ..range = [0, width];

    yScale
    ..domain = [ymin, ymax]
    ..range = [0, height];

    vis
    ..attr('width', width)
    ..attr('height', height);

    decor.append('svg:line')
    ..attr('stroke', 'black')
    ..attr('stroke-width', '2')
    ..attr(X1, xScale(xmin))
    ..attr(Y1, yScale(0))
    ..attr(X2, xScale(xmax))
    ..attr(Y2, yScale(0));

    decor.append('svg:line')
    ..attr('stroke', 'black')
    ..attr(X1, xScale(Math.PI))
    ..attr(Y1, yScale(0))
    ..attr(X2, xScale(Math.PI))
    ..attr(Y2, yScale(0) + 8);

    decor.append("svg:text")
    ..text(PI)
    ..attr("x", (xScale(Math.PI)))
    ..attr("y", (yScale(0)) + 24)
    ..attr("text-anchor", "middle");

    decor.append('svg:line')
    ..attr('stroke', 'black')
    ..attr(X1, xScale(0))
    ..attr(Y1, yScale(ymin))
    ..attr(X2, xScale(0))
    ..attr(Y2, yScale(ymax));

    label
    ..attr("x", 2)
    ..attr("y", 24);

    circle
    ..attr('cx', xScale(0))
    ..attr('cy', yScale(0))
    ..attr('r', xScale(1) - xScale(0))
    ..attr('stroke', 'red')
    ..attr('stroke-width', '2')
    ..style('fill', 'none');

    c
    ..attr('stroke', 'red')
    ..attr('stroke-width', '2')
    ..attr(X1, xScale(0))
    ..attr(Y1, yScale(0));

    b
    ..attr('stroke-dasharray','5,5')
    ..attr('stroke-width', '2')
    ..attr('stroke', 'red');

    path
    ..attr('stroke', 'red')
    ..attr('stroke-width', '2')
    ..attr('fill','none');

    dot
      ..attr('cx', xScale(0))
      ..attr('r', 5)
      ..attr('stroke', 'red')
      ..attr('stroke-width', '2')
      ..style('fill', '#fff');

    dot2
      ..attr('cx', xScale(0))
      ..attr('r', 5)
      ..attr('stroke', 'red')
      ..attr('stroke-width', '2')
      ..style('fill', '#fff');

  }

  void draw () {
    var
    x = xScale(Math.cos(time)),
    y = yScale(-Math.sin(time));


    label
    ..text('t = ${(time / Math.PI).floor()}');

    c
    ..attr(X2, x)
    ..attr(Y2, y);

    b
    ..attr(X1, xScale(0))
    ..attr(Y1, y)
    ..attr(X2, x)
    ..attr(Y2, y);

    dot
    ..attr('cy', y);

    dot2
    ..attr('cy', y)
    ..attr('cx', x);

    var n = 84;
    var data = [];

    for (i = 0; i < n; i++) {
      var xx = xScale(i * 10 / n);
      var yy = yScale(Math.sin(i * 10 / n - time));
      data.add([xx,yy]);
    }

    path
    ..attr('d', sine(data));

    time += .005 * Math.PI;
  }

}
