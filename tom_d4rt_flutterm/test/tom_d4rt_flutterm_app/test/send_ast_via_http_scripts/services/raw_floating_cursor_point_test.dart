// ignore_for_file: avoid_print
// D4rt test script: Tests RawFloatingCursorPoint from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawFloatingCursorPoint test executing');
  print('=' * 50);

  // Create RawFloatingCursorPoint
  final point = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: Offset(100.0, 50.0),
  );
  print('\nRawFloatingCursorPoint created:');
  print('runtimeType: ${point.runtimeType}');

  // Properties
  print('\nRawFloatingCursorPoint properties:');
  print('state: ${point.state}');
  print('offset: ${point.offset}');

  // FloatingCursorDragState enum
  print('\nFloatingCursorDragState enum:');
  print('- Start: Floating cursor begins');
  print('- Update: Cursor position changed');
  print('- End: Floating cursor ends');
  print('Values: ${FloatingCursorDragState.values}');

  // Start state
  print('\nStart state:');
  final startPoint = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Start,
  );
  print('state: ${startPoint.state}');
  print('offset: ${startPoint.offset ?? "null (not needed for Start)"}');

  // Update state
  print('\nUpdate state:');
  final updatePoint = RawFloatingCursorPoint(
    state: FloatingCursorDragState.Update,
    offset: Offset(150.0, 75.0),
  );
  print('state: ${updatePoint.state}');
  print('offset: ${updatePoint.offset}');

  // End state
  print('\nEnd state:');
  final endPoint = RawFloatingCursorPoint(state: FloatingCursorDragState.End);
  print('state: ${endPoint.state}');
  print('offset: ${endPoint.offset ?? "null (not needed for End)"}');

  // iOS floating cursor
  print('\niOS floating cursor feature:');
  print('- Long press on keyboard spacebar');
  print('- Drag to move cursor precisely');
  print('- Visual cursor follows finger');
  print('- iOS 9+ feature');

  // Usage in TextInputClient
  print('\nUsage in TextInputClient:');
  print('void updateFloatingCursor(');
  print('  RawFloatingCursorPoint point,');
  print(') {');
  print('  switch (point.state) {');
  print('    case Start: showFloatingCursor();');
  print('    case Update: moveFloatingCursor(point.offset);');
  print('    case End: hideFloatingCursor();');
  print('  }');
  print('}');

  // Explain purpose
  print('\nRawFloatingCursorPoint purpose:');
  print('- Represents floating cursor state');
  print('- state: Current drag state');
  print('- offset: Position when updating');
  print('- Used with TextInputClient');
  print('- iOS spacebar cursor feature');

  print('\n' + '=' * 50);
  print('RawFloatingCursorPoint test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RawFloatingCursorPoint Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${point.runtimeType}'),
      Text('state: ${point.state}'),
      Text('offset: ${point.offset}'),
      Text('Purpose: iOS floating cursor'),
    ],
  );
}
