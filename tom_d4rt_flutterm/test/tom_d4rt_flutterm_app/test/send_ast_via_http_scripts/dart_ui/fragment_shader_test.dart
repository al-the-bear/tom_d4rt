// D4rt test script: Tests FragmentShader from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FragmentShader test executing');

  // Test FragmentShader - Fragment shader instance
  print('FragmentShader is available in the dart_ui package');
  print('FragmentShader: Fragment shader instance');

  print('FragmentShader test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FragmentShader Tests'),
      Text('Fragment shader instance'),
    ],
  );
}
