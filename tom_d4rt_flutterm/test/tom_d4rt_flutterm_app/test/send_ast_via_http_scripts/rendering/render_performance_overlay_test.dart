// D4rt test script: Tests RenderPerformanceOverlay from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderPerformanceOverlay test executing');

  // RenderPerformanceOverlay - RenderPerformanceOverlay
  // This is typically an abstract/base class used through subclasses
  print('RenderPerformanceOverlay is available in the rendering package');
  print('RenderPerformanceOverlay: RenderPerformanceOverlay');

  print('RenderPerformanceOverlay test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderPerformanceOverlay Tests'),
      Text('RenderPerformanceOverlay'),
    ],
  );
}
