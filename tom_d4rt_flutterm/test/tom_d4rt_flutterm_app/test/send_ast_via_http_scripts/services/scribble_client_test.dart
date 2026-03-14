// D4rt test script: Tests ScribbleClient interface from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

// Mock implementation of ScribbleClient for testing
class TestScribbleClient implements ScribbleClient {
  String? _insertedText;
  bool _showToolbar = false;
  Rect _bounds = Rect.zero;

  @override
  String get currentTextEditingValue => 'Test text';

  @override
  void insertTextPlaceholder(Size size) {
    print('  insertTextPlaceholder called with size: $size');
  }

  @override
  void performSelector(String selectorName) {
    print('  performSelector called with: $selectorName');
  }

  @override
  void removeTextPlaceholder() {
    print('  removeTextPlaceholder called');
  }

  @override
  void showToolbar() {
    _showToolbar = true;
    print('  showToolbar called');
  }

  @override
  Rect get bounds => _bounds;

  set bounds(Rect r) => _bounds = r;

  @override
  bool isInScribbleRect(Rect rect) {
    final result = _bounds.overlaps(rect);
    print('  isInScribbleRect($rect): $result');
    return result;
  }
}

dynamic build(BuildContext context) {
  print('ScribbleClient test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create ScribbleClient implementation
  print('\n--- Test 1: Create ScribbleClient implementation ---');
  try {
    final client = TestScribbleClient();
    assert(client is ScribbleClient);
    print('TestScribbleClient created successfully');
    print('Is ScribbleClient: true');
    results.add('Test 1 PASSED: Implementation creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test currentTextEditingValue property
  print('\n--- Test 2: Test currentTextEditingValue property ---');
  try {
    final client = TestScribbleClient();
    final value = client.currentTextEditingValue;
    print('Current text editing value: "$value"');
    assert(value.isNotEmpty);
    results.add('Test 2 PASSED: currentTextEditingValue');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test insertTextPlaceholder
  print('\n--- Test 3: Test insertTextPlaceholder ---');
  try {
    final client = TestScribbleClient();
    final sizes = [
      const Size(50, 20),
      const Size(100, 40),
      const Size(200, 80),
    ];
    for (final size in sizes) {
      client.insertTextPlaceholder(size);
    }
    print('Placeholder insertions completed');
    results.add('Test 3 PASSED: insertTextPlaceholder');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test removeTextPlaceholder
  print('\n--- Test 4: Test removeTextPlaceholder ---');
  try {
    final client = TestScribbleClient();
    client.insertTextPlaceholder(const Size(100, 30));
    client.removeTextPlaceholder();
    print('Placeholder removed successfully');
    results.add('Test 4 PASSED: removeTextPlaceholder');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test showToolbar
  print('\n--- Test 5: Test showToolbar ---');
  try {
    final client = TestScribbleClient();
    client.showToolbar();
    print('Toolbar shown successfully');
    results.add('Test 5 PASSED: showToolbar');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test performSelector
  print('\n--- Test 6: Test performSelector ---');
  try {
    final client = TestScribbleClient();
    final selectors = ['cut:', 'copy:', 'paste:', 'selectAll:'];
    for (final selector in selectors) {
      client.performSelector(selector);
    }
    print('Selectors performed successfully');
    results.add('Test 6 PASSED: performSelector');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test bounds property
  print('\n--- Test 7: Test bounds property ---');
  try {
    final client = TestScribbleClient();
    client.bounds = const Rect.fromLTWH(10, 20, 200, 50);
    print('Bounds set: ${client.bounds}');
    assert(client.bounds.left == 10);
    assert(client.bounds.top == 20);
    results.add('Test 7 PASSED: bounds property');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Test isInScribbleRect
  print('\n--- Test 8: Test isInScribbleRect ---');
  try {
    final client = TestScribbleClient();
    client.bounds = const Rect.fromLTWH(0, 0, 100, 100);
    final overlapping = client.isInScribbleRect(
      const Rect.fromLTWH(50, 50, 100, 100),
    );
    final nonOverlapping = client.isInScribbleRect(
      const Rect.fromLTWH(200, 200, 50, 50),
    );
    print('Overlapping rect: $overlapping');
    print('Non-overlapping rect: $nonOverlapping');
    assert(overlapping == true);
    assert(nonOverlapping == false);
    results.add('Test 8 PASSED: isInScribbleRect');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('ScribbleClient test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ScribbleClient Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(
        'Passed: $testsPassed, Failed: $testsFailed',
        style: TextStyle(
          color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000),
        ),
      ),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
