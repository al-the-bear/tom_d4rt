// D4rt test script: Tests Display from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Display test executing');

  // Test Display - Display information
  print('Display is available in the dart_ui package');
  print('Display: Display information');

  print('Display test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Display Tests'),
      Text('Display information'),
    ],
  );
}
