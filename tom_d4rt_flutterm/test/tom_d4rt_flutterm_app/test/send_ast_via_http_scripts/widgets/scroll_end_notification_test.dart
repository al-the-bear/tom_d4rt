// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollEndNotification from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollEndNotification test executing');
  print('=' * 50);

  // ScrollEndNotification indicates scrolling has stopped
  print('\nScrollEndNotification Analysis:');
  print('  Type: class');
  print('  Extends: ScrollNotification');
  print('  Purpose: Notifies that scrolling has stopped');

  // Create mock metrics for testing
  final metrics = FixedScrollMetrics(
    minScrollExtent: 0.0,
    maxScrollExtent: 1000.0,
    pixels: 500.0,
    viewportDimension: 600.0,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 2.0,
  );

  // Create notification without drag details
  print('\nConstruction without DragDetails:');
  final notification = ScrollEndNotification(
    metrics: metrics,
    context: context,
  );
  print('  Type: ${notification.runtimeType}');
  print('  Metrics pixels: ${notification.metrics.pixels}');
  print('  DragDetails: ${notification.dragDetails}');
  print('  Depth: ${notification.depth}');

  // Properties from ScrollNotification
  print('\nProperties (from ScrollNotification):');
  print('  metrics: ScrollMetrics - scroll state');
  print('  context: BuildContext? - where dispatched');
  print('  depth: int - nesting depth');

  // Unique property
  print('\nUnique Property:');
  print('  dragDetails: DragEndDetails?');
  print('    - Non-null if stopped due to drag end');
  print('    - Null if stopped after ballistic scroll');
  print('  When drag ends with residual velocity:');
  print('    - Ballistic scroll starts');
  print('    - ScrollEndNotification delayed');
  print('    - dragDetails will be null');
  print('  When drag ends with low velocity:');
  print('    - No ballistic scroll');
  print('    - ScrollEndNotification immediate');
  print('    - dragDetails will be non-null');

  // Notification lifecycle
  print('\nScroll Notification Lifecycle:');
  print('  1. ScrollStartNotification - scrolling begins');
  print('  2. ScrollUpdateNotification - position changes');
  print('  3. ScrollEndNotification - scrolling ends');
  print('     (You are here)');

  // Debug description
  print('\nDebug Description:');
  final desc = <String>[];
  notification.debugFillDescription(desc);
  print('  Description entries: ${desc.length}');

  print('\n' + '=' * 50);
  print('ScrollEndNotification test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ScrollEndNotification Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Extends: ScrollNotification'),
      Text('Has dragDetails: ${notification.dragDetails != null}'),
      Text('Metrics pixels: ${notification.metrics.pixels}'),
    ],
  );
}
