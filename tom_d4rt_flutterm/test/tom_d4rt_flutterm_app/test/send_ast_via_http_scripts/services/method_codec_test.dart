// D4rt test script: Tests MethodCodec interface from services
// MethodCodec is used for encoding method calls and results in platform channels
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';

dynamic build(BuildContext context) {
  print('=== MethodCodec Test Suite ===');
  print('Testing MethodCodec interface from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: StandardMethodCodec instance
  print('\n--- Test 1: StandardMethodCodec Instance ---');
  try {
    final codec = const StandardMethodCodec();
    print('StandardMethodCodec implements MethodCodec');
    print('Uses StandardMessageCodec for serialization');
    results.add('✓ StandardMethodCodec instance test passed');
    passCount++;
  } catch (e) {
    results.add('✗ StandardMethodCodec instance test failed: $e');
    failCount++;
  }

  // Test 2: Encode method call
  print('\n--- Test 2: Encode Method Call ---');
  try {
    final codec = const StandardMethodCodec();
    final call = MethodCall('testMethod', {'arg1': 'value1', 'arg2': 42});
    final encoded = codec.encodeMethodCall(call);
    print('Method name: ${call.method}');
    print('Arguments: ${call.arguments}');
    print('Encoded bytes: ${encoded.lengthInBytes}');
    assert(encoded.lengthInBytes > 0, 'Should have encoded data');
    results.add('✓ Encode method call test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Encode method call test failed: $e');
    failCount++;
  }

  // Test 3: Decode method call
  print('\n--- Test 3: Decode Method Call ---');
  try {
    final codec = const StandardMethodCodec();
    final originalCall = MethodCall('getData', [1, 2, 3]);
    final encoded = codec.encodeMethodCall(originalCall);
    final decoded = codec.decodeMethodCall(encoded);
    print('Original method: ${originalCall.method}');
    print('Decoded method: ${decoded.method}');
    print('Original args: ${originalCall.arguments}');
    print('Decoded args: ${decoded.arguments}');
    assert(decoded.method == originalCall.method, 'Method name mismatch');
    results.add('✓ Decode method call test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Decode method call test failed: $e');
    failCount++;
  }

  // Test 4: Encode successful result
  print('\n--- Test 4: Encode Successful Result ---');
  try {
    final codec = const StandardMethodCodec();
    final result = {'status': 'success', 'data': [1, 2, 3]};
    final encoded = codec.encodeSuccessEnvelope(result);
    print('Result: $result');
    print('Encoded bytes: ${encoded.lengthInBytes}');
    assert(encoded.lengthInBytes > 0, 'Should have encoded data');
    results.add('✓ Encode successful result test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Encode successful result test failed: $e');
    failCount++;
  }

  // Test 5: Encode error result
  print('\n--- Test 5: Encode Error Result ---');
  try {
    final codec = const StandardMethodCodec();
    final encoded = codec.encodeErrorEnvelope(
      code: 'ERROR_001',
      message: 'Something went wrong',
      details: {'errorType': 'validation'},
    );
    print('Error code: ERROR_001');
    print('Error message: Something went wrong');
    print('Encoded bytes: ${encoded.lengthInBytes}');
    assert(encoded.lengthInBytes > 0, 'Should have encoded error');
    results.add('✓ Encode error result test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Encode error result test failed: $e');
    failCount++;
  }

  // Test 6: Decode envelope (success)
  print('\n--- Test 6: Decode Success Envelope ---');
  try {
    final codec = const StandardMethodCodec();
    const successData = 'Operation completed';
    final encoded = codec.encodeSuccessEnvelope(successData);
    final decoded = codec.decodeEnvelope(encoded);
    print('Original data: $successData');
    print('Decoded data: $decoded');
    assert(decoded == successData, 'Data mismatch');
    results.add('✓ Decode success envelope test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Decode success envelope test failed: $e');
    failCount++;
  }

  // Test 7: JSONMethodCodec
  print('\n--- Test 7: JSONMethodCodec ---');
  try {
    final codec = const JSONMethodCodec();
    final call = MethodCall('jsonMethod', {'key': 'value'});
    final encoded = codec.encodeMethodCall(call);
    final decoded = codec.decodeMethodCall(encoded);
    print('JSON codec method: ${decoded.method}');
    print('JSON codec args: ${decoded.arguments}');
    assert(decoded.method == 'jsonMethod', 'Method name mismatch');
    results.add('✓ JSONMethodCodec test passed');
    passCount++;
  } catch (e) {
    results.add('✗ JSONMethodCodec test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== MethodCodec Test Summary ===');
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
      Text('MethodCodec Test Results',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
