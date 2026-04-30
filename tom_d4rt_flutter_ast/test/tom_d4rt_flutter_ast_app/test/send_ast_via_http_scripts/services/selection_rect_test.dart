// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectionRect from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectionRect test executing');

  // Create SelectionRect
  final rect = SelectionRect(
    position: 5,
    bounds: Rect.fromLTWH(100, 200, 20, 30),
    direction: TextDirection.ltr,
  );

  print('Created: ${rect.runtimeType}');

  // Test position
  print('\nPosition property:');
  print('position: ${rect.position}');
  print('Character index in text');

  // Test bounds
  print('\nBounds property:');
  print('bounds: ${rect.bounds}');
  print('left: ${rect.bounds.left}');
  print('top: ${rect.bounds.top}');
  print('width: ${rect.bounds.width}');
  print('height: ${rect.bounds.height}');

  // Test direction
  print('\nDirection property:');
  print('direction: ${rect.direction}');

  // Explain purpose
  print('\nSelectionRect purpose:');
  print('- Describes rectangle for text selection');
  print('- Used for IME floating cursor');
  print('- Maps character position to screen rect');
  print('- Part of SelectableRegion API');

  // Multiple rects example
  print('\nMultiple rects for selection:');
  final rects = [
    SelectionRect(
      position: 0,
      bounds: Rect.fromLTWH(0, 0, 10, 20),
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      position: 1,
      bounds: Rect.fromLTWH(10, 0, 10, 20),
      direction: TextDirection.ltr,
    ),
    SelectionRect(
      position: 2,
      bounds: Rect.fromLTWH(20, 0, 10, 20),
      direction: TextDirection.ltr,
    ),
  ];
  print('Rects count: ${rects.length}');
  print('Used for: setSelectionRects()');

  print('\nSelectionRect test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SelectionRect Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Character selection rectangle'),
      Text('position: ${rect.position}'),
      Text('bounds: ${rect.bounds}'),
      Text('direction: ${rect.direction}'),
    ],
  );
}
