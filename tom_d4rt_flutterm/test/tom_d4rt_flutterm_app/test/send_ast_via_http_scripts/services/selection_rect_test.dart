// D4rt test script: Tests SelectionRect from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

dynamic build(BuildContext context) {
  print('SelectionRect test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create SelectionRect instance
  print('\n--- Test 1: Create SelectionRect instance ---');
  try {
    final rect = SelectionRect(
      position: 0,
      bounds: const Rect.fromLTWH(10, 20, 100, 30),
    );
    assert(rect is SelectionRect);
    print('Created SelectionRect successfully');
    print('Position: ${rect.position}');
    print('Bounds: ${rect.bounds}');
    results.add('Test 1 PASSED: Instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test position property
  print('\n--- Test 2: Test position property ---');
  try {
    final positions = [0, 5, 10, 50, 100];
    for (final pos in positions) {
      final rect = SelectionRect(
        position: pos,
        bounds: Rect.zero,
      );
      print('Position: ${rect.position}');
      assert(rect.position == pos);
    }
    results.add('Test 2 PASSED: Position property');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test bounds with various rectangles
  print('\n--- Test 3: Test bounds with various rectangles ---');
  try {
    final boundsList = [
      const Rect.fromLTWH(0, 0, 50, 20),
      const Rect.fromLTWH(100, 200, 150, 30),
      const Rect.fromLTWH(50, 50, 200, 40),
      const Rect.fromLTRB(10, 20, 110, 50),
    ];
    for (final bounds in boundsList) {
      final rect = SelectionRect(position: 0, bounds: bounds);
      print('Bounds: ${rect.bounds}');
      print('  Width: ${rect.bounds.width}, Height: ${rect.bounds.height}');
      assert(rect.bounds == bounds);
    }
    results.add('Test 3 PASSED: Various bounds');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test direction property (if available)
  print('\n--- Test 4: Test SelectionRect with direction ---');
  try {
    final rect = SelectionRect(
      position: 5,
      bounds: const Rect.fromLTWH(10, 20, 80, 25),
      direction: TextDirection.ltr,
    );
    print('Direction: ${rect.direction}');
    print('Position: ${rect.position}');
    print('Bounds: ${rect.bounds}');
    results.add('Test 4 PASSED: Direction property');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test RTL direction
  print('\n--- Test 5: Test RTL direction ---');
  try {
    final rect = SelectionRect(
      position: 10,
      bounds: const Rect.fromLTWH(200, 30, 80, 25),
      direction: TextDirection.rtl,
    );
    print('RTL Direction: ${rect.direction}');
    print('Bounds: ${rect.bounds}');
    assert(rect.direction == TextDirection.rtl);
    results.add('Test 5 PASSED: RTL direction');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Create multiple SelectionRects for text line
  print('\n--- Test 6: Create SelectionRects for text line ---');
  try {
    final lineRects = <SelectionRect>[];
    double xOffset = 0;
    for (int i = 0; i < 10; i++) {
      final charWidth = 10.0 + (i % 3) * 2;
      final rect = SelectionRect(
        position: i,
        bounds: Rect.fromLTWH(xOffset, 0, charWidth, 20),
      );
      lineRects.add(rect);
      xOffset += charWidth;
    }
    print('Created ${lineRects.length} character rects');
    for (int i = 0; i < lineRects.length; i++) {
      print('Char $i: pos=${lineRects[i].position}, x=${lineRects[i].bounds.left.toStringAsFixed(1)}');
    }
    results.add('Test 6 PASSED: Text line rects');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test bounds geometry calculations
  print('\n--- Test 7: Test bounds geometry calculations ---');
  try {
    final rect = SelectionRect(
      position: 0,
      bounds: const Rect.fromLTWH(10, 20, 100, 30),
    );
    final bounds = rect.bounds;
    print('Left: ${bounds.left}');
    print('Top: ${bounds.top}');
    print('Right: ${bounds.right}');
    print('Bottom: ${bounds.bottom}');
    print('Width: ${bounds.width}');
    print('Height: ${bounds.height}');
    print('Center: ${bounds.center}');
    assert(bounds.right == 110);
    assert(bounds.bottom == 50);
    results.add('Test 7 PASSED: Geometry calculations');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Test equality comparison
  print('\n--- Test 8: Test equality comparison ---');
  try {
    final rect1 = SelectionRect(
      position: 5,
      bounds: const Rect.fromLTWH(10, 20, 100, 30),
    );
    final rect2 = SelectionRect(
      position: 5,
      bounds: const Rect.fromLTWH(10, 20, 100, 30),
    );
    final rect3 = SelectionRect(
      position: 6,
      bounds: const Rect.fromLTWH(10, 20, 100, 30),
    );
    print('rect1 == rect2: ${rect1 == rect2}');
    print('rect1 == rect3: ${rect1 == rect3}');
    results.add('Test 8 PASSED: Equality comparison');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('SelectionRect test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('SelectionRect Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Passed: $testsPassed, Failed: $testsFailed', style: TextStyle(color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000))),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
