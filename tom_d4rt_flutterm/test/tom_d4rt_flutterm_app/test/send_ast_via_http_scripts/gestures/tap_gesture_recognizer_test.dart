// D4rt test script: Tests TapGestureRecognizer concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TapGestureRecognizer comprehensive test executing');
  final results = <String>[];

  // ========== TapGestureRecognizer Tests ==========
  print('Testing TapGestureRecognizer...');

  // Test 1: Create TapGestureRecognizer
  final recognizer = TapGestureRecognizer();
  assert(recognizer != null, 'Should create TapGestureRecognizer');
  results.add('TapGestureRecognizer created');
  print('TapGestureRecognizer created: ${recognizer.runtimeType}');

  // Test 2: Check inheritance
  assert(recognizer is GestureRecognizer, 'Should be GestureRecognizer');
  assert(recognizer is OneSequenceGestureRecognizer, 'Should be OneSequenceGestureRecognizer');
  results.add('Inheritance verified: GestureRecognizer, OneSequenceGestureRecognizer');
  print('Inheritance: GestureRecognizer, OneSequenceGestureRecognizer');

  // Test 3: Set onTapDown callback
  var tapDownCalled = false;
  TapDownDetails? lastTapDownDetails;
  recognizer.onTapDown = (TapDownDetails details) {
    tapDownCalled = true;
    lastTapDownDetails = details;
  };
  results.add('onTapDown callback set');
  print('onTapDown callback configured');

  // Test 4: Set onTapUp callback
  var tapUpCalled = false;
  TapUpDetails? lastTapUpDetails;
  recognizer.onTapUp = (TapUpDetails details) {
    tapUpCalled = true;
    lastTapUpDetails = details;
  };
  results.add('onTapUp callback set');
  print('onTapUp callback configured');

  // Test 5: Set onTap callback
  var tapCalled = false;
  recognizer.onTap = () {
    tapCalled = true;
  };
  results.add('onTap callback set');
  print('onTap callback configured');

  // Test 6: Set onTapCancel callback
  var tapCancelCalled = false;
  recognizer.onTapCancel = () {
    tapCancelCalled = true;
  };
  results.add('onTapCancel callback set');
  print('onTapCancel callback configured');

  // Test 7: Set onSecondaryTap callback
  var secondaryTapCalled = false;
  recognizer.onSecondaryTap = () {
    secondaryTapCalled = true;
  };
  results.add('onSecondaryTap callback set');
  print('onSecondaryTap callback configured');

  // Test 8: Set onSecondaryTapDown callback
  var secondaryTapDownCalled = false;
  recognizer.onSecondaryTapDown = (TapDownDetails details) {
    secondaryTapDownCalled = true;
  };
  results.add('onSecondaryTapDown callback set');
  print('onSecondaryTapDown callback configured');

  // Test 9: Set onSecondaryTapUp callback
  var secondaryTapUpCalled = false;
  recognizer.onSecondaryTapUp = (TapUpDetails details) {
    secondaryTapUpCalled = true;
  };
  results.add('onSecondaryTapUp callback set');
  print('onSecondaryTapUp callback configured');

  // Test 10: Set onSecondaryTapCancel callback
  var secondaryTapCancelCalled = false;
  recognizer.onSecondaryTapCancel = () {
    secondaryTapCancelCalled = true;
  };
  results.add('onSecondaryTapCancel callback set');
  print('onSecondaryTapCancel callback configured');

  // Test 11: Set onTertiaryTapDown callback
  var tertiaryTapDownCalled = false;
  recognizer.onTertiaryTapDown = (TapDownDetails details) {
    tertiaryTapDownCalled = true;
  };
  results.add('onTertiaryTapDown callback set');
  print('onTertiaryTapDown callback configured');

  // Test 12: Set onTertiaryTapUp callback
  var tertiaryTapUpCalled = false;
  recognizer.onTertiaryTapUp = (TapUpDetails details) {
    tertiaryTapUpCalled = true;
  };
  results.add('onTertiaryTapUp callback set');
  print('onTertiaryTapUp callback configured');

  // Test 13: Set onTertiaryTapCancel callback
  var tertiaryTapCancelCalled = false;
  recognizer.onTertiaryTapCancel = () {
    tertiaryTapCancelCalled = true;
  };
  results.add('onTertiaryTapCancel callback set');
  print('onTertiaryTapCancel callback configured');

  // Test 14: TapDownDetails construction
  final tapDownDetails = TapDownDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.touch,
  );
  assert(tapDownDetails.globalPosition == Offset(100.0, 200.0), 'Global position should match');
  assert(tapDownDetails.localPosition == Offset(50.0, 100.0), 'Local position should match');
  assert(tapDownDetails.kind == PointerDeviceKind.touch, 'Kind should be touch');
  results.add('TapDownDetails: global=${tapDownDetails.globalPosition}, local=${tapDownDetails.localPosition}');
  print('TapDownDetails: global=${tapDownDetails.globalPosition}, local=${tapDownDetails.localPosition}, kind=${tapDownDetails.kind}');

  // Test 15: TapUpDetails construction
  final tapUpDetails = TapUpDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 100.0),
    kind: PointerDeviceKind.mouse,
  );
  assert(tapUpDetails.globalPosition == Offset(100.0, 200.0), 'Global position should match');
  assert(tapUpDetails.localPosition == Offset(50.0, 100.0), 'Local position should match');
  assert(tapUpDetails.kind == PointerDeviceKind.mouse, 'Kind should be mouse');
  results.add('TapUpDetails: global=${tapUpDetails.globalPosition}, local=${tapUpDetails.localPosition}');
  print('TapUpDetails: global=${tapUpDetails.globalPosition}, local=${tapUpDetails.localPosition}, kind=${tapUpDetails.kind}');

  // Test 16: PointerDeviceKind values for tap gestures
  final deviceKinds = PointerDeviceKind.values;
  assert(deviceKinds.contains(PointerDeviceKind.touch), 'Should contain touch');
  assert(deviceKinds.contains(PointerDeviceKind.mouse), 'Should contain mouse');
  assert(deviceKinds.contains(PointerDeviceKind.stylus), 'Should contain stylus');
  results.add('PointerDeviceKind types: ${deviceKinds.length}');
  print('PointerDeviceKind values: $deviceKinds');

  // Test 17: Button constants for tap types
  assert(kPrimaryButton == 1, 'Primary button should be 1');
  assert(kSecondaryButton == 2, 'Secondary button should be 2');
  assert(kTertiaryButton == 4, 'Tertiary button should be 4');
  results.add('Button constants: primary=$kPrimaryButton, secondary=$kSecondaryButton, tertiary=$kTertiaryButton');
  print('Button constants verified: primary=$kPrimaryButton, secondary=$kSecondaryButton, tertiary=$kTertiaryButton');

  // Test 18: Offset calculations for tap positions
  final startPos = Offset(100.0, 100.0);
  final endPos = Offset(105.0, 103.0);
  final tapDistance = (endPos - startPos).distance;
  assert(tapDistance < 20.0, 'Should be within tap tolerance');
  results.add('Tap movement distance: ${tapDistance.toStringAsFixed(2)}');
  print('Tap movement detection: distance=${tapDistance.toStringAsFixed(2)}px');

  // Test 19: Create second recognizer with debugOwner
  final recognizer2 = TapGestureRecognizer(debugOwner: 'TestOwner');
  assert(recognizer2 != null, 'Should create with debugOwner');
  results.add('TapGestureRecognizer with debugOwner created');
  print('TapGestureRecognizer with debugOwner: TestOwner');
  recognizer2.dispose();

  // Test 20: Dispose recognizer
  recognizer.dispose();
  results.add('Recognizer disposed');
  print('TapGestureRecognizer disposed');

  print('TapGestureRecognizer test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapGestureRecognizer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Callbacks: onTap, onTapDown, onTapUp, onTapCancel'),
      Text('Secondary: onSecondaryTap, onSecondaryTapDown/Up/Cancel'),
      Text('Tertiary: onTertiaryTapDown/Up/Cancel'),
      Text('Details: TapDownDetails, TapUpDetails'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
