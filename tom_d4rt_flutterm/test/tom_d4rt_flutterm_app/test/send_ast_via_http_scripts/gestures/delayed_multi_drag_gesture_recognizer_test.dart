// D4rt test script: Tests DelayedMultiDragGestureRecognizer
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DelayedMultiDragGestureRecognizer test executing');

  final recognizer = DelayedMultiDragGestureRecognizer();
  print('Type: ${recognizer.runtimeType}');
  print('is MultiDragGestureRecognizer: ${recognizer is MultiDragGestureRecognizer}');
  print('delay: ${recognizer.delay}');
  recognizer.dispose();
  print('Disposed');

  // With custom delay
  final r2 = DelayedMultiDragGestureRecognizer(delay: Duration(milliseconds: 500));
  print('Custom delay: ${r2.delay}');
  r2.dispose();

  print('DelayedMultiDragGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DelayedMultiDragGestureRecognizer', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('delay: ${recognizer.delay}'),
  ]);
}
