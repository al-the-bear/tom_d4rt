// D4rt test script: Tests RestorationBucket from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorationBucket test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Test RestorationBucket.empty constructor
  print('\n--- Test 1: Test RestorationBucket.empty constructor ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket',
      debugOwner: null,
    );
    assert(bucket is RestorationBucket);
    print('Created empty RestorationBucket');
    print('Restoration ID: ${bucket.restorationId}');
    results.add('Test 1 PASSED: Empty bucket creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test writing and reading primitive values
  print('\n--- Test 2: Test writing and reading primitive values ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket_2',
      debugOwner: null,
    );
    bucket.write<int>('counter', 42);
    bucket.write<String>('name', 'TestValue');
    bucket.write<bool>('enabled', true);
    bucket.write<double>('ratio', 3.14);
    final counter = bucket.read<int>('counter');
    final name = bucket.read<String>('name');
    final enabled = bucket.read<bool>('enabled');
    final ratio = bucket.read<double>('ratio');
    print('Counter: $counter');
    print('Name: $name');
    print('Enabled: $enabled');
    print('Ratio: $ratio');
    assert(counter == 42);
    assert(name == 'TestValue');
    results.add('Test 2 PASSED: Primitive value read/write');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test reading non-existent values
  print('\n--- Test 3: Test reading non-existent values ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket_3',
      debugOwner: null,
    );
    final missing = bucket.read<String>('nonexistent');
    print('Missing value is null: ${missing == null}');
    assert(missing == null);
    results.add('Test 3 PASSED: Non-existent value returns null');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test contains method
  print('\n--- Test 4: Test contains method ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket_4',
      debugOwner: null,
    );
    bucket.write<String>('existing_key', 'value');
    final hasExisting = bucket.contains('existing_key');
    final hasMissing = bucket.contains('missing_key');
    print('Contains existing_key: $hasExisting');
    print('Contains missing_key: $hasMissing');
    assert(hasExisting == true);
    assert(hasMissing == false);
    results.add('Test 4 PASSED: Contains method');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test remove method
  print('\n--- Test 5: Test remove method ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket_5',
      debugOwner: null,
    );
    bucket.write<String>('to_remove', 'value');
    print('Before remove, contains: ${bucket.contains('to_remove')}');
    bucket.remove<String>('to_remove');
    print('After remove, contains: ${bucket.contains('to_remove')}');
    results.add('Test 5 PASSED: Remove method');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test overwriting values
  print('\n--- Test 6: Test overwriting values ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket_6',
      debugOwner: null,
    );
    bucket.write<int>('value', 1);
    print('Initial value: ${bucket.read<int>('value')}');
    bucket.write<int>('value', 100);
    print('Overwritten value: ${bucket.read<int>('value')}');
    assert(bucket.read<int>('value') == 100);
    results.add('Test 6 PASSED: Overwriting values');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test child bucket creation
  print('\n--- Test 7: Test child bucket creation ---');
  try {
    final parentBucket = RestorationBucket.empty(
      restorationId: 'parent',
      debugOwner: null,
    );
    final childBucket = parentBucket.claimChild('child_bucket', debugOwner: null);
    assert(childBucket != null);
    print('Child bucket created');
    print('Child restoration ID: ${childBucket.restorationId}');
    childBucket.write<String>('child_data', 'child_value');
    print('Child data: ${childBucket.read<String>('child_data')}');
    results.add('Test 7 PASSED: Child bucket creation');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Test bucket disposal
  print('\n--- Test 8: Test bucket disposal ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'disposable',
      debugOwner: null,
    );
    bucket.write<String>('data', 'value');
    print('Bucket created and data written');
    bucket.dispose();
    print('Bucket disposed successfully');
    results.add('Test 8 PASSED: Bucket disposal');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RestorationBucket test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('RestorationBucket Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text('Passed: $testsPassed, Failed: $testsFailed', style: TextStyle(color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000))),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
