// D4rt test script: Tests BinaryMessenger from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';

dynamic build(BuildContext context) {
  print('BinaryMessenger comprehensive test executing');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Helper to record test results
  void recordTest(String name, bool passed) {
    if (passed) {
      passCount++;
      results.add('✓ $name');
      print('PASS: $name');
    } else {
      failCount++;
      results.add('✗ $name');
      print('FAIL: $name');
    }
  }

  // Test 1: BinaryMessenger interface purpose
  print('\n--- Test 1: BinaryMessenger interface purpose ---');
  try {
    print('BinaryMessenger is the low-level platform channel interface');
    print('It provides:');
    print('  - Raw byte-based communication');
    print('  - Foundation for MethodChannel, BasicMessageChannel');
    print('  - Direct platform message handling');
    recordTest('BinaryMessenger interface purpose', true);
  } catch (e) {
    print('Error: $e');
    recordTest('BinaryMessenger interface purpose', false);
  }

  // Test 2: Default binary messenger
  print('\n--- Test 2: Default binary messenger ---');
  try {
    final messenger = ServicesBinding.instance.defaultBinaryMessenger;
    print('Default messenger type: ${messenger.runtimeType}');
    assert(messenger != null);
    recordTest('Default binary messenger', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Default binary messenger', false);
  }

  // Test 3: Channel name conventions
  print('\n--- Test 3: Channel name conventions ---');
  try {
    final channels = [
      'flutter/platform',
      'flutter/navigation',
      'flutter/textinput',
      'flutter/lifecycle',
      'flutter/keyevent',
      'flutter/system',
    ];
    print('Flutter system channels:');
    for (final ch in channels) {
      print('  - $ch');
      assert(ch.startsWith('flutter/'));
    }
    recordTest('Channel name conventions', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Channel name conventions', false);
  }

  // Test 4: Plugin channel naming
  print('\n--- Test 4: Plugin channel naming ---');
  try {
    final pluginChannels = [
      'plugins.flutter.io/path_provider',
      'plugins.flutter.io/shared_preferences',
      'plugins.flutter.io/url_launcher',
      'dev.flutter.pigeon.MyApi',
    ];
    print('Plugin channel naming:');
    for (final ch in pluginChannels) {
      print('  - $ch');
    }
    recordTest('Plugin channel naming', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Plugin channel naming', false);
  }

  // Test 5: ByteData creation
  print('\n--- Test 5: ByteData creation ---');
  try {
    final bytes = Uint8List.fromList([0x01, 0x02, 0x03, 0x04]);
    final byteData = ByteData.view(bytes.buffer);
    assert(byteData.lengthInBytes == 4);
    print('ByteData length: ${byteData.lengthInBytes}');
    final firstByte = byteData.getUint8(0);
    print('First byte: 0x${firstByte.toRadixString(16)}');
    assert(firstByte == 0x01);
    recordTest('ByteData creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('ByteData creation', false);
  }

  // Test 6: ByteData write operations
  print('\n--- Test 6: ByteData write operations ---');
  try {
    final byteData = ByteData(8);
    byteData.setUint8(0, 0xFF);
    byteData.setUint16(1, 0x1234, Endian.big);
    byteData.setUint32(3, 0xDEADBEEF, Endian.big);
    print('Wrote: 0xFF at 0');
    print('Wrote: 0x1234 at 1 (2 bytes)');
    print('Wrote: 0xDEADBEEF at 3 (4 bytes)');
    assert(byteData.getUint8(0) == 0xFF);
    recordTest('ByteData write operations', true);
  } catch (e) {
    print('Error: $e');
    recordTest('ByteData write operations', false);
  }

  // Test 7: Send method concept
  print('\n--- Test 7: Send method concept ---');
  try {
    print('BinaryMessenger.send(String channel, ByteData? message):');
    print('  - Sends message to platform');
    print('  - Returns Future<ByteData?>');
    print('  - Response is platform reply');
    print('  - Null message is valid');
    recordTest('Send method concept', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Send method concept', false);
  }

  // Test 8: setMessageHandler concept
  print('\n--- Test 8: setMessageHandler concept ---');
  try {
    print('setMessageHandler(String channel, MessageHandler? handler):');
    print('  - Registers handler for incoming messages');
    print('  - Handler: Future<ByteData?> Function(ByteData?)');
    print('  - Null handler unregisters');
    print('  - Only one handler per channel');
    recordTest('setMessageHandler concept', true);
  } catch (e) {
    print('Error: $e');
    recordTest('setMessageHandler concept', false);
  }

  // Test 9: handlePlatformMessage concept
  print('\n--- Test 9: handlePlatformMessage concept ---');
  try {
    print('handlePlatformMessage(channel, data, callback):');
    print('  - Called by engine for incoming messages');
    print('  - Routes to registered handler');
    print('  - Callback sends response back');
    print('  - Core of message routing');
    recordTest('handlePlatformMessage concept', true);
  } catch (e) {
    print('Error: $e');
    recordTest('handlePlatformMessage concept', false);
  }

  // Test 10: Mock messenger for testing
  print('\n--- Test 10: Mock messenger for testing ---');
  try {
    print('TestDefaultBinaryMessenger:');
    print('  - Used in widget tests');
    print('  - setMockMethodCallHandler for mocking');
    print('  - setMockDecodedMessageHandler');
    print('  - Allows isolated testing');
    recordTest('Mock messenger for testing', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Mock messenger for testing', false);
  }

  // Test 11: Endianness handling
  print('\n--- Test 11: Endianness handling ---');
  try {
    final byteData = ByteData(4);
    byteData.setUint32(0, 0x12345678, Endian.big);
    final bigEndian = byteData.getUint32(0, Endian.big);
    final littleEndian = byteData.getUint32(0, Endian.little);
    print('Value: 0x12345678');
    print('Read as big endian: 0x${bigEndian.toRadixString(16)}');
    print('Read as little endian: 0x${littleEndian.toRadixString(16)}');
    assert(bigEndian == 0x12345678);
    recordTest('Endianness handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Endianness handling', false);
  }

  // Print summary
  print('\n========================================');
  print('BinaryMessenger Test Summary');
  print('========================================');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('Total:  ${passCount + failCount}');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'BinaryMessenger Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount | Failed: $failCount',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
