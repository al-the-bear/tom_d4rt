// D4rt test script: Tests MultiTapGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiTapGestureRecognizer test executing');

  final recognizer = MultiTapGestureRecognizer();
  print('Type: ${recognizer.runtimeType}');
  print('is GestureRecognizer: ${recognizer is GestureRecognizer}');

  recognizer.onTapDown = (pointer, details) { print('tapDown: $pointer'); };
  recognizer.onTapUp = (pointer, details) { print('tapUp: $pointer'); };
  recognizer.onTapCancel = (pointer) { print('tapCancel: $pointer'); };
  recognizer.onTap = (pointer) { print('tap: $pointer'); };
  recognizer.onLongTapDown = (pointer, details) { print('longTapDown: $pointer'); };
  print('Callbacks set');

  recognizer.dispose();
  print('Disposed');

  print('MultiTapGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('MultiTapGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Tracks multiple simultaneous taps'),
    Text('Callbacks: tapDown/Up/Cancel, longTapDown'),
  ]);
}
