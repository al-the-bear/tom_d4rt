// D4rt test script: Tests SerialTapGestureRecognizer concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SerialTapGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== SerialTapGestureRecognizer Tests ==========
  print('Testing SerialTapGestureRecognizer...');

  // Test 1: Create SerialTapGestureRecognizer
  final recognizer = SerialTapGestureRecognizer();
  assert(recognizer != null, 'Should create SerialTapGestureRecognizer');
  results.add('SerialTapGestureRecognizer created');
  print('SerialTapGestureRecognizer created: ${recognizer.runtimeType}');

  // Test 2: Check inheritance
  assert(recognizer is GestureRecognizer, 'Should be GestureRecognizer');
  results.add('Inheritance: GestureRecognizer');
  print('Inheritance verified: GestureRecognizer');

  // Test 3: Set onSerialTapDown callback
  var serialTapDownCount = 0;
  SerialTapDownDetails? lastDownDetails;
  recognizer.onSerialTapDown = (SerialTapDownDetails details) {
    serialTapDownCount++;
    lastDownDetails = details;
  };
  results.add('onSerialTapDown callback set');
  print('onSerialTapDown callback configured');

  // Test 4: Set onSerialTapUp callback
  var serialTapUpCount = 0;
  SerialTapUpDetails? lastUpDetails;
  recognizer.onSerialTapUp = (SerialTapUpDetails details) {
    serialTapUpCount++;
    lastUpDetails = details;
  };
  results.add('onSerialTapUp callback set');
  print('onSerialTapUp callback configured');

  // Test 5: Set onSerialTapCancel callback
  var serialTapCancelCount = 0;
  SerialTapCancelDetails? lastCancelDetails;
  recognizer.onSerialTapCancel = (SerialTapCancelDetails details) {
    serialTapCancelCount++;
    lastCancelDetails = details;
  };
  results.add('onSerialTapCancel callback set');
  print('onSerialTapCancel callback configured');

  // Test 6: SerialTapDownDetails construction
  final downDetails = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 1,
    buttons: kPrimaryButton,
  );
  assert(downDetails.globalPosition == Offset(100.0, 200.0), 'Global should match');
  assert(downDetails.count == 1, 'Count should be 1');
  results.add('SerialTapDownDetails: count=${downDetails.count}');
  print('SerialTapDownDetails: global=${downDetails.globalPosition}, count=${downDetails.count}');

  // Test 7: SerialTapDownDetails for double tap
  final doubleTapDown = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 2,
    buttons: kPrimaryButton,
  );
  assert(doubleTapDown.count == 2, 'Count should be 2 for double tap');
  results.add('Double tap count: ${doubleTapDown.count}');
  print('Double tap SerialTapDownDetails: count=${doubleTapDown.count}');

  // Test 8: SerialTapDownDetails for triple tap
  final tripleTapDown = SerialTapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 3,
    buttons: kPrimaryButton,
  );
  assert(tripleTapDown.count == 3, 'Count should be 3 for triple tap');
  results.add('Triple tap count: ${tripleTapDown.count}');
  print('Triple tap SerialTapDownDetails: count=${tripleTapDown.count}');

  // Test 9: SerialTapUpDetails construction
  final upDetails = SerialTapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
    count: 1,
  );
  assert(upDetails.globalPosition == Offset(100.0, 200.0), 'Global should match');
  assert(upDetails.count == 1, 'Count should be 1');
  results.add('SerialTapUpDetails: count=${upDetails.count}');
  print('SerialTapUpDetails: global=${upDetails.globalPosition}, count=${upDetails.count}');

  // Test 10: SerialTapCancelDetails construction
  final cancelDetails = SerialTapCancelDetails(count: 2);
  assert(cancelDetails.count == 2, 'Count should be 2');
  results.add('SerialTapCancelDetails: count=${cancelDetails.count}');
  print('SerialTapCancelDetails: count=${cancelDetails.count}');

  // Test 11: Position and local position relationship
  final globalPos = Offset(300.0, 400.0);
  final localPos = Offset(100.0, 150.0);
  final transform = globalPos - localPos;
  assert(transform == Offset(200.0, 250.0), 'Transform should be (200, 250)');
  results.add('Position transform: $transform');
  print('Global to local transform: $transform');

  // Test 12: Buttons property for different tap types
  assert(kPrimaryButton == 1, 'Primary button is 1');
  assert(kSecondaryButton == 2, 'Secondary button is 2');
  results.add('Button values: primary=$kPrimaryButton, secondary=$kSecondaryButton');
  print('Button values: primary=$kPrimaryButton, secondary=$kSecondaryButton');

  // Test 13: Multiple pointer device kinds
  for (final kind in [PointerDeviceKind.touch, PointerDeviceKind.mouse, PointerDeviceKind.stylus]) {
    final details = SerialTapDownDetails(
      globalPosition: Offset.zero,
      localPosition: Offset.zero,
      kind: kind,
      count: 1,
      buttons: kPrimaryButton,
    );
    assert(details.kind == kind, 'Kind should match');
    print('SerialTapDownDetails with $kind');
  }
  results.add('Device kinds tested: touch, mouse, stylus');

  // Test 14: Tap timing concept
  final tapTimeout = Duration(milliseconds: 300);
  assert(tapTimeout.inMilliseconds == 300, 'Timeout should be 300ms');
  results.add('Tap timeout concept: ${tapTimeout.inMilliseconds}ms');
  print('Double tap timeout concept: ${tapTimeout.inMilliseconds}ms');

  // Test 15: Tap slop distance concept
  final kDoubleTapSlop = 100.0; // typical double tap slop
  final firstTapPos = Offset(100.0, 100.0);
  final secondTapPos = Offset(120.0, 110.0);
  final tapDistance = (secondTapPos - firstTapPos).distance;
  final withinSlop = tapDistance < kDoubleTapSlop;
  assert(withinSlop, 'Taps should be within slop');
  results.add('Tap distance ${tapDistance.toStringAsFixed(2)} within slop: $withinSlop');
  print('Tap slop: distance=${tapDistance.toStringAsFixed(2)}, within=$withinSlop');

  // Test 16: Tap count tracking concept
  var tapCount = 0;
  void simulateTap() {
    tapCount++;
    print('Tap count: $tapCount');
  }
  simulateTap();
  simulateTap();
  simulateTap();
  assert(tapCount == 3, 'Should track 3 taps');
  results.add('Tap count tracking: $tapCount');

  // Test 17: Position hash for tap location grouping
  final posHash1 = Offset(100.0, 100.0).hashCode;
  final posHash2 = Offset(100.0, 100.0).hashCode;
  assert(posHash1 == posHash2, 'Same position same hash');
  results.add('Position hash consistency verified');
  print('Position hash: $posHash1');

  // Test 18: Create recognizer with debugOwner
  final recognizer2 = SerialTapGestureRecognizer(debugOwner: 'TestOwner');
  assert(recognizer2 != null, 'Should create with debugOwner');
  results.add('SerialTapGestureRecognizer with debugOwner');
  print('Created recognizer with debugOwner');
  recognizer2.dispose();

  // Test 19: Callback state verification
  assert(recognizer.onSerialTapDown != null, 'onSerialTapDown should be set');
  assert(recognizer.onSerialTapUp != null, 'onSerialTapUp should be set');
  assert(recognizer.onSerialTapCancel != null, 'onSerialTapCancel should be set');
  results.add('All callbacks verified as set');
  print('Callbacks state verified');

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('SerialTapGestureRecognizer disposed');

  print('SerialTapGestureRecognizer test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SerialTapGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Callbacks: onSerialTapDown, onSerialTapUp, onSerialTapCancel'),
      Text('Details: SerialTapDownDetails, SerialTapUpDetails'),
      Text('Multi-tap: single, double, triple (count property)'),
      Text('Timing: tap timeout, slop distance'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
