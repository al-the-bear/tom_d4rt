// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeValues from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RangeValues test executing');
  print('=' * 50);

  // RangeValues class for RangeSlider
  print('RangeValues overview:');
  print('  - Class for RangeSlider values');
  print('  - Stores start and end double values');
  print('  - Immutable value object');

  // Constructor
  print('\nConstructor:');
  print('  const RangeValues(double start, double end)');

  // Test instance creation
  print('\nTest instance creation:');
  const values1 = RangeValues(0, 100);
  const values2 = RangeValues(25.5, 75.5);
  const values3 = RangeValues(-10, 10);

  print('  values1: ${values1.start} - ${values1.end}');
  print('  values2: ${values2.start} - ${values2.end}');
  print('  values3: ${values3.start} - ${values3.end}');

  // Properties
  print('\nProperties:');
  print('  start (double): ${values1.start}');
  print('  end (double): ${values1.end}');

  // Usage in RangeSlider
  print('\nUsage in RangeSlider:');
  print('  RangeSlider(');
  print('    values: RangeValues(20, 80),');
  print('    min: 0,');
  print('    max: 100,');
  print('    onChanged: (newValues) {');
  print('      print(newValues.start);');
  print('      print(newValues.end);');
  print('    },');
  print('  )');

  // Equality
  print('\nEquality:');
  const same = RangeValues(0, 100);
  print('  values1 == same: ${values1 == same}');
  print('  values1.hashCode: ${values1.hashCode}');
  print('  same.hashCode: ${same.hashCode}');

  // ToString
  print('\nToString:');
  print('  values1.toString(): $values1');

  // State management pattern
  print('\nState management pattern:');
  print('  RangeValues _range = RangeValues(0, 100);');
  print('  RangeSlider(');
  print('    values: _range,');
  print('    onChanged: (v) => setState(() => _range = v),');
  print('  )');

  // Related class
  print('\nRelated class:');
  print('  RangeLabels for slider labels');

  print('\n' + '=' * 50);
  print('RangeValues test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RangeValues Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: class'),
      Text('Properties: start, end (double)'),
      Text('Use: RangeSlider values'),
    ],
  );
}
