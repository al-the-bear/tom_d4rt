// D4rt test script: Tests MissingPluginException class from services
// MissingPluginException is thrown when a platform channel method has no handler
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('=== MissingPluginException Test Suite ===');
  print('Testing MissingPluginException class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: Create MissingPluginException with message
  print('\n--- Test 1: Create MissingPluginException ---');
  try {
    final exception = MissingPluginException('Plugin not found');
    print('Created exception: $exception');
    print('Message: ${exception.message}');
    assert(exception.message == 'Plugin not found', 'Message mismatch');
    results.add('✓ MissingPluginException creation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ MissingPluginException creation test failed: $e');
    failCount++;
  }

  // Test 2: Exception without message
  print('\n--- Test 2: Exception Without Message ---');
  try {
    final exception = MissingPluginException();
    print('Created exception without message');
    print('Message: ${exception.message}');
    assert(exception.message == null, 'Message should be null');
    results.add('✓ Exception without message test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Exception without message test failed: $e');
    failCount++;
  }

  // Test 3: Exception toString
  print('\n--- Test 3: Exception toString ---');
  try {
    final exception = MissingPluginException('test_channel');
    final str = exception.toString();
    print('toString: $str');
    assert(str.contains('MissingPluginException'), 'Should contain class name');
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
      throw MissingPluginException('Method not implemented');
    } on MissingPluginException catch (e) {
      print('Caught MissingPluginException');
      print('Message: ${e.message}');
      assert(e.message == 'Method not implemented', 'Message mismatch');
    }
    results.add('✓ Throw and catch exception test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Throw and catch exception test failed: $e');
    failCount++;
  }

  // Test 5: Exception type checking
  print('\n--- Test 5: Exception Type Checking ---');
  try {
    final exception = MissingPluginException('test');
    print('Exception type: ${exception.runtimeType}');
    assert(exception is Exception, 'Should be an Exception');
    assert(exception is! Error, 'Should not be an Error');
    results.add('✓ Exception type checking test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Exception type checking test failed: $e');
    failCount++;
  }

  // Test 6: Common use case scenarios
  print('\n--- Test 6: Common Use Case Scenarios ---');
  try {
    // Scenario 1: Channel not registered
    final channelError = MissingPluginException(
        'No implementation found for method getName on channel example.com/test');
    print('Channel error: ${channelError.message}');
    
    // Scenario 2: Platform not supported
    final platformError = MissingPluginException(
        'Plugin example_plugin not available on web platform');
    print('Platform error: ${platformError.message}');
    
    // Scenario 3: Method not implemented
    final methodError = MissingPluginException(
        'Method doSomething has not been implemented');
    print('Method error: ${methodError.message}');
    
    results.add('✓ Common use case scenarios test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Common use case scenarios test failed: $e');
    failCount++;
  }

  // Test 7: Exception handling patterns
  print('\n--- Test 7: Exception Handling Patterns ---');
  try {
    Future<void> simulatePluginCall() async {
      throw MissingPluginException('simulated.channel');
    }
    
    try {
      await simulatePluginCall();
    } on MissingPluginException catch (e) {
      print('Handled missing plugin: ${e.message}');
      // In real code, might provide fallback behavior
    }
    results.add('✓ Exception handling patterns test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Exception handling patterns test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== MissingPluginException Test Summary ===');
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
      Text('MissingPluginException Test Results',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
