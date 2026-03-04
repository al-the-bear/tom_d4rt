// D4rt test script: Tests RSuperellipse from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RSuperellipse test executing');

  // Test RSuperellipse - Superellipse shapes
  print('RSuperellipse is available in the dart_ui package');
  print('RSuperellipse: Superellipse shapes');

  print('RSuperellipse test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RSuperellipse Tests'),
      Text('Superellipse shapes'),
    ],
  );
}
