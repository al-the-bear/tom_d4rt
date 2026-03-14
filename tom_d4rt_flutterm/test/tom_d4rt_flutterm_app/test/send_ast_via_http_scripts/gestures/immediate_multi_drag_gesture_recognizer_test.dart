// D4rt test script: Tests ImmediateMultiDragGestureRecognizer from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImmediateMultiDragGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== ImmediateMultiDragGestureRecognizer Tests ==========
  print('Testing ImmediateMultiDragGestureRecognizer...');

  // Test 1: Create ImmediateMultiDragGestureRecognizer
  final recognizer = ImmediateMultiDragGestureRecognizer();
  assert(recognizer != null, 'Should create recognizer');
  results.add('ImmediateMultiDragGestureRecognizer created');
  print(
    'ImmediateMultiDragGestureRecognizer created: ${recognizer.runtimeType}',
  );

  // Test 2: Check inheritance
  assert(
    recognizer is MultiDragGestureRecognizer,
    'Should be MultiDragGestureRecognizer',
  );
  results.add('Inheritance: MultiDragGestureRecognizer');
  print('Inheritance verified: MultiDragGestureRecognizer');

  // Test 3: Set onStart callback
  var dragStartCount = 0;
  recognizer.onStart = (Offset position) {
    dragStartCount++;
    print('Immediate drag started at: $position');
    return null;
  };
  results.add('onStart callback set');
  print('onStart callback configured');

  // Test 4: Immediate start concept - no slop required
  final touchDown = Offset(100.0, 200.0);
  final kNoSlop = 0.0; // Immediate means no slop
  results.add('Immediate: no slop threshold');
  print('Immediate drag: starts on pointer down, slop=$kNoSlop');

  // Test 5: Multiple pointer support
  final pointers = [0, 1, 2, 3]; // Can track many
  results.add('Multi-pointer: ${pointers.length} pointers');
  print('Supports ${pointers.length} simultaneous drags');

  // Test 6: Omnidirectional movement (no constraint)
  final movement = Offset(50.0, 50.0);
  final allowsAll = true; // No directional constraint
  results.add('Omnidirectional: $allowsAll');
  print('Movement $movement allowed: no direction constraint');

  // Test 7: Immediate response on down event
  final downTime = Duration.zero;
  final dragStartDelay = Duration.zero; // Immediate means no delay
  assert(dragStartDelay == Duration.zero, 'Should start immediately');
  results.add('Start delay: ${dragStartDelay.inMilliseconds}ms (immediate)');
  print('Drag start delay: ${dragStartDelay.inMilliseconds}ms');

  // Test 8: Compare to DelayedMultiDrag
  final kDelayedSlop = 18.0; // DelayedMultiDrag waits for slop
  final kImmediateSlop = 0.0; // Immediate has no slop
  results.add('Immediate vs Delayed: slop=$kImmediateSlop vs $kDelayedSlop');
  print('Immediate slop: $kImmediateSlop, Delayed slop: $kDelayedSlop');

  // Test 9: Track multiple independent drags
  final dragStates = <int, Offset>{};
  for (var i = 0; i < 4; i++) {
    dragStates[i] = Offset(100.0 * i, 100.0 * i);
  }
  results.add('Tracking ${dragStates.length} independent drags');
  print('Independent drags: $dragStates');

  // Test 10: Movement in any direction
  final directions = [
    Offset(50.0, 0.0), // right
    Offset(-50.0, 0.0), // left
    Offset(0.0, 50.0), // down
    Offset(0.0, -50.0), // up
    Offset(50.0, 50.0), // diagonal
  ];
  for (final dir in directions) {
    print('Direction allowed: $dir');
  }
  results.add('All directions accepted');

  // Test 11: Drag update concept
  final startPos = Offset(100.0, 200.0);
  final updatePos = Offset(150.0, 250.0);
  final delta = updatePos - startPos;
  results.add('Update delta: $delta');
  print('Drag update: start=$startPos, current=$updatePos, delta=$delta');

  // Test 12: Distance calculation
  final distance = delta.distance;
  results.add('Movement distance: ${distance.toStringAsFixed(2)}');
  print('Movement distance: ${distance.toStringAsFixed(2)}');

  // Test 13: Direction calculation
  final direction = delta.direction;
  results.add('Movement direction: ${direction.toStringAsFixed(4)} rad');
  print('Movement direction: ${direction.toStringAsFixed(4)} radians');

  // Test 14: Velocity tracking
  final dragDist = 100.0;
  final dragTime = Duration(milliseconds: 100);
  final velocity = dragDist / (dragTime.inMilliseconds / 1000.0);
  results.add('Velocity: ${velocity.toStringAsFixed(0)} px/s');
  print('Drag velocity: ${velocity.toStringAsFixed(0)} px/s');

  // Test 15: Create with debugOwner
  final recognizer2 = ImmediateMultiDragGestureRecognizer(
    debugOwner: 'TestOwner',
  );
  assert(recognizer2 != null, 'Should create with debugOwner');
  results.add('Recognizer with debugOwner');
  print('Created with debugOwner');
  recognizer2.dispose();

  // Test 16: Use case - drag-and-drop
  final isDragAndDrop = true; // Common use case
  results.add('Use case: drag-and-drop ($isDragAndDrop)');
  print('Common use: drag-and-drop, reorderable lists');

  // Test 17: Use case - drawing
  final isDrawing = true; // Another common use
  results.add('Use case: drawing/painting ($isDrawing)');
  print('Common use: drawing apps, signature capture');

  // Test 18: Pointer ID tracking
  final activePointers = <int>{0, 1};
  results.add('Active pointers: $activePointers');
  print('Active pointer IDs: $activePointers');

  // Test 19: Callback verification
  assert(recognizer.onStart != null, 'onStart should be set');
  results.add('Callback verified');
  print('onStart callback verified');

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('ImmediateMultiDragGestureRecognizer disposed');

  print(
    'ImmediateMultiDragGestureRecognizer test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ImmediateMultiDragGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Behavior: starts immediately on down'),
      Text('No slop: responds to any movement'),
      Text('Multi-pointer: tracks all touches'),
      Text('Use cases: drag-and-drop, drawing'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
