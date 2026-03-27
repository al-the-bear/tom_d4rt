// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests IconAlignment from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IconAlignment test executing');
  print('=' * 50);

  // IconAlignment is an enum with 2 values
  print('IconAlignment enum values:');
  for (final alignment in IconAlignment.values) {
    print('  ${alignment.name}: index=${alignment.index}');
  }
  print('IconAlignment has ${IconAlignment.values.length} values');

  // Test first and last
  final first = IconAlignment.values.first;
  final last = IconAlignment.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test start
  print('\nTesting IconAlignment.start:');
  final start = IconAlignment.start;
  print('  name: ${start.name}');
  print('  index: ${start.index}');
  print('  toString: $start');
  print('  Purpose: Icon at leading edge of button');

  // Test end
  print('\nTesting IconAlignment.end:');
  final end = IconAlignment.end;
  print('  name: ${end.name}');
  print('  index: ${end.index}');
  print('  Purpose: Icon at trailing edge of button');

  // Test equality
  print('\nEquality tests:');
  print('start == start: ${start == start}');
  print('start == end: ${start == end}');
  print('end == end: ${end == end}');

  // Usage with TextButton.icon
  print('\nUsage with styled buttons:');
  final button1 = TextButton.icon(
    onPressed: () {},
    icon: Icon(Icons.add),
    label: Text('Add'),
    iconAlignment: IconAlignment.start,
  );
  print('TextButton.icon with start alignment created');

  final button2 = TextButton.icon(
    onPressed: () {},
    icon: Icon(Icons.arrow_forward),
    label: Text('Next'),
    iconAlignment: IconAlignment.end,
  );
  print('TextButton.icon with end alignment created');

  // Usage with ElevatedButton.icon
  final elevated1 = ElevatedButton.icon(
    onPressed: () {},
    icon: Icon(Icons.save),
    label: Text('Save'),
    iconAlignment: IconAlignment.start,
  );
  print('\nElevatedButton.icon with start created');

  final elevated2 = ElevatedButton.icon(
    onPressed: () {},
    icon: Icon(Icons.send),
    label: Text('Send'),
    iconAlignment: IconAlignment.end,
  );
  print('ElevatedButton.icon with end created');

  // Usage with OutlinedButton.icon
  final outlined = OutlinedButton.icon(
    onPressed: () {},
    icon: Icon(Icons.download),
    label: Text('Download'),
    iconAlignment: IconAlignment.end,
  );
  print('OutlinedButton.icon with end created');

  // Usage with FilledButton.icon
  final filled = FilledButton.icon(
    onPressed: () {},
    icon: Icon(Icons.check),
    label: Text('Confirm'),
    iconAlignment: IconAlignment.start,
  );
  print('FilledButton.icon with start created');

  // Index ordering
  print('\nIndex ordering:');
  print('start.index: ${start.index}');
  print('end.index: ${end.index}');

  // RTL consideration
  print('\nRTL consideration:');
  print('start: respects text direction');
  print('end: respects text direction');

  print('\n' + '=' * 50);
  print('IconAlignment test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IconAlignment Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${IconAlignment.values.length}'),
      Text('start: leading edge'),
      Text('end: trailing edge'),
      Text('Used with Button.icon widgets'),
    ],
  );
}
