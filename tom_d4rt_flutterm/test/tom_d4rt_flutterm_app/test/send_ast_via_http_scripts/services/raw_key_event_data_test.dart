// D4rt test script: Tests RawKeyEventData base class from services
// ignore_for_file: deprecated_member_use
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventData test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Verify RawKeyEventData is abstract - use concrete implementation
  print('\n--- Test 1: Verify RawKeyEventData via concrete implementation ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA',
      key: 'a',
      location: 0,
      metaState: 0,
      keyCode: 65,
    );
    assert(data is RawKeyEventData);
    print('RawKeyEventDataWeb is RawKeyEventData: true');
    print('Runtime type: ${data.runtimeType}');
    results.add('Test 1 PASSED: Abstract class verification');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test logicalKey property from base class
  print('\n--- Test 2: Test logicalKey property ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final logicalKey = data.logicalKey;
    assert(logicalKey is LogicalKeyboardKey);
    print('Logical key: ${logicalKey.debugName}');
    print('Key ID: ${logicalKey.keyId}');
    results.add('Test 2 PASSED: LogicalKey property');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test physicalKey property from base class
  print('\n--- Test 3: Test physicalKey property ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final physicalKey = data.physicalKey;
    assert(physicalKey is PhysicalKeyboardKey);
    print('Physical key: ${physicalKey.debugName}');
    print('USB HID: ${physicalKey.usbHidUsage}');
    results.add('Test 3 PASSED: PhysicalKey property');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test keyLabel property
  print('\n--- Test 4: Test keyLabel property ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final keyLabel = data.keyLabel;
    print('Key label: "$keyLabel"');
    results.add('Test 4 PASSED: KeyLabel property');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Verify different platform implementations
  print('\n--- Test 5: Verify platform implementations ---');
  try {
    final implementations = <RawKeyEventData>[
      RawKeyEventDataWeb(code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65),
      RawKeyEventDataAndroid(flags: 0, codePoint: 97, plainCodePoint: 97, keyCode: 29,
        scanCode: 30, metaState: 0, eventSource: 0, vendorId: 0, productId: 0, deviceId: 0, repeatCount: 0),
      RawKeyEventDataFuchsia(hidUsage: 4, codePoint: 97, modifiers: 0),
      RawKeyEventDataIos(characters: 'a', charactersIgnoringModifiers: 'a', keyCode: 0, modifiers: 0),
      RawKeyEventDataMacOs(characters: 'a', charactersIgnoringModifiers: 'a', keyCode: 0, modifiers: 0),
      RawKeyEventDataLinux(keyHelper: const GtkKeyHelper(), unicodeScalarValues: 97,
        scanCode: 38, keyCode: 38, modifiers: 0, isDown: true),
      RawKeyEventDataWindows(keyCode: 65, scanCode: 30, characterCodePoint: 97, modifiers: 0),
    ];
    for (final impl in implementations) {
      assert(impl is RawKeyEventData);
      print('${impl.runtimeType} extends RawKeyEventData');
    }
    print('Total implementations tested: ${implementations.length}');
    results.add('Test 5 PASSED: Platform implementations');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test modifier key detection
  print('\n--- Test 6: Test modifier key detection ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'A', location: 0,
      metaState: 1,
      keyCode: 65,
    );
    print('isShiftPressed: ${data.isShiftPressed}');
    print('isControlPressed: ${data.isControlPressed}');
    print('isAltPressed: ${data.isAltPressed}');
    print('isMetaPressed: ${data.isMetaPressed}');
    results.add('Test 6 PASSED: Modifier detection');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test modifiersPressed getter
  print('\n--- Test 7: Test modifiersPressed getter ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'A', location: 0, metaState: 0, keyCode: 65,
    );
    final modifiers = data.modifiersPressed;
    print('Modifiers pressed: $modifiers');
    print('Modifiers count: ${modifiers.length}');
    results.add('Test 7 PASSED: ModifiersPressed getter');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Test shouldDispatchKeyEvent
  print('\n--- Test 8: Test shouldDispatchKeyEvent ---');
  try {
    final data = RawKeyEventDataWeb(
      code: 'KeyA', key: 'a', location: 0, metaState: 0, keyCode: 65,
    );
    final shouldDispatch = data.shouldDispatchEvent();
    print('Should dispatch event: $shouldDispatch');
    results.add('Test 8 PASSED: ShouldDispatchKeyEvent');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawKeyEventData test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('RawKeyEventData Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Passed: $testsPassed, Failed: $testsFailed', style: TextStyle(color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000))),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
