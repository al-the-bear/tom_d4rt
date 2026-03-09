// D4rt test script: Tests MultiDragPointerState (abstract) from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiDragPointerState test executing');

  // MultiDragPointerState is abstract — used internally by MultiDragGestureRecognizer
  print('MultiDragPointerState: abstract class');
  print('Tracks state of individual pointers in multi-drag gestures');
  print('Properties: initialPosition, pendingDelta, kind');
  print('Methods: checkForResolutionAfterMove, accepted, rejected, dispose');

  // Demonstrate via recognizer that uses it
  final recognizer = ImmediateMultiDragGestureRecognizer();
  print('ImmediateMultiDrag uses MultiDragPointerState internally');
  recognizer.dispose();

  print('MultiDragPointerState test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('MultiDragPointerState Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Abstract - tracks pointer state'),
    Text('Used by MultiDragGestureRecognizer'),
  ]);
}
