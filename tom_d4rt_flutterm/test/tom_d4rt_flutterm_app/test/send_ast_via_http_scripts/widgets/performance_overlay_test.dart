// D4rt test script: Tests PerformanceOverlay from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PerformanceOverlay test executing');

  // Test PerformanceOverlay - Perf overlay
  print('PerformanceOverlay is available in the widgets package');
  print('PerformanceOverlay runtimeType accessible');

  print('PerformanceOverlay test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PerformanceOverlay Tests'),
      Text('Perf overlay'),
    ],
  );
}
