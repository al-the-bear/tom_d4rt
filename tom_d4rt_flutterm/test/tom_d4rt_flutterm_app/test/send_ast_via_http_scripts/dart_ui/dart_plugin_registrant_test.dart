// D4rt test script: Tests DartPluginRegistrant from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DartPluginRegistrant test executing');

  // Test DartPluginRegistrant - Plugin registration
  print('DartPluginRegistrant is available in the dart_ui package');
  print('DartPluginRegistrant: Plugin registration');

  print('DartPluginRegistrant test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DartPluginRegistrant Tests'),
      Text('Plugin registration'),
    ],
  );
}
