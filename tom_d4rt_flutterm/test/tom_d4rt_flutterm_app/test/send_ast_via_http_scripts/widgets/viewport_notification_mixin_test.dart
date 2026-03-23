// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ViewportNotificationMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ViewportNotificationMixin test executing');

  // ViewportNotificationMixin - Mixin for viewport scroll notifications
  // Sends ScrollMetricsNotification when viewport changes
  
  print('ViewportNotificationMixin purpose:');
  print('- Dispatches ScrollMetricsNotification');
  print('- Tracks viewport dimension changes');
  print('- Notifies listeners of scroll metrics');
  print('- Used by scrollable viewport elements');
  
  // When notifications are sent
  print('\nNotification triggers:');
  print('- Viewport dimensions change');
  print('- Max scroll extent changes');
  print('- Min scroll extent changes');
  print('- Viewport depth changes');
  
  // ScrollMetricsNotification content
  print('\nScrollMetricsNotification contains:');
  print('- metrics: Current ScrollMetrics');
  print('- metrics.pixels: Current scroll position');
  print('- metrics.maxScrollExtent: Max scrollable');
  print('- metrics.viewportDimension: Viewport size');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('ViewportNotificationMixin is a mixin');
  print('Mixed into RenderObjectElement subclasses');
  print('Implements notification dispatch');
  
  // Use cases
  print('\nUse cases:');
  print('- Custom scroll views');
  print('- Scroll-aware widgets');
  print('- Metrics tracking systems');
  print('- Infinite scroll loaders');

  print('\nViewportNotificationMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ViewportNotificationMixin Tests'),
      Text('Viewport scroll notifications'),
      Text('ScrollMetricsNotification dispatch'),
      Text('Dimension change tracking'),
    ],
  );
}
