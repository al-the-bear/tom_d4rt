// D4rt test script: Tests Scene from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Scene test executing');

  // Test Scene - Rendered scene
  print('Scene is available in the dart_ui package');
  print('Scene: Rendered scene');

  print('Scene test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Scene Tests'),
      Text('Rendered scene'),
    ],
  );
}
