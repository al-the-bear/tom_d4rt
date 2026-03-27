// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests FloatingLabelBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FloatingLabelBehavior test executing');
  print('=' * 50);

  // FloatingLabelBehavior is an enum with 3 values
  print('FloatingLabelBehavior enum values:');
  for (final behavior in FloatingLabelBehavior.values) {
    print('  ${behavior.name}: index=${behavior.index}');
  }
  print('FloatingLabelBehavior has ${FloatingLabelBehavior.values.length} values');

  // Test first and last
  final first = FloatingLabelBehavior.values.first;
  final last = FloatingLabelBehavior.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test never
  print('\nTesting FloatingLabelBehavior.never:');
  final never = FloatingLabelBehavior.never;
  print('  name: ${never.name}');
  print('  index: ${never.index}');
  print('  toString: $never');
  print('  Purpose: Label always within content or hidden');

  // Test auto
  print('\nTesting FloatingLabelBehavior.auto:');
  final auto = FloatingLabelBehavior.auto;
  print('  name: ${auto.name}');
  print('  index: ${auto.index}');
  print('  Purpose: Float on focus or when has content');

  // Test always
  print('\nTesting FloatingLabelBehavior.always:');
  final always = FloatingLabelBehavior.always;
  print('  name: ${always.name}');
  print('  index: ${always.index}');
  print('  Purpose: Label always floats above content');

  // Test equality
  print('\nEquality tests:');
  print('never == never: ${never == never}');
  print('never == auto: ${never == auto}');
  print('auto == always: ${auto == always}');

  // Usage with InputDecoration
  print('\nUsage with InputDecoration:');
  const decoration1 = InputDecoration(
    labelText: 'Never Float',
    floatingLabelBehavior: FloatingLabelBehavior.never,
  );
  print('InputDecoration with never created');
  print('floatingLabelBehavior: ${decoration1.floatingLabelBehavior}');

  const decoration2 = InputDecoration(
    labelText: 'Auto Float',
    floatingLabelBehavior: FloatingLabelBehavior.auto,
  );
  print('InputDecoration with auto created');

  const decoration3 = InputDecoration(
    labelText: 'Always Float',
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );
  print('InputDecoration with always created');

  // Usage with TextField
  print('\nUsage with TextField:');
  final textField = TextField(
    decoration: InputDecoration(
      labelText: 'Example',
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    ),
  );
  print('TextField with floatingLabelBehavior.auto created');
  print('TextField type: ${textField.runtimeType}');

  // Test index ordering
  print('\nIndex ordering:');
  print('never.index: ${never.index}');
  print('auto.index: ${auto.index}');
  print('always.index: ${always.index}');

  // Use cases
  print('\nUse cases:');
  print('never: Compact forms, always show placeholder');
  print('auto: Standard Material behavior');
  print('always: Clear labeling, accessibility');

  print('\n' + '=' * 50);
  print('FloatingLabelBehavior test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FloatingLabelBehavior Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${FloatingLabelBehavior.values.length}'),
      Text('never: label stays inside'),
      Text('auto: float on focus'),
      Text('always: always float'),
    ],
  );
}
