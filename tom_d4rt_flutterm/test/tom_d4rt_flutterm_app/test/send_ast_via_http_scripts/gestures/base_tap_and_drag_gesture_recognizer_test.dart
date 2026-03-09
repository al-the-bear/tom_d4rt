// D4rt test script: Tests BaseTapAndDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BaseTapAndDragGestureRecognizer test executing');

  final recognizer = TapAndPanGestureRecognizer();
  print('TapAndPanGestureRecognizer type: ${recognizer.runtimeType}');
  print('is BaseTapAndDragGestureRecognizer: ${recognizer is BaseTapAndDragGestureRecognizer}');
  print('dragStartBehavior: ${recognizer.dragStartBehavior}');
  recognizer.dispose();
  print('Disposed');

  print('BaseTapAndDragGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('BaseTapAndDragGestureRecognizer', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Abstract base for tap+drag'),
    Text('Impl: TapAndPanGestureRecognizer'),
  ]);
}
