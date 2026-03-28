// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeLabels from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RangeLabels test executing');
  print('=' * 50);

  // RangeLabels class for RangeSlider
  print('RangeLabels overview:');
  print('  - Class for RangeSlider labels');
  print('  - Stores start and end label strings');
  print('  - Immutable value object');

  // Constructor
  print('\nConstructor:');
  print('  const RangeLabels(String start, String end)');

  // Test instance creation
  print('\nTest instance creation:');
  const labels1 = RangeLabels('0', '100');
  const labels2 = RangeLabels(r'$10', r'$50');
  const labels3 = RangeLabels('Min', 'Max');

  print('  labels1: ${labels1.start} - ${labels1.end}');
  print('  labels2: ${labels2.start} - ${labels2.end}');
  print('  labels3: ${labels3.start} - ${labels3.end}');

  // Properties
  print('\nProperties:');
  print('  start (String): ${labels1.start}');
  print('  end (String): ${labels1.end}');

  // Usage in RangeSlider
  print('\nUsage in RangeSlider:');
  print('  RangeSlider(');
  print('    values: RangeValues(20, 80),');
  print('    labels: RangeLabels("20", "80"),');
  print('    min: 0,');
  print('    max: 100,');
  print('    onChanged: (values) { ... },');
  print('  )');

  // Equality
  print('\nEquality:');
  const same = RangeLabels('0', '100');
  print('  labels1 == same: ${labels1 == same}');
  print('  labels1.hashCode: ${labels1.hashCode}');
  print('  same.hashCode: ${same.hashCode}');

  // ToString
  print('\nToString:');
  print('  labels1.toString(): $labels1');

  // Dynamic labels
  print('\nDynamic labels pattern:');
  print('  onChanged: (values) {');
  print('    setState(() {');
  print('      labels = RangeLabels(');
  print('        values.start.round().toString(),');
  print('        values.end.round().toString(),');
  print('      );');
  print('    });');
  print('  }');

  // Related class
  print('\nRelated class:');
  print('  RangeValues for actual slider values');

  print('\n' + '=' * 50);
  print('RangeLabels test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RangeLabels Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: class'),
      Text('Properties: start, end (String)'),
      Text('Use: RangeSlider labels'),
    ],
  );
}
