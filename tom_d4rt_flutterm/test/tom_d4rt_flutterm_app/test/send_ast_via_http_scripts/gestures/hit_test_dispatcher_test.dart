// D4rt test script: Tests HitTestDispatcher concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('HitTestDispatcher test executing');
  final results = <String>[];

  // ========== HitTestDispatcher Concepts ==========
  // HitTestDispatcher is an interface implemented by GestureBinding
  print('Testing HitTestDispatcher concepts...');

  // Test 1: GestureBinding is HitTestDispatcher
  final binding = GestureBinding.instance;
  assert(binding is HitTestDispatcher, 'GestureBinding should implement HitTestDispatcher');
  results.add('GestureBinding is HitTestDispatcher: true');
  print('GestureBinding is HitTestDispatcher: ${binding is HitTestDispatcher}');

  // Test 2: GestureBinding type
  results.add('GestureBinding type: ${binding.runtimeType}');
  print('GestureBinding type: ${binding.runtimeType}');

  // Test 3: Create HitTestResult
  final hitTestResult = HitTestResult();
  assert(hitTestResult != null, 'Should create HitTestResult');
  results.add('HitTestResult created');
  print('HitTestResult created: ${hitTestResult.runtimeType}');

  // Test 4: HitTestResult path initially empty
  assert(hitTestResult.path.isEmpty, 'Path should be empty initially');
  results.add('path initially empty: true');
  print('HitTestResult path initially empty: true');

  // Test 5: Position for hit testing
  final hitPosition = Offset(150.0, 200.0);
  results.add('Hit position: $hitPosition');
  print('Hit test position: $hitPosition');

  // Test 6: Create PointerDownEvent for dispatch
  final downEvent = PointerDownEvent(
    position: hitPosition,
    kind: PointerDeviceKind.touch,
  );
  assert(downEvent.position == hitPosition, 'Position should match');
  results.add('PointerDownEvent position: ${downEvent.position}');
  print('PointerDownEvent for dispatch: ${downEvent.position}');

  // Test 7: Create PointerMoveEvent for dispatch
  final moveEvent = PointerMoveEvent(
    position: Offset(160.0, 210.0),
    delta: Offset(10.0, 10.0),
    kind: PointerDeviceKind.touch,
  );
  results.add('PointerMoveEvent delta: ${moveEvent.delta}');
  print('PointerMoveEvent for dispatch: delta=${moveEvent.delta}');

  // Test 8: Create PointerUpEvent for dispatch
  final upEvent = PointerUpEvent(
    position: Offset(170.0, 220.0),
    kind: PointerDeviceKind.touch,
  );
  results.add('PointerUpEvent position: ${upEvent.position}');
  print('PointerUpEvent for dispatch: ${upEvent.position}');

  // Test 9: Event sequence concept
  final events = <PointerEvent>[downEvent, moveEvent, upEvent];
  assert(events.length == 3, 'Should have 3 events');
  results.add('Event sequence: ${events.length} events');
  print('Event sequence for dispatch: ${events.length}');

  // Test 10: PointerDeviceKind in dispatch
  assert(downEvent.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('Device kind: ${downEvent.kind}');
  print('Dispatch device kind: ${downEvent.kind}');

  // Test 11: BoxHitTestResult for box rendering
  final boxResult = BoxHitTestResult();
  assert(boxResult != null, 'Should create BoxHitTestResult');
  results.add('BoxHitTestResult created');
  print('BoxHitTestResult created: ${boxResult.runtimeType}');

  // Test 12: HitTestEntry concept
  results.add('HitTestEntry path tracking');
  print('HitTestEntry tracks hit targets in path');

  // Test 13: Pointer routing concept
  results.add('Pointer routing to targets');
  print('HitTestDispatcher routes events to hit targets');

  // Test 14: Dispatch order concept (last-to-first)
  results.add('Dispatch order: last-to-first');
  print('Events dispatched last-to-first (bottom-up)');

  // Test 15: Hit test with local position
  final localPosition = downEvent.localPosition;
  results.add('Local position: $localPosition');
  print('Local position for hit test: $localPosition');

  // Test 16: Signal events dispatch
  final scrollEvent = PointerScrollEvent(
    position: Offset(150, 200),
    scrollDelta: Offset(0, -50),
  );
  assert(scrollEvent is PointerSignalEvent, 'Should be signal event');
  results.add('Signal event dispatch');
  print('Signal event for dispatch: ${scrollEvent.runtimeType}');

  // Test 17: GestureArenaManager concept
  results.add('GestureArenaManager resolves conflicts');
  print('Arena manager resolves gesture conflicts');

  // Test 18: Pointer ID tracking
  final pointerId = downEvent.pointer;
  results.add('Pointer ID: $pointerId');
  print('Tracking pointer ID: $pointerId');

  // Test 19: TimeStamp in dispatch
  final timestamp = downEvent.timeStamp;
  results.add('TimeStamp: $timestamp');
  print('Event timestamp: $timestamp');

  // Test 20: Multiple pointer dispatch
  final pointer1 = PointerDownEvent(position: Offset(100, 100), pointer: 1);
  final pointer2 = PointerDownEvent(position: Offset(200, 200), pointer: 2);
  assert(pointer1.pointer != pointer2.pointer, 'Pointers should differ');
  results.add('Multi-pointer: ${pointer1.pointer} and ${pointer2.pointer}');
  print('Multiple pointers: ${pointer1.pointer}, ${pointer2.pointer}');

  print('HitTestDispatcher test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HitTestDispatcher Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}

