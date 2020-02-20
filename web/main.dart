import 'dart:html';

import 'sinecanvas.dart';
//import 'sinesvg.dart';


SineCanvas sineCanvas = new SineCanvas();
//SineSVG sineSVG = new SineSVG();

void main() async {

  sineCanvas.init('sineCanvas');

  while (true) {
    await window.animationFrame;
    tick();
  }
}

void tick () {
  sineCanvas.draw();
  //sineSVG.draw();
}
