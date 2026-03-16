// D4rt test script: Tests OneSequenceGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OneSequenceGestureRecognizer test executing');

  // Abstract — test via subclasses
  final tap = TapGestureRecognizer();
  print('TapGestureRecognizer is OneSequenceGestureRecognizer: ${tap is OneSequenceGestureRecognizer}');
  tap.dispose();

  final longPress = LongPressGestureRecognizer();
  print('LongPress is OneSequenceGestureRecognizer: ${longPress is OneSequenceGestureRecognizer}');
  longPress.dispose();

  final vDrag = VerticalDragGestureRecognizer();
  print('VerticalDrag is OneSequenceGestureRecognizer: ${vDrag is OneSequenceGestureRecognizer}');
  vDrag.dispose();

  print('OneSequenceGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('OneSequenceGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Abstract base for single-sequence gestures'),
    Text('Tap, LongPress, Drag all extend it'),
  ]);
}
