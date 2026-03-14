// D4rt test script: Tests PointerScrollEvent concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PointerScrollEvent test executing');
  final results = <String>[];

  // ========== PointerScrollEvent Tests ==========
  print('Testing PointerScrollEvent...');

  // Test 1: Create basic PointerScrollEvent
  final scrollEvent1 = PointerScrollEvent(
    position: Offset(200.0, 300.0),
    scrollDelta: Offset(0.0, -120.0),
  );
  assert(scrollEvent1 is PointerEvent, 'Should be PointerEvent');
  assert(scrollEvent1 is PointerSignalEvent, 'Should be PointerSignalEvent');
  results.add('PointerScrollEvent created');
  print('PointerScrollEvent created: ${scrollEvent1.runtimeType}');

  // Test 2: Position property
  assert(
    scrollEvent1.position == Offset(200.0, 300.0),
    'Position should match',
  );
  results.add('position: ${scrollEvent1.position}');
  print('Scroll event position: ${scrollEvent1.position}');

  // Test 3: ScrollDelta property
  assert(
    scrollEvent1.scrollDelta == Offset(0.0, -120.0),
    'ScrollDelta should match',
  );
  results.add('scrollDelta: ${scrollEvent1.scrollDelta}');
  print('Scroll event scrollDelta: ${scrollEvent1.scrollDelta}');

  // Test 4: Vertical scroll up
  final scrollUp = PointerScrollEvent(
    position: Offset(150.0, 200.0),
    scrollDelta: Offset(0.0, -60.0),
  );
  assert(scrollUp.scrollDelta.dy < 0, 'Scroll up should have negative dy');
  results.add('scroll up dy: ${scrollUp.scrollDelta.dy}');
  print('Scroll up event: ${scrollUp.scrollDelta}');

  // Test 5: Vertical scroll down
  final scrollDown = PointerScrollEvent(
    position: Offset(150.0, 200.0),
    scrollDelta: Offset(0.0, 60.0),
  );
  assert(scrollDown.scrollDelta.dy > 0, 'Scroll down should have positive dy');
  results.add('scroll down dy: ${scrollDown.scrollDelta.dy}');
  print('Scroll down event: ${scrollDown.scrollDelta}');

  // Test 6: Horizontal scroll left
  final scrollLeft = PointerScrollEvent(
    position: Offset(150.0, 200.0),
    scrollDelta: Offset(-40.0, 0.0),
  );
  assert(scrollLeft.scrollDelta.dx < 0, 'Scroll left should have negative dx');
  results.add('scroll left dx: ${scrollLeft.scrollDelta.dx}');
  print('Scroll left event: ${scrollLeft.scrollDelta}');

  // Test 7: Horizontal scroll right
  final scrollRight = PointerScrollEvent(
    position: Offset(150.0, 200.0),
    scrollDelta: Offset(40.0, 0.0),
  );
  assert(
    scrollRight.scrollDelta.dx > 0,
    'Scroll right should have positive dx',
  );
  results.add('scroll right dx: ${scrollRight.scrollDelta.dx}');
  print('Scroll right event: ${scrollRight.scrollDelta}');

  // Test 8: Diagonal scroll
  final scrollDiagonal = PointerScrollEvent(
    position: Offset(150.0, 200.0),
    scrollDelta: Offset(30.0, -45.0),
  );
  assert(
    scrollDiagonal.scrollDelta.dx != 0 && scrollDiagonal.scrollDelta.dy != 0,
    'Should be diagonal',
  );
  results.add('diagonal: ${scrollDiagonal.scrollDelta}');
  print('Diagonal scroll event: ${scrollDiagonal.scrollDelta}');

  // Test 9: TimeStamp property
  final scrollTime = PointerScrollEvent(
    position: Offset(100.0, 120.0),
    scrollDelta: Offset(0.0, -30.0),
    timeStamp: Duration(milliseconds: 500),
  );
  assert(
    scrollTime.timeStamp == Duration(milliseconds: 500),
    'TimeStamp should match',
  );
  results.add('timeStamp: ${scrollTime.timeStamp}');
  print('Scroll event timeStamp: ${scrollTime.timeStamp}');

  // Test 10: Device property
  final scrollDevice = PointerScrollEvent(
    position: Offset(180.0, 220.0),
    scrollDelta: Offset(0.0, -20.0),
    device: 3,
  );
  assert(scrollDevice.device == 3, 'Device should be 3');
  results.add('device: ${scrollDevice.device}');
  print('Scroll event device: ${scrollDevice.device}');

  // Test 11: Kind property (usually mouse for scroll)
  final scrollKind = PointerScrollEvent(
    position: Offset(160.0, 190.0),
    scrollDelta: Offset(0.0, -50.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(scrollKind.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('kind: ${scrollKind.kind}');
  print('Scroll event kind: ${scrollKind.kind}');

  // Test 12: Down property should be false
  assert(scrollEvent1.down == false, 'Down should be false for scroll event');
  results.add('down: ${scrollEvent1.down}');
  print('Scroll event down: ${scrollEvent1.down}');

  // Test 13: Pointer ID
  final scrollPointer = PointerScrollEvent(
    position: Offset(70.0, 80.0),
    scrollDelta: Offset(0.0, -15.0),
    pointer: 99,
  );
  assert(scrollPointer.pointer == 99, 'Pointer should be 99');
  results.add('pointer: ${scrollPointer.pointer}');
  print('Scroll event pointer: ${scrollPointer.pointer}');

  // Test 14: Scroll delta magnitude
  final deltaMagnitude = scrollEvent1.scrollDelta.distance;
  results.add('scroll magnitude: ${deltaMagnitude.toStringAsFixed(2)}');
  print('Scroll delta magnitude: $deltaMagnitude');

  // Test 15: EmbedderId property
  final scrollEmbed = PointerScrollEvent(
    position: Offset(50, 60),
    scrollDelta: Offset(0, -25),
    embedderId: 111,
  );
  assert(scrollEmbed.embedderId == 111, 'EmbedderId should be 111');
  results.add('embedderId: ${scrollEmbed.embedderId}');
  print('Scroll event embedderId: ${scrollEmbed.embedderId}');

  // Test 16: Accumulated scroll tracking
  var totalScroll = Offset.zero;
  final scrollDeltas = [Offset(0, -20), Offset(0, -30), Offset(0, -10)];
  for (final delta in scrollDeltas) {
    totalScroll += delta;
  }
  assert(totalScroll == Offset(0, -60), 'Total scroll should be -60');
  results.add('accumulated scroll: $totalScroll');
  print('Accumulated scroll: $totalScroll');

  // Test 17: LocalPosition property
  results.add('localPosition: ${scrollEvent1.localPosition}');
  print('Scroll event localPosition: ${scrollEvent1.localPosition}');

  // Test 18: Buttons property
  results.add('buttons: ${scrollEvent1.buttons}');
  print('Scroll event buttons: ${scrollEvent1.buttons}');

  // Test 19: Synthesized property
  results.add('synthesized: ${scrollEvent1.synthesized}');
  print('Scroll event synthesized: ${scrollEvent1.synthesized}');

  // Test 20: Scroll with trackpad kind
  final scrollTrackpad = PointerScrollEvent(
    position: Offset(140, 160),
    scrollDelta: Offset(10, -35),
    kind: PointerDeviceKind.trackpad,
  );
  assert(
    scrollTrackpad.kind == PointerDeviceKind.trackpad,
    'Kind should be trackpad',
  );
  results.add('trackpad kind: ${scrollTrackpad.kind}');
  print('Scroll event with trackpad kind: ${scrollTrackpad.kind}');

  print('PointerScrollEvent test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerScrollEvent Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
