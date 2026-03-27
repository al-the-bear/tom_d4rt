// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MagnifierInfo from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MagnifierInfo test executing');
  print('=' * 50);

  // === Test MagnifierInfo class ===
  print('\nMagnifierInfo provides positioning data for magnifier widget');

  // Create a MagnifierInfo
  print('\n--- Testing MagnifierInfo creation ---');
  final info = MagnifierInfo(
    globalGesturePosition: Offset(100, 200),
    caretRect: Rect.fromLTWH(95, 195, 2, 20),
    fieldBounds: Rect.fromLTWH(50, 180, 200, 40),
    currentLineBoundaries: Rect.fromLTWH(50, 195, 200, 20),
  );
  print('Created MagnifierInfo');
  print('info.runtimeType: ${info.runtimeType}');

  // Test globalGesturePosition
  print('\n--- Testing globalGesturePosition ---');
  print('globalGesturePosition: ${info.globalGesturePosition}');
  print('Represents: user finger/pointer position in global coords');

  // Test caretRect
  print('\n--- Testing caretRect ---');
  print('caretRect: ${info.caretRect}');
  print('caretRect.left: ${info.caretRect.left}');
  print('caretRect.top: ${info.caretRect.top}');
  print('caretRect.width: ${info.caretRect.width}');
  print('caretRect.height: ${info.caretRect.height}');
  print('Represents: text cursor rectangle in global coords');

  // Test fieldBounds
  print('\n--- Testing fieldBounds ---');
  print('fieldBounds: ${info.fieldBounds}');
  print('fieldBounds.size: ${info.fieldBounds.size}');
  print('Represents: text field boundaries in global coords');

  // Test currentLineBoundaries
  print('\n--- Testing currentLineBoundaries ---');
  print('currentLineBoundaries: ${info.currentLineBoundaries}');
  print('Represents: current text line bounds');

  // Test MagnifierInfo.empty
  print('\n--- Testing MagnifierInfo.empty ---');
  final empty = MagnifierInfo.empty;
  print('MagnifierInfo.empty: $empty');
  print('empty.globalGesturePosition: ${empty.globalGesturePosition}');
  print('empty.caretRect: ${empty.caretRect}');
  print('empty.fieldBounds: ${empty.fieldBounds}');

  // Test equality
  print('\n--- Testing equality ---');
  final info2 = MagnifierInfo(
    globalGesturePosition: Offset(100, 200),
    caretRect: Rect.fromLTWH(95, 195, 2, 20),
    fieldBounds: Rect.fromLTWH(50, 180, 200, 40),
    currentLineBoundaries: Rect.fromLTWH(50, 195, 200, 20),
  );
  print('info == info2: ${info == info2}');
  print('info.hashCode: ${info.hashCode}');
  print('info2.hashCode: ${info2.hashCode}');

  // Test toString
  print('\n--- Testing toString ---');
  print('toString: ${info.toString()}');

  print('\n' + '=' * 50);
  print('MagnifierInfo test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MagnifierInfo Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Position: ${info.globalGesturePosition}'),
      Text('Caret: ${info.caretRect.size}'),
      Text('Field: ${info.fieldBounds.size}'),
    ],
  );
}
