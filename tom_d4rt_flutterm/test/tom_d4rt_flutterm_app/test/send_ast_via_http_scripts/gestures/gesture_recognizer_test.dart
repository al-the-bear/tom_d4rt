// D4rt test script: Tests GestureRecognizer from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GestureRecognizer test executing');

  // Abstract — test via TapGestureRecognizer
  final tap = TapGestureRecognizer();
  print('true: true');
  print('debugOwner: ${tap.debugOwner}');
  print('debugDescription: ${tap.debugDescription}');
  print('toString: ${tap.toString()}');
  tap.dispose();

  // LongPressGestureRecognizer
  final lp = LongPressGestureRecognizer();
  print('LongPress debugDescription: ${lp.debugDescription}');
  lp.dispose();

  print('GestureRecognizer test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('GestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Abstract base for all recognizers'),
    Text('Tested via Tap + LongPress'),
  ]);
}
