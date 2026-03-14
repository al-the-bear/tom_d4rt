// D4rt test script: Tests PlatformException class from services
// PlatformException represents errors from platform-specific code
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('=== PlatformException Test Suite ===');
  print('Testing PlatformException class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: Create PlatformException with all fields
  print('\n--- Test 1: Create PlatformException ---');
  try {
    final exception = PlatformException(
      code: 'CAMERA_ERROR',
      message: 'Camera not available',
      details: {'device': 'rear', 'reason': 'permission denied'},
      stacktrace: 'at CameraManager.open()\nat PhotoScreen.capture()',
    );
    print('Code: ${exception.code}');
    print('Message: ${exception.message}');
    print('Details: ${exception.details}');
    print('Stacktrace: ${exception.stacktrace?.substring(0, 20)}...');
    assert(exception.code == 'CAMERA_ERROR', 'Code mismatch');
    results.add('✓ PlatformException creation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ PlatformException creation test failed: $e');
    failCount++;
  }

  // Test 2: Create minimal exception
  print('\n--- Test 2: Create Minimal Exception ---');
  try {
    final exception = PlatformException(code: 'ERROR');
    print('Created exception with code only');
    print('Code: ${exception.code}');
    print('Message: ${exception.message}');
    print('Details: ${exception.details}');
    assert(exception.message == null, 'Message should be null');
    assert(exception.details == null, 'Details should be null');
    results.add('✓ Minimal exception creation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Minimal exception creation test failed: $e');
    failCount++;
  }

  // Test 3: Exception toString
  print('\n--- Test 3: Exception toString ---');
  try {
    final exception = PlatformException(
      code: 'GPS_ERROR',
      message: 'Location services disabled',
    );
    final str = exception.toString();
    print('toString: $str');
    assert(str.contains('PlatformException'), 'Should contain class name');
    assert(str.contains('GPS_ERROR'), 'Should contain code');
    results.add('✓ Exception toString test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Exception toString test failed: $e');
    failCount++;
  }

  // Test 4: Throw and catch exception
  print('\n--- Test 4: Throw and Catch Exception ---');
  try {
    try {
      throw PlatformException(
        code: 'NETWORK_ERROR',
        message: 'Connection timeout',
      );
    } on PlatformException catch (e) {
      print('Caught PlatformException');
      print('Code: ${e.code}');
      print('Message: ${e.message}');
      assert(e.code == 'NETWORK_ERROR', 'Code mismatch');
    }
    results.add('✓ Throw and catch exception test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Throw and catch exception test failed: $e');
    failCount++;
  }

  // Test 5: Exception with complex details
  print('\n--- Test 5: Complex Details ---');
  try {
    final exception = PlatformException(
      code: 'VALIDATION_ERROR',
      message: 'Invalid input',
      details: {
        'field': 'email',
        'value': 'invalid',
        'rules': ['required', 'email_format'],
        'nested': {'key': 'value'},
      },
    );
    final details = exception.details as Map;
    print('Field: ${details['field']}');
    print('Value: ${details['value']}');
    print('Rules: ${details['rules']}');
    print('Nested: ${details['nested']}');
    results.add('✓ Complex details test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Complex details test failed: $e');
    failCount++;
  }

  // Test 6: Common error code patterns
  print('\n--- Test 6: Common Error Code Patterns ---');
  try {
    final errorCodes = [
      'PERMISSION_DENIED',
      'NOT_FOUND',
      'INVALID_ARGUMENT',
      'UNAUTHENTICATED',
      'UNAVAILABLE',
      'UNIMPLEMENTED',
    ];
    print('Common platform error codes:');
    for (final code in errorCodes) {
      print('  - $code');
    }
    results.add('✓ Common error code patterns test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Common error code patterns test failed: $e');
    failCount++;
  }

  // Test 7: Exception type checking
  print('\n--- Test 7: Exception Type Checking ---');
  try {
    final exception = PlatformException(code: 'TEST');
    print('Exception type: ${exception.runtimeType}');
    assert(exception is Exception, 'Should be an Exception');
    assert(exception is! Error, 'Should not be an Error');
    results.add('✓ Exception type checking test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Exception type checking test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== PlatformException Test Summary ===');
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
      Text(
        'PlatformException Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
