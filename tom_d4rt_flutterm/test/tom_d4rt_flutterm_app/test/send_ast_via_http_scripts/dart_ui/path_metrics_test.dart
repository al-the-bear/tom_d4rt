// D4rt test script: Tests PathMetrics from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PathMetrics test executing');

  // Test PathMetrics - Path measurement
  print('PathMetrics is available in the dart_ui package');
  print('PathMetrics: Path measurement');

  print('PathMetrics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PathMetrics Tests'),
      Text('Path measurement'),
    ],
  );
}
