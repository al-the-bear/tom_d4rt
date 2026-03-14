// D4rt test script: Tests MessageCodec interface from services
// MessageCodec is the base interface for encoding/decoding platform messages
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';

dynamic build(BuildContext context) {
  print('=== MessageCodec Test Suite ===');
  print('Testing MessageCodec interface from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: BinaryCodec (implements MessageCodec)
  print('\n--- Test 1: BinaryCodec Implementation ---');
  try {
    final codec = const BinaryCodec();
    print('BinaryCodec implements MessageCodec<ByteData>');
    final data = ByteData(4);
    data.setInt32(0, 42);
    final encoded = codec.encodeMessage(data);
    print('Original data: 42');
    print('Encoded: $encoded');
    final decoded = codec.decodeMessage(encoded);
    print('Decoded value: ${decoded?.getInt32(0)}');
    assert(decoded?.getInt32(0) == 42, 'Should decode to 42');
    results.add('✓ BinaryCodec implementation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ BinaryCodec implementation test failed: $e');
    failCount++;
  }

  // Test 2: StringCodec (implements MessageCodec)
  print('\n--- Test 2: StringCodec Implementation ---');
  try {
    final codec = const StringCodec();
    print('StringCodec implements MessageCodec<String>');
    const message = 'Hello, Flutter!';
    final encoded = codec.encodeMessage(message);
    print('Original message: $message');
    print('Encoded bytes: ${encoded?.lengthInBytes}');
    final decoded = codec.decodeMessage(encoded);
    print('Decoded message: $decoded');
    assert(decoded == message, 'Decoded should match original');
    results.add('✓ StringCodec implementation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ StringCodec implementation test failed: $e');
    failCount++;
  }

  // Test 3: JSONMessageCodec (implements MessageCodec)
  print('\n--- Test 3: JSONMessageCodec Implementation ---');
  try {
    final codec = const JSONMessageCodec();
    print('JSONMessageCodec implements MessageCodec<Object?>');
    final message = {'key': 'value', 'number': 42, 'list': [1, 2, 3]};
    final encoded = codec.encodeMessage(message);
    print('Original: $message');
    print('Encoded bytes: ${encoded?.lengthInBytes}');
    final decoded = codec.decodeMessage(encoded) as Map<String, Object?>;
    print('Decoded: $decoded');
    assert(decoded['key'] == 'value', 'Key should be value');
    assert(decoded['number'] == 42, 'Number should be 42');
    results.add('✓ JSONMessageCodec implementation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ JSONMessageCodec implementation test failed: $e');
    failCount++;
  }

  // Test 4: StandardMessageCodec (implements MessageCodec)
  print('\n--- Test 4: StandardMessageCodec Implementation ---');
  try {
    final codec = const StandardMessageCodec();
    print('StandardMessageCodec implements MessageCodec<Object?>');
    final message = {
      'string': 'test',
      'int': 123,
      'double': 3.14,
      'bool': true,
      'null': null,
      'list': [1, 2, 3],
    };
    final encoded = codec.encodeMessage(message);
    print('Encoded complex message');
    final decoded = codec.decodeMessage(encoded) as Map;
    print('Decoded string: ${decoded['string']}');
    print('Decoded int: ${decoded['int']}');
    print('Decoded double: ${decoded['double']}');
    assert(decoded['string'] == 'test', 'String mismatch');
    results.add('✓ StandardMessageCodec implementation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ StandardMessageCodec implementation test failed: $e');
    failCount++;
  }

  // Test 5: Encode null message
  print('\n--- Test 5: Null Message Encoding ---');
  try {
    final codec = const JSONMessageCodec();
    final encoded = codec.encodeMessage(null);
    print('Encoding null message');
    print('Result: $encoded');
    final decoded = codec.decodeMessage(encoded);
    print('Decoded: $decoded');
    results.add('✓ Null message encoding test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Null message encoding test failed: $e');
    failCount++;
  }

  // Test 6: Empty data handling
  print('\n--- Test 6: Empty Data Handling ---');
  try {
    final codec = const StringCodec();
    const emptyString = '';
    final encoded = codec.encodeMessage(emptyString);
    print('Encoding empty string');
    print('Encoded bytes: ${encoded?.lengthInBytes}');
    final decoded = codec.decodeMessage(encoded);
    print('Decoded: "$decoded"');
    assert(decoded == '', 'Should decode to empty string');
    results.add('✓ Empty data handling test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Empty data handling test failed: $e');
    failCount++;
  }

  // Test 7: Unicode string encoding
  print('\n--- Test 7: Unicode String Encoding ---');
  try {
    final codec = const StringCodec();
    const unicodeStr = '你好世界 🌍 مرحبا';
    final encoded = codec.encodeMessage(unicodeStr);
    print('Unicode string: $unicodeStr');
    print('Encoded bytes: ${encoded?.lengthInBytes}');
    final decoded = codec.decodeMessage(encoded);
    print('Decoded: $decoded');
    assert(decoded == unicodeStr, 'Unicode should match');
    results.add('✓ Unicode string encoding test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Unicode string encoding test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== MessageCodec Test Summary ===');
  print('Total tests: ${passCount + failCount}');
  print('Passed: $passCount');
  print('Failed: $failCount');
  for (final result in results) {
    print(result);
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('MessageCodec Test Results',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
