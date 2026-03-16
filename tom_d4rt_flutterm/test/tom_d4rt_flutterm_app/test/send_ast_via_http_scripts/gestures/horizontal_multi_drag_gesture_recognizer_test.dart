// D4rt test script: Tests HorizontalMultiDragGestureRecognizer
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HorizontalMultiDragGestureRecognizer test executing');

  final recognizer = HorizontalMultiDragGestureRecognizer();
  print('Type: ${recognizer.runtimeType}');
  print('is MultiDragGestureRecognizer: ${recognizer is MultiDragGestureRecognizer}');
  recognizer.dispose();

  print('HorizontalMultiDragGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('HorizontalMultiDragGestureRecognizer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    Text('Multi-pointer horizontal drags'),
  ]);
}
