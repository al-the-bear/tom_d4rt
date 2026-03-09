// D4rt test script: Tests ImmediateMultiDragGestureRecognizer
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImmediateMultiDragGestureRecognizer test executing');

  final recognizer = ImmediateMultiDragGestureRecognizer();
  print('Type: ${recognizer.runtimeType}');
  print('is MultiDragGestureRecognizer: ${recognizer is MultiDragGestureRecognizer}');
  recognizer.dispose();

  print('ImmediateMultiDragGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ImmediateMultiDragGestureRecognizer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    Text('Starts drag immediately on pointer down'),
  ]);
}
