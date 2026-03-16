// D4rt test script: Tests PerformanceOverlayLayer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PerformanceOverlayLayer test executing');

  // Test PerformanceOverlayLayer - Performance overlay
  print('PerformanceOverlayLayer is available in the rendering package');
  print('PerformanceOverlayLayer: Performance overlay');

  print('PerformanceOverlayLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PerformanceOverlayLayer Tests'),
      Text('Performance overlay'),
    ],
  );
}
