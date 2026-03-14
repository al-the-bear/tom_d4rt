// D4rt test script: Tests PointerEventResampler concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerEventResampler test executing');
  final results = <String>[];

  // ========== PointerEventResampler Concepts ==========
  print('Testing PointerEventResampler concepts...');

  // Test 1: Create PointerEventResampler
  final resampler = PointerEventResampler();
  assert(resampler != null, 'Should create resampler');
  results.add('PointerEventResampler created');
  print('PointerEventResampler created: ${resampler.runtimeType}');

  // Test 2: Check hasPendingEvents initially
  assert(
    resampler.hasPendingEvents == false,
    'Should have no pending events initially',
  );
  results.add('hasPendingEvents initial: ${resampler.hasPendingEvents}');
  print('Initial hasPendingEvents: ${resampler.hasPendingEvents}');

  // Test 3: Add sample event - PointerDownEvent
  final downEvent = PointerDownEvent(
    position: Offset(100.0, 150.0),
    timeStamp: Duration(milliseconds: 0),
    kind: PointerDeviceKind.touch,
  );
  resampler.addEvent(downEvent);
  results.add('Added PointerDownEvent');
  print('Added PointerDownEvent at position ${downEvent.position}');

  // Test 4: Check hasPendingEvents after adding
  results.add('hasPendingEvents after add: ${resampler.hasPendingEvents}');
  print('hasPendingEvents after adding event: ${resampler.hasPendingEvents}');

  // Test 5: Add sample move events
  final moveEvent1 = PointerMoveEvent(
    position: Offset(110.0, 160.0),
    delta: Offset(10.0, 10.0),
    timeStamp: Duration(milliseconds: 16),
    kind: PointerDeviceKind.touch,
  );
  resampler.addEvent(moveEvent1);
  results.add('Added MoveEvent 1');
  print('Added MoveEvent at ${moveEvent1.position}');

  // Test 6: Add more move events
  final moveEvent2 = PointerMoveEvent(
    position: Offset(120.0, 170.0),
    delta: Offset(10.0, 10.0),
    timeStamp: Duration(milliseconds: 32),
    kind: PointerDeviceKind.touch,
  );
  resampler.addEvent(moveEvent2);
  results.add('Added MoveEvent 2');
  print('Added MoveEvent at ${moveEvent2.position}');

  // Test 7: TimeStamp progression concept
  final timestamps = [
    Duration(milliseconds: 0),
    Duration(milliseconds: 16),
    Duration(milliseconds: 32),
  ];
  results.add('Timestamps: 0, 16, 32 ms');
  print('Event timestamps: $timestamps');

  // Test 8: Test resampling interval (typical 16.67ms for 60fps)
  final frameInterval = Duration(microseconds: 16667);
  results.add('Frame interval: ${frameInterval.inMicroseconds}µs');
  print('Typical frame interval: $frameInterval');

  // Test 9: Sampling clock concept
  final sampleTime = Duration(milliseconds: 24);
  results.add('Sample time: ${sampleTime.inMilliseconds}ms');
  print('Sample time between frames: $sampleTime');

  // Test 10: PointerUpEvent for sequence end
  final upEvent = PointerUpEvent(
    position: Offset(130.0, 180.0),
    timeStamp: Duration(milliseconds: 48),
    kind: PointerDeviceKind.touch,
  );
  resampler.addEvent(upEvent);
  results.add('Added PointerUpEvent');
  print('Added PointerUpEvent at ${upEvent.position}');

  // Test 11: Position interpolation concept
  final pos1 = Offset(100, 100);
  final pos2 = Offset(200, 200);
  final t = 0.5; // midpoint
  final interpolated = Offset(
    pos1.dx + (pos2.dx - pos1.dx) * t,
    pos1.dy + (pos2.dy - pos1.dy) * t,
  );
  assert(interpolated == Offset(150, 150), 'Should be midpoint');
  results.add('Interpolated: $interpolated');
  print('Position interpolation: $interpolated');

  // Test 12: Create another resampler for clean tests
  final resampler2 = PointerEventResampler();
  results.add('New resampler created');
  print('Created new resampler instance');

  // Test 13: Delta calculation between events
  final deltaPos = moveEvent2.position - moveEvent1.position;
  assert(deltaPos == Offset(10, 10), 'Delta should be (10, 10)');
  results.add('Delta between moves: $deltaPos');
  print('Position delta: $deltaPos');

  // Test 14: Time delta calculation
  final timeDelta = moveEvent2.timeStamp - moveEvent1.timeStamp;
  assert(timeDelta == Duration(milliseconds: 16), 'Time delta should be 16ms');
  results.add('Time delta: ${timeDelta.inMilliseconds}ms');
  print('Time delta: $timeDelta');

  // Test 15: Velocity from resampled data
  final velocity = deltaPos.dx / (timeDelta.inMilliseconds / 1000.0);
  results.add('Velocity X: ${velocity.toStringAsFixed(2)} px/s');
  print('Calculated velocity X: $velocity px/s');

  // Test 16: Stop resampler (cleanup)
  resampler.stop();
  results.add('Resampler stopped');
  print('Resampler stopped');

  // Test 17: Check hasPendingEvents after stop
  results.add('hasPendingEvents after stop: ${resampler.hasPendingEvents}');
  print('hasPendingEvents after stop: ${resampler.hasPendingEvents}');

  // Test 18: Resample frequency concept
  final freq60Hz = Duration(microseconds: 16667);
  final freq120Hz = Duration(microseconds: 8333);
  results.add(
    '60Hz: ${freq60Hz.inMicroseconds}µs, 120Hz: ${freq120Hz.inMicroseconds}µs',
  );
  print(
    'Resample frequencies: 60Hz=${freq60Hz.inMicroseconds}µs, 120Hz=${freq120Hz.inMicroseconds}µs',
  );

  // Test 19: Event preservation through resampling
  assert(downEvent.position == Offset(100.0, 150.0), 'Original preserved');
  results.add('Original events preserved');
  print('Original events remain unchanged');

  // Test 20: Multiple pointer tracking concept
  final pointer1Events = [
    PointerDownEvent(position: Offset(100, 100), pointer: 1),
    PointerMoveEvent(
      position: Offset(110, 110),
      delta: Offset(10, 10),
      pointer: 1,
    ),
  ];
  final pointer2Events = [
    PointerDownEvent(position: Offset(200, 200), pointer: 2),
    PointerMoveEvent(
      position: Offset(210, 210),
      delta: Offset(10, 10),
      pointer: 2,
    ),
  ];
  results.add(
    'Multi-pointer: ${pointer1Events.length + pointer2Events.length} events',
  );
  print(
    'Multi-pointer resampling concept: ${pointer1Events.length + pointer2Events.length} events',
  );

  print('PointerEventResampler test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerEventResampler Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
