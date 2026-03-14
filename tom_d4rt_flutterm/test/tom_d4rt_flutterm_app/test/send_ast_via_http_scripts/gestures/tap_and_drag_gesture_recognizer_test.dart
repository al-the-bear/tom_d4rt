// D4rt test script: Tests TapAndDragGestureRecognizer concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapAndDragGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== TapAndDragGestureRecognizer Tests ==========
  print('Testing TapAndDragGestureRecognizer...');

  // Test 1: Create TapAndPanGestureRecognizer (concrete implementation)
  final recognizer = TapAndPanGestureRecognizer();
  assert(recognizer != null, 'Should create recognizer');
  results.add('TapAndPanGestureRecognizer created');
  print('TapAndPanGestureRecognizer created: ${recognizer.runtimeType}');

  // Test 2: Check inheritance
  assert(recognizer is GestureRecognizer, 'Should be GestureRecognizer');
  results.add('Inheritance: GestureRecognizer');
  print('Inheritance verified');

  // Test 3: Set onTapDown callback
  var tapDownCount = 0;
  TapDragDownDetails? lastTapDownDetails;
  recognizer.onTapDown = (TapDragDownDetails details) {
    tapDownCount++;
    lastTapDownDetails = details;
  };
  results.add('onTapDown callback set');
  print('onTapDown callback configured');

  // Test 4: Set onTapUp callback
  var tapUpCount = 0;
  TapDragUpDetails? lastTapUpDetails;
  recognizer.onTapUp = (TapDragUpDetails details) {
    tapUpCount++;
    lastTapUpDetails = details;
  };
  results.add('onTapUp callback set');
  print('onTapUp callback configured');

  // Test 5: Set onDragStart callback
  var dragStartCount = 0;
  TapDragStartDetails? lastDragStartDetails;
  recognizer.onDragStart = (TapDragStartDetails details) {
    dragStartCount++;
    lastDragStartDetails = details;
  };
  results.add('onDragStart callback set');
  print('onDragStart callback configured');

  // Test 6: Set onDragUpdate callback
  var dragUpdateCount = 0;
  TapDragUpdateDetails? lastDragUpdateDetails;
  recognizer.onDragUpdate = (TapDragUpdateDetails details) {
    dragUpdateCount++;
    lastDragUpdateDetails = details;
  };
  results.add('onDragUpdate callback set');
  print('onDragUpdate callback configured');

  // Test 7: Set onDragEnd callback
  var dragEndCount = 0;
  TapDragEndDetails? lastDragEndDetails;
  recognizer.onDragEnd = (TapDragEndDetails details) {
    dragEndCount++;
    lastDragEndDetails = details;
  };
  results.add('onDragEnd callback set');
  print('onDragEnd callback configured');

  // Test 8: Set onCancel callback
  var cancelCount = 0;
  recognizer.onCancel = () {
    cancelCount++;
  };
  results.add('onCancel callback set');
  print('onCancel callback configured');

  // Test 9: Position concepts
  final startPos = Offset(100.0, 200.0);
  final currentPos = Offset(150.0, 250.0);
  final dragDelta = currentPos - startPos;
  assert(dragDelta == Offset(50.0, 50.0), 'Delta should match');
  results.add('Drag delta: $dragDelta');
  print('Position tracking: start=$startPos, current=$currentPos, delta=$dragDelta');

  // Test 10: Drag distance calculation
  final distance = dragDelta.distance;
  assert((distance - 70.71).abs() < 0.1, 'Distance should be ~70.71');
  results.add('Drag distance: ${distance.toStringAsFixed(2)}');
  print('Drag distance: ${distance.toStringAsFixed(2)}');

  // Test 11: Tap vs drag threshold
  final kDragSlop = 18.0;
  final smallMove = Offset(5.0, 5.0);
  final smallDist = smallMove.distance;
  final isTap = smallDist < kDragSlop;
  assert(isTap, 'Small movement should be tap');
  results.add('Small movement is tap: $isTap');
  print('Tap detection (< $kDragSlop): distance=${smallDist.toStringAsFixed(2)}, isTap=$isTap');

  // Test 12: Large movement is drag
  final largeDist = dragDelta.distance;
  final isDrag = largeDist >= kDragSlop;
  assert(isDrag, 'Large movement should be drag');
  results.add('Large movement is drag: $isDrag');
  print('Drag detection (>= $kDragSlop): distance=${largeDist.toStringAsFixed(2)}, isDrag=$isDrag');

  // Test 13: Velocity concept
  final timeDelta = Duration(milliseconds: 100);
  final velocityX = dragDelta.dx / (timeDelta.inMilliseconds / 1000.0);
  final velocityY = dragDelta.dy / (timeDelta.inMilliseconds / 1000.0);
  results.add('Velocity: ($velocityX, $velocityY) px/s');
  print('Velocity estimate: ($velocityX, $velocityY) px/s');

  // Test 14: Count property concept (serial taps)
  var tapCount = 1;
  final isDoubleTapDrag = tapCount >= 2;
  results.add('Double-tap-drag: $isDoubleTapDrag');
  print('Tap count for drag: $tapCount, isDoubleTapDrag: $isDoubleTapDrag');

  // Test 15: Consecutive tap tracking
  tapCount++;
  final afterCount = tapCount;
  assert(afterCount == 2, 'Count should increment');
  results.add('Tap count after increment: $afterCount');
  print('Consecutive tap tracking: $afterCount');

  // Test 16: Local vs global position
  final globalPos = Offset(300.0, 400.0);
  final localPos = Offset(100.0, 150.0);
  final transform = globalPos - localPos;
  results.add('Local/global transform: $transform');
  print('Position transform: global=$globalPos, local=$localPos');

  // Test 17: Drag direction detection
  final horizontalDrag = Offset(100.0, 5.0);
  final isHorizontal = horizontalDrag.dx.abs() > horizontalDrag.dy.abs();
  assert(isHorizontal, 'Should be horizontal');
  results.add('Horizontal drag: $isHorizontal');
  print('Drag direction horizontal: $isHorizontal');

  // Test 18: Vertical drag detection
  final verticalDrag = Offset(5.0, 100.0);
  final isVertical = verticalDrag.dy.abs() > verticalDrag.dx.abs();
  assert(isVertical, 'Should be vertical');
  results.add('Vertical drag: $isVertical');
  print('Drag direction vertical: $isVertical');

  // Test 19: Verify all callbacks set
  assert(recognizer.onTapDown != null, 'onTapDown should be set');
  assert(recognizer.onTapUp != null, 'onTapUp should be set');
  assert(recognizer.onDragStart != null, 'onDragStart should be set');
  assert(recognizer.onDragUpdate != null, 'onDragUpdate should be set');
  assert(recognizer.onDragEnd != null, 'onDragEnd should be set');
  results.add('All callbacks verified');
  print('All callbacks verified as set');

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('TapAndPanGestureRecognizer disposed');

  print('TapAndDragGestureRecognizer test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapAndDragGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Callbacks: onTapDown, onTapUp, onCancel'),
      Text('Drag callbacks: onDragStart, onDragUpdate, onDragEnd'),
      Text('Details: TapDragDownDetails, TapDragUpdateDetails, etc.'),
      Text('Concepts: tap count, velocity, direction'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
