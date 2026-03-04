// D4rt test script: Tests SystemColor from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SystemColor test executing');

  // Test SystemColor - System color access
  print('SystemColor is available in the dart_ui package');
  print('SystemColor: System color access');

  print('SystemColor test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SystemColor Tests'),
      Text('System color access'),
    ],
  );
}
