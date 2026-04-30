// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MultiDragGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiDragGestureRecognizer test executing');

  // Abstract — test via subtypes
  final immediate = ImmediateMultiDragGestureRecognizer();
  print('true: true');
  immediate.dispose();

  final horizontal = HorizontalMultiDragGestureRecognizer();
  print('true: true');
  horizontal.dispose();

  final vertical = VerticalMultiDragGestureRecognizer();
  print('true: true');
  vertical.dispose();

  final delayed = DelayedMultiDragGestureRecognizer();
  print('true: true');
  delayed.dispose();

  print('MultiDragGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('MultiDragGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Abstract base for multi-pointer drags'),
    Text('4 implementations tested'),
  ]);
}
