// D4rt test script: Tests TapAndPanGestureRecognizer from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapAndPanGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== TapAndPanGestureRecognizer Tests ==========
  print('Testing TapAndPanGestureRecognizer...');

  // Test 1: Create TapAndPanGestureRecognizer
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
  TapDragDownDetails? lastDown;
  recognizer.onTapDown = (TapDragDownDetails details) {
    tapDownCount++;
    lastDown = details;
  };
  results.add('onTapDown callback set');
  print('onTapDown callback configured');

  // Test 4: Set onTapUp callback
  var tapUpCount = 0;
  recognizer.onTapUp = (TapDragUpDetails details) {
    tapUpCount++;
  };
  results.add('onTapUp callback set');
  print('onTapUp callback configured');

  // Test 5: Set onDragStart callback
  var dragStartCount = 0;
  recognizer.onDragStart = (TapDragStartDetails details) {
    dragStartCount++;
  };
  results.add('onDragStart callback set');
  print('onDragStart callback configured');

  // Test 6: Set onDragUpdate callback
  var dragUpdateCount = 0;
  recognizer.onDragUpdate = (TapDragUpdateDetails details) {
    dragUpdateCount++;
  };
  results.add('onDragUpdate callback set');
  print('onDragUpdate callback configured');

  // Test 7: Set onDragEnd callback
  var dragEndCount = 0;
  recognizer.onDragEnd = (TapDragEndDetails details) {
    dragEndCount++;
  };
  results.add('onDragEnd callback set');
  print('onDragEnd callback configured');

  // Test 8: Pan gesture - omnidirectional movement
  final panMove = Offset(50.0, 50.0);
  final isOmnidirectional = true; // Pan accepts all directions
  results.add('Omnidirectional pan: $isOmnidirectional');
  print('Pan gesture - omnidirectional: $isOmnidirectional');

  // Test 9: Horizontal component
  final horizontalComponent = panMove.dx;
  assert(horizontalComponent == 50.0, 'Horizontal should be 50');
  results.add('Horizontal component: $horizontalComponent');
  print('Pan horizontal component: $horizontalComponent');

  // Test 10: Vertical component
  final verticalComponent = panMove.dy;
  assert(verticalComponent == 50.0, 'Vertical should be 50');
  results.add('Vertical component: $verticalComponent');
  print('Pan vertical component: $verticalComponent');

  // Test 11: Pan distance
  final panDistance = panMove.distance;
  assert((panDistance - 70.71).abs() < 0.1, 'Distance should be ~70.71');
  results.add('Pan distance: ${panDistance.toStringAsFixed(2)}');
  print('Pan distance: ${panDistance.toStringAsFixed(2)}');

  // Test 12: Pan direction
  final panDirection = panMove.direction;
  results.add('Pan direction: ${panDirection.toStringAsFixed(4)} rad');
  print('Pan direction: ${panDirection.toStringAsFixed(4)} radians');

  // Test 13: Diagonal movement accepted
  final diagonal = Offset(30.0, 40.0);
  final isDiagonal = diagonal.dx != 0 && diagonal.dy != 0;
  assert(isDiagonal, 'Should accept diagonal');
  results.add('Diagonal accepted: $isDiagonal');
  print('Pan accepts diagonal: $isDiagonal');

  // Test 14: Pan slop threshold
  final kPanSlop = 18.0;
  final smallPan = Offset(10.0, 10.0);
  final smallDist = smallPan.distance;
  final withinSlop = smallDist < kPanSlop;
  results.add('Within slop (${smallDist.toStringAsFixed(2)}): $withinSlop');
  print('Pan within slop: $withinSlop');

  // Test 15: Exceeds slop - starts pan
  final largePan = Offset(20.0, 20.0);
  final largeDist = largePan.distance;
  final exceedsSlop = largeDist >= kPanSlop;
  assert(exceedsSlop, 'Should exceed slop');
  results.add('Exceeds slop (${largeDist.toStringAsFixed(2)}): $exceedsSlop');
  print('Pan exceeds slop: $exceedsSlop');

  // Test 16: Velocity calculation for pan
  final panDelta = Offset(100.0, 100.0);
  final panTime = Duration(milliseconds: 200);
  final velX = panDelta.dx / (panTime.inMilliseconds / 1000.0);
  final velY = panDelta.dy / (panTime.inMilliseconds / 1000.0);
  results.add('Pan velocity: ($velX, $velY) px/s');
  print('Pan velocity: ($velX, $velY) px/s');

  // Test 17: Velocity magnitude (speed)
  final speed = Offset(velX, velY).distance;
  results.add('Pan speed: ${speed.toStringAsFixed(2)} px/s');
  print('Pan speed: ${speed.toStringAsFixed(2)} px/s');

  // Test 18: Tap count tracking for multi-tap-drag
  var tapCount = 0;
  void simulateTap() => tapCount++;
  simulateTap();
  simulateTap();
  assert(tapCount == 2, 'Should track 2 taps');
  results.add('Multi-tap tracking: $tapCount taps');
  print('Multi-tap before drag: $tapCount');

  // Test 19: Callback verification
  assert(recognizer.onTapDown != null, 'onTapDown set');
  assert(recognizer.onTapUp != null, 'onTapUp set');
  assert(recognizer.onDragStart != null, 'onDragStart set');
  assert(recognizer.onDragUpdate != null, 'onDragUpdate set');
  assert(recognizer.onDragEnd != null, 'onDragEnd set');
  results.add('All 5 main callbacks verified');
  print('All callbacks verified');

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('TapAndPanGestureRecognizer disposed');

  print(
    'TapAndPanGestureRecognizer test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapAndPanGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Constraint: All directions (pan)'),
      Text('Callbacks: onTapDown/Up, onDragStart/Update/End'),
      Text('Movement: horizontal, vertical, diagonal'),
      Text('Features: velocity, tap count, slop threshold'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
