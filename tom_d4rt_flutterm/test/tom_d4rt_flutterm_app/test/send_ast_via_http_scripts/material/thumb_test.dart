// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Thumb from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Thumb test executing');
  print('=' * 50);

  // Thumb enum overview
  print('Thumb enum overview:');
  print('  - Identifies slider thumbs');
  print('  - Used in RangeSlider callbacks');
  print('  - 2 values: start, end');

  // Enumerate all values
  print('\nThumb values:');
  for (final value in Thumb.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('Thumb has ${Thumb.values.length} values');

  // Test start thumb
  print('\nTest Thumb.start:');
  final start = Thumb.start;
  print('  Name: ${start.name}');
  print('  Index: ${start.index}');
  print('  Is start: ${start == Thumb.start}');
  print('  Is end: ${start == Thumb.end}');

  // Test end thumb
  print('\nTest Thumb.end:');
  final end = Thumb.end;
  print('  Name: ${end.name}');
  print('  Index: ${end.index}');
  print('  Is start: ${end == Thumb.start}');
  print('  Is end: ${end == Thumb.end}');

  // First and last
  print('\nFirst and last:');
  print('  First: ${Thumb.values.first}');
  print('  Last: ${Thumb.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  RangeSlider.onChanged callback');
  print('  RangeSlider.onChangeStart callback');
  print('  RangeSlider.onChangeEnd callback');
  print('  Identifies which thumb is being dragged');

  // Comparison
  print('\nComparison:');
  print('  start == start: ${Thumb.start == Thumb.start}');
  print('  start == end: ${Thumb.start == Thumb.end}');
  print('  end == end: ${Thumb.end == Thumb.end}');

  // Switch usage
  print('\nSwitch pattern:');
  final thumb = Thumb.start;
  switch (thumb) {
    case Thumb.start:
      print('  Handling start thumb');
      break;
    case Thumb.end:
      print('  Handling end thumb');
      break;
  }

  // Contains check
  print('\nContains check:');
  print('  values.contains(start): ${Thumb.values.contains(Thumb.start)}');
  print('  values.contains(end): ${Thumb.values.contains(Thumb.end)}');

  // Index lookup
  print('\nIndex lookup:');
  print('  Thumb.values[0]: ${Thumb.values[0]}');
  print('  Thumb.values[1]: ${Thumb.values[1]}');

  print('\n' + '=' * 50);
  print('Thumb test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Thumb Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: start, end'),
      Text('Purpose: RangeSlider thumb ID'),
    ],
  ));
}
