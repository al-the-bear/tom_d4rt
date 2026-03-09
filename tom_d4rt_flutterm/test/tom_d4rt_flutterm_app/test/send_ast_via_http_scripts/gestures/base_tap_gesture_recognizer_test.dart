// D4rt test script: Tests BaseTapGestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BaseTapGestureRecognizer test executing');

  // Abstract — tested via TapGestureRecognizer
  final recognizer = TapGestureRecognizer();
  print('TapGestureRecognizer: ${recognizer.runtimeType}');
  print('is BaseTapGestureRecognizer: ${recognizer is BaseTapGestureRecognizer}');
  print('deadline: ${recognizer.deadline}');
  recognizer.onTap = () { print('tapped'); };
  print('onTap set');
  recognizer.dispose();

  print('BaseTapGestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('BaseTapGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Abstract base for tap gestures'),
    Text('Impl: TapGestureRecognizer'),
  ]);
}
