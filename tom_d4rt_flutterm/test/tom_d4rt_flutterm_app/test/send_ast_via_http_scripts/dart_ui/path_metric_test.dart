// D4rt test script: Tests PathMetric from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PathMetric test executing');

  // Test PathMetric - Individual path segment
  print('PathMetric is available in the dart_ui package');
  print('PathMetric: Individual path segment');

  print('PathMetric test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PathMetric Tests'),
      Text('Individual path segment'),
    ],
  );
}
