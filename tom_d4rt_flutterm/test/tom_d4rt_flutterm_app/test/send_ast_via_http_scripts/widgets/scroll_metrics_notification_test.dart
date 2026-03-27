// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollMetricsNotification from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollMetricsNotification test executing');
  print('=' * 50);

  // ScrollMetricsNotification notifies when scroll metrics change
  print('\nScrollMetricsNotification Analysis:');
  print('  Type: class');
  print('  Extends: Notification');
  print('  Mixes in: ViewportNotificationMixin');
  print('  Purpose: Notify when ScrollMetrics change');

  // Create mock metrics
  final metrics = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1000.0,
    pixels: 250.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 2.0,
  );

  // Create notification
  print('\nConstruction:');
  final notification = ScrollMetricsNotification(
    metrics: metrics,
    context: context,
  );
  print('  Type: ${notification.runtimeType}');
  print('  Metrics: ${notification.metrics.runtimeType}');
  print('  Has context: ${notification.context != null}');

  // Metrics properties
  print('\nMetrics Properties:');
  print('  pixels: ${notification.metrics.pixels}');
  print('  minScrollExtent: ${notification.metrics.minScrollExtent}');
  print('  maxScrollExtent: ${notification.metrics.maxScrollExtent}');
  print('  viewportDimension: ${notification.metrics.viewportDimension}');
  print('  axisDirection: ${notification.metrics.axisDirection}');

  // Properties
  print('\nNotification Properties:');
  print('  metrics: ScrollMetrics');
  print('    - Description of scroll state');
  print('  context: BuildContext');
  print('    - Where notification fired');
  print('  depth: int (from ViewportNotificationMixin)');
  print('    - Nesting level');

  // Convert to ScrollNotification
  print('\nConversion Method:');
  print('  asScrollUpdate(): ScrollUpdateNotification');
  print('  Allows use with ScrollNotificationPredicate');
  final scrollUpdate = notification.asScrollUpdate();
  print('  Converted: ${scrollUpdate.runtimeType}');

  // When dispatched
  print('\nWhen Dispatched:');
  print('  - Window size changes (viewport dimension)');
  print('  - Content size changes (scroll extent)');
  print('  - Not for scroll position changes (use ScrollNotification)');

  // Debug description
  print('\nDebug Info:');
  final desc = <String>[];
  notification.debugFillDescription(desc);
  print('  Description entries: ${desc.length}');

  print('\n' + '=' * 50);
  print('ScrollMetricsNotification test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ScrollMetricsNotification Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Metrics pixels: ${notification.metrics.pixels}'),
      Text('Viewport: ${notification.metrics.viewportDimension}'),
      Text('Max extent: ${notification.metrics.maxScrollExtent}'),
    ],
  );
}
