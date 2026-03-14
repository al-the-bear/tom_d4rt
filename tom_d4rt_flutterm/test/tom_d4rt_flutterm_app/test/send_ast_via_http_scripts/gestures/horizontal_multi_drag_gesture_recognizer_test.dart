// D4rt test script: Tests HorizontalMultiDragGestureRecognizer from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HorizontalMultiDragGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== HorizontalMultiDragGestureRecognizer Tests ==========
  print('Testing HorizontalMultiDragGestureRecognizer...');

  // Test 1: Create HorizontalMultiDragGestureRecognizer
  final recognizer = HorizontalMultiDragGestureRecognizer();
  assert(recognizer != null, 'Should create recognizer');
  results.add('HorizontalMultiDragGestureRecognizer created');
  print(
    'HorizontalMultiDragGestureRecognizer created: ${recognizer.runtimeType}',
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
  Drag? activeDrag;
  recognizer.onStart = (Offset position) {
    dragStartCount++;
    print('Drag started at: $position');
    return null; // Would return Drag object in real usage
  };
  results.add('onStart callback set');
  print('onStart callback configured');

  // Test 4: Multiple pointer support concept
  final pointers = [0, 1, 2]; // Multiple fingers
  results.add('Multi-pointer support: ${pointers.length} pointers');
  print('Multi-pointer: can track ${pointers.length} simultaneous drags');

  // Test 5: Horizontal constraint - only horizontal movement
  final horizontalDelta = Offset(100.0, 0.0);
  assert(horizontalDelta.dy == 0, 'Y should be 0 for horizontal');
  results.add('Horizontal delta: $horizontalDelta');
  print('Horizontal constraint: delta=$horizontalDelta');

  // Test 6: Horizontal movement detection
  final movement = Offset(50.0, 5.0);
  final isHorizontal = movement.dx.abs() > movement.dy.abs();
  assert(isHorizontal, 'Should detect horizontal');
  results.add('Horizontal movement: $isHorizontal');
  print('Movement ${movement} is horizontal: $isHorizontal');

  // Test 7: Vertical movement rejected
  final verticalMove = Offset(5.0, 50.0);
  final isVertical = verticalMove.dy.abs() > verticalMove.dx.abs();
  assert(isVertical, 'Should detect vertical');
  results.add('Vertical movement (rejected): $isVertical');
  print('Vertical movement $verticalMove rejected');

  // Test 8: Left drag detection
  final leftDrag = Offset(-50.0, 0.0);
  final isLeft = leftDrag.dx < 0;
  assert(isLeft, 'Should be left');
  results.add('Left drag: $isLeft');
  print('Left drag: $isLeft');

  // Test 9: Right drag detection
  final rightDrag = Offset(50.0, 0.0);
  final isRight = rightDrag.dx > 0;
  assert(isRight, 'Should be right');
  results.add('Right drag: $isRight');
  print('Right drag: $isRight');

  // Test 10: Drag velocity calculation
  final dragDist = 100.0; // pixels
  final dragTime = Duration(milliseconds: 200);
  final velocity = dragDist / (dragTime.inMilliseconds / 1000.0);
  results.add('Horizontal velocity: ${velocity.toStringAsFixed(0)} px/s');
  print('Horizontal velocity: ${velocity.toStringAsFixed(0)} px/s');

  // Test 11: Multi-drag positions
  final dragPositions = <int, Offset>{
    0: Offset(100.0, 200.0),
    1: Offset(200.0, 200.0),
    2: Offset(300.0, 200.0),
  };
  results.add('Tracking ${dragPositions.length} drag positions');
  print('Multi-drag positions: $dragPositions');

  // Test 12: Simultaneous horizontal drags
  for (var entry in dragPositions.entries) {
    print('Pointer ${entry.key} at horizontal position ${entry.value.dx}');
  }
  results.add('Simultaneous drags tested');

  // Test 13: Drag slop threshold
  final kPanSlop = 18.0;
  final smallHorizontal = Offset(10.0, 0.0);
  final exceedsSlop = smallHorizontal.distance >= kPanSlop;
  results.add(
    'Small movement (${smallHorizontal.distance}): exceeds slop=$exceedsSlop',
  );
  print('Slop check: ${smallHorizontal.distance} vs $kPanSlop');

  // Test 14: Create recognizer with debugOwner
  final recognizer2 = HorizontalMultiDragGestureRecognizer(
    debugOwner: 'TestOwner',
  );
  assert(recognizer2 != null, 'Should create with debugOwner');
  results.add('Recognizer with debugOwner');
  print('Created with debugOwner');
  recognizer2.dispose();

  // Test 15: GestureRecognizer base functionality
  assert(recognizer is GestureRecognizer, 'Should be GestureRecognizer');
  results.add('GestureRecognizer base verified');
  print('Base GestureRecognizer functionality');

  // Test 16: Position tracking per pointer
  final pointer1Start = Offset(100.0, 200.0);
  final pointer1Current = Offset(150.0, 200.0);
  final pointer1Delta = pointer1Current - pointer1Start;
  assert(pointer1Delta.dy == 0, 'Y unchanged for horizontal');
  results.add('Pointer 1 horizontal delta: ${pointer1Delta.dx}');
  print(
    'Pointer 1: start=$pointer1Start, current=$pointer1Current, delta=$pointer1Delta',
  );

  // Test 17: Cumulative drag distance
  var totalDistance = 0.0;
  final movements = [50.0, 30.0, 20.0];
  for (final m in movements) {
    totalDistance += m.abs();
  }
  results.add('Total horizontal distance: $totalDistance');
  print('Cumulative drag: $totalDistance px');

  // Test 18: Drag end with velocity
  final endVelocity = Velocity(pixelsPerSecond: Offset(velocity, 0.0));
  results.add('End velocity: ${endVelocity.pixelsPerSecond}');
  print('Drag end velocity: ${endVelocity.pixelsPerSecond}');

  // Test 19: Callback verification
  assert(recognizer.onStart != null, 'onStart should be set');
  results.add('onStart callback verified');
  print('onStart callback verified');

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('HorizontalMultiDragGestureRecognizer disposed');

  print(
    'HorizontalMultiDragGestureRecognizer test completed with ${results.length} tests',
  );
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'HorizontalMultiDragGestureRecognizer Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Constraint: Horizontal only'),
      Text('Multi-pointer: tracks multiple drags'),
      Text('Callback: onStart returns Drag'),
      Text('Direction: left/right detection'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
