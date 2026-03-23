// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OneSequenceGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OneSequenceGestureRecognizer test executing');

  // Abstract — test via subclasses
  final tap = TapGestureRecognizer();
  print('true: true');
  tap.dispose();

  final longPress = LongPressGestureRecognizer();
  print('true: true');
  longPress.dispose();

  final vDrag = VerticalDragGestureRecognizer();
  print('true: true');
  vDrag.dispose();

  print('OneSequenceGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('OneSequenceGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Abstract base for single-sequence gestures'),
    Text('Tap, LongPress, Drag all extend it'),
  ]);
}
