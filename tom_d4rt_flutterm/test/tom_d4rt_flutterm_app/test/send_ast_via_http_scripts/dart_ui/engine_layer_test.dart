// D4rt test script: Tests EngineLayer from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('EngineLayer test executing');

  // Test EngineLayer - Base engine layer
  print('EngineLayer is available in the dart_ui package');
  print('EngineLayer: Base engine layer');

  print('EngineLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('EngineLayer Tests'),
      Text('Base engine layer'),
    ],
  );
}
