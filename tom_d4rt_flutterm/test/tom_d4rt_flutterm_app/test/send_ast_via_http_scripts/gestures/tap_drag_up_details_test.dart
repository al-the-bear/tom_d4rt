// D4rt test script: Tests TapDragUpDetails from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapDragUpDetails comprehensive test executing');
  final results = <String>[];

  // ========== TapDragUpDetails Tests ==========
  print('Testing TapDragUpDetails...');

  // Test 1: Create TapDragUpDetails
  final details = TapDragUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 1,
  );
  assert(details != null, 'Should create details');
  results.add('TapDragUpDetails created');
  print('TapDragUpDetails created');

  // Test 2: Global position property
  assert(details.globalPosition == Offset(100.0, 200.0), 'Global should match');
  results.add('Global position: ${details.globalPosition}');
  print('Global position: ${details.globalPosition}');

  // Test 3: Local position property
  assert(details.localPosition == Offset(50.0, 100.0), 'Local should match');
  results.add('Local position: ${details.localPosition}');
  print('Local position: ${details.localPosition}');

  // Test 4: Kind property
  assert(details.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('Kind: ${details.kind}');
  print('Device kind: ${details.kind}');

  // Test 5: Consecutive tap count
  assert(details.consecutiveTapCount == 1, 'Count should be 1');
  results.add('Consecutive tap count: ${details.consecutiveTapCount}');
  print('Consecutive tap count: ${details.consecutiveTapCount}');

  // Test 6: Double tap up
  final doubleTapUp = TapDragUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 2,
  );
  assert(doubleTapUp.consecutiveTapCount == 2, 'Count should be 2');
  results.add('Double tap up: count=${doubleTapUp.consecutiveTapCount}');
  print('Double tap up: count=${doubleTapUp.consecutiveTapCount}');

  // Test 7: Triple tap up
  final tripleTapUp = TapDragUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 3,
  );
  assert(tripleTapUp.consecutiveTapCount == 3, 'Count should be 3');
  results.add('Triple tap up: count=${tripleTapUp.consecutiveTapCount}');
  print('Triple tap up: count=${tripleTapUp.consecutiveTapCount}');

  // Test 8: Tap completed (not cancelled, not dragged)
  final tapCompleted = details.consecutiveTapCount > 0;
  assert(tapCompleted, 'Tap should be completed');
  results.add('Tap completed: $tapCompleted');
  print('Tap sequence completed: $tapCompleted');

  // Test 9: Mouse device
  final mouseUp = TapDragUpDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.mouse,
    consecutiveTapCount: 1,
  );
  assert(mouseUp.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('Mouse up: ${mouseUp.kind}');
  print('Mouse tap up: kind=${mouseUp.kind}');

  // Test 10: Stylus device
  final stylusUp = TapDragUpDetails(
    globalPosition: Offset(200.0, 300.0),
    localPosition: Offset(100.0, 150.0),
    kind: PointerDeviceKind.stylus,
    consecutiveTapCount: 1,
  );
  assert(stylusUp.kind == PointerDeviceKind.stylus, 'Kind should be stylus');
  results.add('Stylus up: ${stylusUp.kind}');
  print('Stylus tap up: kind=${stylusUp.kind}');

  // Test 11: Position transform
  final transform = details.globalPosition - details.localPosition;
  assert(transform == Offset(50.0, 100.0), 'Transform should match');
  results.add('Position transform: $transform');
  print('Global-local transform: $transform');

  // Test 12: Position from down to up
  final downPos = Offset(100.0, 200.0);
  final upPos = details.globalPosition;
  final movement = (upPos - downPos).distance;
  results.add('Down-to-up distance: ${movement.toStringAsFixed(2)}');
  print('Movement from down to up: ${movement.toStringAsFixed(2)}');

  // Test 13: Tap vs drag determination
  final kTapSlop = 18.0;
  final wasTap = movement < kTapSlop;
  assert(wasTap, 'Should be tap (no movement)');
  results.add('Was tap (< $kTapSlop): $wasTap');
  print('Tap detection: $wasTap');

  // Test 14: Position equality
  final pos1 = details.globalPosition;
  final pos2 = Offset(100.0, 200.0);
  assert(pos1 == pos2, 'Positions should be equal');
  results.add('Position equality: ${pos1 == pos2}');
  print('Position equality check: ${pos1 == pos2}');

  // Test 15: Callback pattern
  TapDragUpDetails? capturedUp;
  void onTapUp(TapDragUpDetails d) {
    capturedUp = d;
  }
  onTapUp(details);
  assert(capturedUp != null, 'Should capture up');
  results.add('Callback pattern works');
  print('Callback captured up details');

  // Test 16: High consecutive count
  final manyTapUp = TapDragUpDetails(
    globalPosition: Offset.zero,
    localPosition: Offset.zero,
    kind: PointerDeviceKind.touch,
    consecutiveTapCount: 5,
  );
  assert(manyTapUp.consecutiveTapCount == 5, 'Count should be 5');
  results.add('High tap count: ${manyTapUp.consecutiveTapCount}');
  print('High consecutive count: ${manyTapUp.consecutiveTapCount}');

  // Test 17: Tap duration concept
  final downTime = Duration(milliseconds: 100);
  final upTime = Duration(milliseconds: 200);
  final tapDuration = upTime - downTime;
  results.add('Tap duration concept: ${tapDuration.inMilliseconds}ms');
  print('Tap duration: ${tapDuration.inMilliseconds}ms');

  // Test 18: All device kinds
  for (final kind in PointerDeviceKind.values) {
    print('Available device kind: $kind');
  }
  results.add('Device kinds enumerated');

  // Test 19: Up without drag (pure tap completion)
  final pureTap = details.consecutiveTapCount >= 1;
  results.add('Pure tap completion: $pureTap');
  print('Pure tap (no drag): $pureTap');

  // Test 20: Summary
  results.add('Properties: globalPosition, localPosition, kind, consecutiveTapCount');
  print('TapDragUpDetails: tap completion when pointer released without drag');

  print('TapDragUpDetails test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapDragUpDetails Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Properties: globalPosition, localPosition'),
      Text('Properties: kind, consecutiveTapCount'),
      Text('Usage: onTapUp callback'),
      Text('Event: tap completed (not cancelled/dragged)'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
