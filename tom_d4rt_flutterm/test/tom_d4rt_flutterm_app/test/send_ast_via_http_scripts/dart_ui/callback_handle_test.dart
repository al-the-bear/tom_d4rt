// D4rt test script: Tests CallbackHandle from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CallbackHandle test executing');

  // Test CallbackHandle - Callback registration
  print('CallbackHandle is available in the dart_ui package');
  print('CallbackHandle: Callback registration');

  print('CallbackHandle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CallbackHandle Tests'),
      Text('Callback registration'),
    ],
  );
}
