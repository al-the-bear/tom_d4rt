// D4rt test script: Tests MultiDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiDragGestureRecognizer test executing');

  // Abstract — test via subtypes
  final immediate = ImmediateMultiDragGestureRecognizer();
  print('Immediate is MultiDragGestureRecognizer: ${immediate is MultiDragGestureRecognizer}');
  immediate.dispose();

  final horizontal = HorizontalMultiDragGestureRecognizer();
  print('Horizontal is MultiDragGestureRecognizer: ${horizontal is MultiDragGestureRecognizer}');
  horizontal.dispose();

  final vertical = VerticalMultiDragGestureRecognizer();
  print('Vertical is MultiDragGestureRecognizer: ${vertical is MultiDragGestureRecognizer}');
  vertical.dispose();

  final delayed = DelayedMultiDragGestureRecognizer();
  print('Delayed is MultiDragGestureRecognizer: ${delayed is MultiDragGestureRecognizer}');
  delayed.dispose();

  print('MultiDragGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('MultiDragGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Abstract base for multi-pointer drags'),
    Text('4 implementations tested'),
  ]);
}
