// D4rt test script: Tests TapMoveDetails conceptual from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapMoveDetails conceptual test executing');
  final results = <String>[];

  // ========== TapMoveDetails Conceptual Tests ==========
  // TapMoveDetails represents movement during a tap gesture
  print('Testing TapMoveDetails concepts...');

  // Test 1: Offset for global position
  final globalPosition = Offset(150.0, 250.0);
  assert(globalPosition.dx == 150.0, 'dx should be 150.0');
  assert(globalPosition.dy == 250.0, 'dy should be 250.0');
  results.add('Global position: $globalPosition');
  print('Global position: $globalPosition');

  // Test 2: Offset for local position
  final localPosition = Offset(50.0, 100.0);
  assert(localPosition.dx == 50.0, 'dx should be 50.0');
  assert(localPosition.dy == 100.0, 'dy should be 100.0');
  results.add('Local position: $localPosition');
  print('Local position: $localPosition');

  // Test 3: Calculate offset from start
  final startPosition = Offset(100.0, 200.0);
  final currentPosition = Offset(150.0, 250.0);
  final offsetFromStart = currentPosition - startPosition;
  assert(offsetFromStart == Offset(50.0, 50.0), 'Offset should be (50, 50)');
  results.add('Offset from start: $offsetFromStart');
  print('Offset from start: $offsetFromStart');

  // Test 4: Distance calculation
  final distance = offsetFromStart.distance;
  final expectedDistance = 70.71; // sqrt(50^2 + 50^2)
  assert(
    (distance - expectedDistance).abs() < 0.1,
    'Distance should be ~70.71',
  );
  results.add('Distance moved: ${distance.toStringAsFixed(2)}');
  print('Distance moved: ${distance.toStringAsFixed(2)}');

  // Test 5: Direction calculation
  final direction = offsetFromStart.direction;
  results.add('Direction: ${direction.toStringAsFixed(4)} rad');
  print('Direction: ${direction.toStringAsFixed(4)} radians');

  // Test 6: PointerDeviceKind for tap source
  final kind = PointerDeviceKind.touch;
  assert(kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('Device kind: $kind');
  print('Device kind: $kind');

  // Test 7: Movement threshold concept
  final kTouchSlop = 18.0; // typical touch slop value
  final smallMovement = Offset(5.0, 5.0);
  final smallDistance = smallMovement.distance;
  final withinSlop = smallDistance < kTouchSlop;
  assert(withinSlop, 'Small movement should be within slop');
  results.add(
    'Movement ${smallDistance.toStringAsFixed(2)} within slop: $withinSlop',
  );
  print(
    'Movement ${smallDistance.toStringAsFixed(2)}px within slop ($kTouchSlop): $withinSlop',
  );

  // Test 8: Movement exceeds threshold
  final largeMovement = Offset(20.0, 20.0);
  final largeDistance = largeMovement.distance;
  final exceedsSlop = largeDistance > kTouchSlop;
  assert(exceedsSlop, 'Large movement should exceed slop');
  results.add(
    'Movement ${largeDistance.toStringAsFixed(2)} exceeds slop: $exceedsSlop',
  );
  print(
    'Movement ${largeDistance.toStringAsFixed(2)}px exceeds slop ($kTouchSlop): $exceedsSlop',
  );

  // Test 9: Delta for incremental movement
  final previousPosition = Offset(130.0, 220.0);
  final delta = currentPosition - previousPosition;
  assert(delta == Offset(20.0, 30.0), 'Delta should be (20, 30)');
  results.add('Delta: $delta');
  print('Delta from previous: $delta');

  // Test 10: Offset operations
  final scaledOffset = offsetFromStart * 2.0;
  assert(scaledOffset == Offset(100.0, 100.0), 'Scaled should be (100, 100)');
  results.add('Scaled offset (2x): $scaledOffset');
  print('Scaled offset (2x): $scaledOffset');

  // Test 11: Offset division
  final halfOffset = offsetFromStart / 2.0;
  assert(halfOffset == Offset(25.0, 25.0), 'Half should be (25, 25)');
  results.add('Half offset: $halfOffset');
  print('Half offset: $halfOffset');

  // Test 12: Unit vector for direction
  final unitVector = Offset.fromDirection(direction);
  results.add(
    'Unit vector: (${unitVector.dx.toStringAsFixed(3)}, ${unitVector.dy.toStringAsFixed(3)})',
  );
  print('Unit vector: $unitVector');

  // Test 13: Offset.zero constant
  assert(Offset.zero == Offset(0, 0), 'Zero should be (0, 0)');
  results.add('Offset.zero: ${Offset.zero}');
  print('Offset.zero: ${Offset.zero}');

  // Test 14: Offset equality
  final pos1 = Offset(100.0, 200.0);
  final pos2 = Offset(100.0, 200.0);
  assert(pos1 == pos2, 'Equal offsets should be equal');
  results.add('Offset equality: ${pos1 == pos2}');
  print('Offset equality: ${pos1 == pos2}');

  // Test 15: Offset hash code consistency
  assert(
    pos1.hashCode == pos2.hashCode,
    'Equal offsets should have same hashCode',
  );
  results.add('HashCode consistency: ${pos1.hashCode == pos2.hashCode}');
  print('Offset hashCode: ${pos1.hashCode}');

  // Test 16: Horizontal movement detection
  final horizontalMove = Offset(50.0, 2.0);
  final isHorizontal = horizontalMove.dx.abs() > horizontalMove.dy.abs();
  assert(isHorizontal, 'Should be horizontal movement');
  results.add('Horizontal movement: $isHorizontal');
  print('Horizontal movement detected: $isHorizontal');

  // Test 17: Vertical movement detection
  final verticalMove = Offset(2.0, 50.0);
  final isVertical = verticalMove.dy.abs() > verticalMove.dx.abs();
  assert(isVertical, 'Should be vertical movement');
  results.add('Vertical movement: $isVertical');
  print('Vertical movement detected: $isVertical');

  // Test 18: Velocity-like calculation
  final timeDelta = Duration(milliseconds: 16);
  final velocityX = delta.dx / (timeDelta.inMilliseconds / 1000.0);
  final velocityY = delta.dy / (timeDelta.inMilliseconds / 1000.0);
  results.add('Velocity estimate: ($velocityX, $velocityY) px/s');
  print('Velocity estimate: ($velocityX, $velocityY) px/s');

  // Test 19: Multiple device kinds
  final kinds = [
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
  ];
  results.add('Supported device kinds: ${kinds.length}');
  print('Supported device kinds for tap move: $kinds');

  // Test 20: Position clamping concept
  final screenBounds = Rect.fromLTWH(0, 0, 400, 800);
  final clampedX = currentPosition.dx.clamp(
    screenBounds.left,
    screenBounds.right,
  );
  final clampedY = currentPosition.dy.clamp(
    screenBounds.top,
    screenBounds.bottom,
  );
  final clampedPos = Offset(clampedX, clampedY);
  results.add('Clamped position: $clampedPos');
  print('Clamped position to bounds: $clampedPos');

  print(
    'TapMoveDetails conceptual test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TapMoveDetails Conceptual Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Position: global, local'),
      Text('Movement: offset, distance, direction'),
      Text('Detection: horizontal, vertical, slop'),
      Text('Operations: scale, divide, delta'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
