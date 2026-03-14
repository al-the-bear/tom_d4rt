// D4rt test script: Tests RawKeyEventDataAndroid from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataAndroid test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyEventDataAndroid instance
  print('\n--- Test 1: Create RawKeyEventDataAndroid instance ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    assert(data is RawKeyEventDataAndroid);
    assert(data.keyCode == 29);
    print('Created RawKeyEventDataAndroid successfully');
    print('KeyCode: ${data.keyCode}');
    print('ScanCode: ${data.scanCode}');
    results.add('Test 1 PASSED: Instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test codePoint and character
  print('\n--- Test 2: Test codePoint and character ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 65,
      plainCodePoint: 65,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    print('CodePoint: ${data.codePoint}');
    print('PlainCodePoint: ${data.plainCodePoint}');
    print('Character from codePoint: ${String.fromCharCode(data.codePoint)}');
    results.add('Test 2 PASSED: CodePoint test');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test metaState flags
  print('\n--- Test 3: Test metaState flags ---');
  try {
    final metaShift = 1;
    final metaCtrl = 4096;
    final metaAlt = 2;
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: metaShift | metaCtrl,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    print('MetaState: ${data.metaState}');
    print('Shift flag included: ${(data.metaState & metaShift) != 0}');
    print('Ctrl flag included: ${(data.metaState & metaCtrl) != 0}');
    print('Alt flag included: ${(data.metaState & metaAlt) != 0}');
    results.add('Test 3 PASSED: MetaState flags');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test logical key extraction
  print('\n--- Test 4: Test logical key extraction ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    final logicalKey = data.logicalKey;
    print('Logical key: ${logicalKey.debugName}');
    print('Logical key ID: ${logicalKey.keyId}');
    results.add('Test 4 PASSED: Logical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test physical key extraction
  print('\n--- Test 5: Test physical key extraction ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    final physicalKey = data.physicalKey;
    print('Physical key: ${physicalKey.debugName}');
    print('USB HID: ${physicalKey.usbHidUsage}');
    results.add('Test 5 PASSED: Physical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test repeatCount property
  print('\n--- Test 6: Test repeatCount property ---');
  try {
    final dataNoRepeat = RawKeyEventDataAndroid(
      flags: 0, codePoint: 97, plainCodePoint: 97, keyCode: 29,
      scanCode: 30, metaState: 0, eventSource: 0x101,
      vendorId: 0, productId: 0, deviceId: 0, repeatCount: 0,
    );
    final dataWithRepeat = RawKeyEventDataAndroid(
      flags: 0, codePoint: 97, plainCodePoint: 97, keyCode: 29,
      scanCode: 30, metaState: 0, eventSource: 0x101,
      vendorId: 0, productId: 0, deviceId: 0, repeatCount: 5,
    );
    print('RepeatCount (no repeat): ${dataNoRepeat.repeatCount}');
    print('RepeatCount (with repeat): ${dataWithRepeat.repeatCount}');
    assert(dataNoRepeat.repeatCount == 0);
    assert(dataWithRepeat.repeatCount == 5);
    results.add('Test 6 PASSED: RepeatCount property');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test device identifiers
  print('\n--- Test 7: Test device identifiers ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0, codePoint: 97, plainCodePoint: 97, keyCode: 29,
      scanCode: 30, metaState: 0, eventSource: 0x101,
      vendorId: 1234, productId: 5678, deviceId: 1, repeatCount: 0,
    );
    print('VendorId: ${data.vendorId}');
    print('ProductId: ${data.productId}');
    print('DeviceId: ${data.deviceId}');
    assert(data.vendorId == 1234);
    assert(data.productId == 5678);
    results.add('Test 7 PASSED: Device identifiers');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Verify inheritance from RawKeyEventData
  print('\n--- Test 8: Verify inheritance from RawKeyEventData ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0, codePoint: 97, plainCodePoint: 97, keyCode: 29,
      scanCode: 30, metaState: 0, eventSource: 0x101,
      vendorId: 0, productId: 0, deviceId: 0, repeatCount: 0,
    );
    assert(data is RawKeyEventData);
    print('Inherits from RawKeyEventData: true');
    print('Runtime type: ${data.runtimeType}');
    results.add('Test 8 PASSED: Inheritance verified');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawKeyEventDataAndroid test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('RawKeyEventDataAndroid Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Passed: $testsPassed, Failed: $testsFailed', style: TextStyle(color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000))),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
