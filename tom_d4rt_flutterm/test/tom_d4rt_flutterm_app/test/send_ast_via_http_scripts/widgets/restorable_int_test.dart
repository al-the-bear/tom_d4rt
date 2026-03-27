// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableInt from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableInt test executing');
  print('=' * 50);

  // RestorableInt stores non-null int
  print('RestorableInt:');
  print('Purpose: Store and restore non-null int values');
  print('Extends: RestorableNum<int>');
  print('');

  // Create with default value
  print('Creating with default value:');
  final prop = RestorableInt(0);
  print('Created: RestorableInt(0)');
  print('runtimeType: ${prop.runtimeType}');
  print('');

  // Various integer scenarios
  print('Testing various integer values:');
  final counter = RestorableInt(1);
  print('Counter: 1');

  final negative = RestorableInt(-50);
  print('Negative: -50');

  final power = RestorableInt(1024);
  print('Power of 2: 1024');
  print('');

  // Common app scenarios
  print('Common use cases:');
  print('  - Counter value (RestorationMixin example)');
  print('  - Selected tab index');
  print('  - User preferences (numeric)');
  print('  - Page number in pagination');
  print('');

  // Index-based patterns
  print('Index patterns:');
  final tabIndex = RestorableInt(0);
  print('Tab index: starts at 0');

  final pageIndex = RestorableInt(1);
  print('Page index: starts at 1');
  print('');

  // Serialization
  print('Serialization:');
  print('  Stores raw int value');
  print('  Direct primitive storage');
  print('  No conversion needed');
  print('');

  // Type hierarchy
  print('Type hierarchy:');
  print('RestorableInt');
  print('  extends RestorableNum<int>');
  print('    extends _RestorablePrimitiveValue<int>');
  print('');

  print('is RestorableNum: ${prop is RestorableNum}');
  print('is RestorableProperty: ${prop is RestorableProperty}');

  // Cleanup
  prop.dispose();
  counter.dispose();
  negative.dispose();
  power.dispose();
  tabIndex.dispose();
  pageIndex.dispose();

  print('\n' + '=' * 50);
  print('RestorableInt test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableInt Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Non-null int restoration'),
      Text('Common for counters, indices'),
      Text('Direct primitive storage'),
    ],
  );
}
