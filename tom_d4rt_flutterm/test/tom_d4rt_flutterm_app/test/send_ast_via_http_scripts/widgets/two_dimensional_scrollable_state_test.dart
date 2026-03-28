// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TwoDimensionalScrollableState from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TwoDimensionalScrollableState test executing');
  print('=' * 50);

  // TwoDimensionalScrollableState manages 2D scrolling
  print('TwoDimensionalScrollableState overview:');
  print('  - State class for TwoDimensionalScrollable');
  print('  - Manages two ScrollController instances');
  print('  - Provides verticalScrollable getter');
  print('  - Provides horizontalScrollable getter');

  // Key properties
  print('\nKey properties:');
  print('  - verticalScrollable: ScrollableState');
  print('  - horizontalScrollable: ScrollableState');
  print('  - Uses GlobalKey for each axis');
  print('  - Creates fallback controllers if needed');

  // Controller management
  print('\nController management:');
  print('  - _verticalFallbackController if not provided');
  print('  - _horizontalFallbackController if not provided');
  print('  - Disposes fallbacks on widget update');
  print('  - Creates new fallbacks when controller removed');

  // Build structure
  print('\nBuild structure:');
  print('  - Outer Scrollable for vertical axis');
  print('  - Inner Scrollable for horizontal axis');
  print('  - ViewportBuilder for content');
  print('  - Both axes share same viewport');

  // Accessing from child
  print('\nAccessing from child widgets:');
  print('  - TwoDimensionalScrollable.of(context)');
  print('  - Returns TwoDimensionalScrollableState');
  print('  - Scrollable.of(context, axis: Axis.vertical)');
  print('  - Scrollable.of(context, axis: Axis.horizontal)');

  // Scroll notifications
  print('\nScroll notifications:');
  print('  - Both axes emit ScrollNotification');
  print('  - Same viewport depth for both');
  print('  - Differentiate by ScrollMetrics.axis');
  print('  - Use NotificationListener to observe');

  // Lifecycle
  print('\nLifecycle methods:');
  print('  - initState: creates fallback controllers');
  print('  - didUpdateWidget: handles controller changes');
  print('  - dispose: cleans up fallback controllers');
  print('  - build: creates nested Scrollable structure');

  // Scrolling in 2D
  print('\n2D scrolling behavior:');
  print('  - Independent scroll positions per axis');
  print('  - Physics apply to each axis');
  print('  - Can scroll diagonally');
  print('  - Uses TwoDimensionalViewport');

  print('\n' + '=' * 50);
  print('TwoDimensionalScrollableState test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TwoDimensionalScrollableState Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: State<TwoDimensionalScrollable>'),
      Text('Purpose: Manages 2D scroll state'),
      Text('Getters: verticalScrollable, horizontalScrollable'),
    ],
  );
}
