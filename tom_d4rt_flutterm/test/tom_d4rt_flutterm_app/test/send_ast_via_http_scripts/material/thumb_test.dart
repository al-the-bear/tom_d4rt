// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Thumb from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Thumb test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nThumb values:');
  for (final value in Thumb.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('Thumb has ${Thumb.values.length} values');

  // First and last
  final first = Thumb.values.first;
  final last = Thumb.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('start: ${Thumb.start.name} (index ${Thumb.start.index})');
  print('end: ${Thumb.end.name} (index ${Thumb.end.index})');

  // RangeSlider context
  print('\nRangeSlider context:');
  print('Thumb identifies which thumb of a RangeSlider is being interacted with');
  print('  start: The left/lower-value thumb of the RangeSlider');
  print('    Controls the start value of the selected range');
  print('    In LTR layout, this is the leftmost thumb');
  print('  end: The right/higher-value thumb of the RangeSlider');
  print('    Controls the end value of the selected range');
  print('    In LTR layout, this is the rightmost thumb');

  // RTL considerations
  print('\nDirectionality considerations:');
  print('  LTR: start is on the left, end is on the right');
  print('  RTL: start is on the right, end is on the left');
  print('  The semantic meaning (lower/higher value) stays the same');

  // Equality
  print('\nEquality tests:');
  print('start == start: ${Thumb.start == Thumb.start}');
  print('start == end: ${Thumb.start == Thumb.end}');
  print('identical: ${identical(Thumb.start, Thumb.values[0])}');
  print('identical end: ${identical(Thumb.end, Thumb.values[1])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is Thumb: ${first is Thumb}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in Thumb.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Callback usage pattern
  print('\nCallback usage pattern:');
  print('  RangeSlider.onChanged receives RangeValues');
  print('  SemanticFormatterCallback can format by thumb');
  print('  RangeSlider.onChangeStart/onChangeEnd use RangeValues');

  // List and map operations
  print('\nCollection operations:');
  final thumbMap = {for (final t in Thumb.values) t.name: t.index};
  print('  Map: $thumbMap');
  print('  Reversed: ${Thumb.values.reversed.map((v) => v.name).join(', ')}');
  print('  Contains start: ${Thumb.values.contains(Thumb.start)}');

  print('\n' + '=' * 50);
  print('Thumb test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Thumb Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${Thumb.values.length}'),
      for (final v in Thumb.values)
        Text('  ${v.name} (${v.index})'),
      Text('RangeSlider: identifies which thumb is active'),
    ],
  );
}
