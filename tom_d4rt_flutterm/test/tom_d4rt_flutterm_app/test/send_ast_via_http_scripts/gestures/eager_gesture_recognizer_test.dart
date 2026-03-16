// D4rt test script: Tests EagerGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EagerGestureRecognizer test executing');

  final recognizer = EagerGestureRecognizer();
  print('EagerGestureRecognizer: ${recognizer.runtimeType}');
  print('is GestureRecognizer: ${recognizer is GestureRecognizer}');
  recognizer.dispose();
  print('Disposed');

  print('EagerGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('EagerGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Immediately wins gesture arena'),
    Text('Used for consuming all pointers'),
  ]);
}
