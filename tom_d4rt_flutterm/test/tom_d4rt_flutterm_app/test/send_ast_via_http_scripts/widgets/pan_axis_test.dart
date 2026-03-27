// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PanAxis from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PanAxis test executing');
  print('=' * 50);

  // === Test PanAxis enum ===
  print('\nPanAxis controls InteractiveViewer pan directions');

  // List all values
  print('\n--- Enum values ---');
  for (final axis in PanAxis.values) {
    print('PanAxis.${axis.name}');
  }

  // Test horizontal
  print('\n--- Testing horizontal ---');
  final horizontal = PanAxis.horizontal;
  print('horizontal.name: ${horizontal.name}');
  print('horizontal.index: ${horizontal.index}');
  print('Pan only left/right');

  // Test vertical
  print('\n--- Testing vertical ---');
  final vertical = PanAxis.vertical;
  print('vertical.name: ${vertical.name}');
  print('vertical.index: ${vertical.index}');
  print('Pan only up/down');

  // Test aligned
  print('\n--- Testing aligned ---');
  final aligned = PanAxis.aligned;
  print('aligned.name: ${aligned.name}');
  print('aligned.index: ${aligned.index}');
  print('Pan horizontally OR vertically, not diagonal');

  // Test free
  print('\n--- Testing free ---');
  final free = PanAxis.free;
  print('free.name: ${free.name}');
  print('free.index: ${free.index}');
  print('Pan in any direction');

  // Test comparison
  print('\n--- Testing comparison ---');
  print('horizontal == vertical: ${horizontal == vertical}');
  print('free == PanAxis.free: ${free == PanAxis.free}');

  // Test with InteractiveViewer
  print('\n--- Testing with InteractiveViewer ---');
  final viewer = InteractiveViewer(
    panAxis: PanAxis.aligned,
    boundaryMargin: EdgeInsets.all(20),
    minScale: 0.5,
    maxScale: 4.0,
    child: Container(
      width: 200,
      height: 200,
      color: Colors.blue,
      child: Center(child: Text('Zoom/Pan me')),
    ),
  );
  print('Created InteractiveViewer with aligned pan');
  print('viewer.panAxis: ${viewer.panAxis}');

  // Use cases
  print('\n--- Use cases ---');
  print('horizontal: horizontal scrolling images');
  print('vertical: vertical document view');
  print('aligned: constrainted panning');
  print('free: unrestricted pan (maps)');

  print('\n' + '=' * 50);
  print('PanAxis test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PanAxis Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${PanAxis.values.length}'),
      Text('free.index: ${free.index}'),
      SizedBox(height: 100, width: 100, child: viewer),
    ],
  );
}
