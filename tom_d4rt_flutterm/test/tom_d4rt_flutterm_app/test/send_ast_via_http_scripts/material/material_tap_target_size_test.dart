// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests MaterialTapTargetSize from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialTapTargetSize test executing');
  print('=' * 50);

  // MaterialTapTargetSize is an enum with 2 values
  print('MaterialTapTargetSize enum values:');
  for (final size in MaterialTapTargetSize.values) {
    print('  ${size.name}: index=${size.index}');
  }
  print('MaterialTapTargetSize has ${MaterialTapTargetSize.values.length} values');

  // Test first and last
  final first = MaterialTapTargetSize.values.first;
  final last = MaterialTapTargetSize.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test padded
  print('\nTesting MaterialTapTargetSize.padded:');
  final padded = MaterialTapTargetSize.padded;
  print('  name: ${padded.name}');
  print('  index: ${padded.index}');
  print('  toString: $padded');
  print('  Size: 48x48 pixels minimum');
  print('  Purpose: Android accessibility scanner compliant');

  // Test shrinkWrap
  print('\nTesting MaterialTapTargetSize.shrinkWrap:');
  final shrinkWrap = MaterialTapTargetSize.shrinkWrap;
  print('  name: ${shrinkWrap.name}');
  print('  index: ${shrinkWrap.index}');
  print('  Size: Minimum per Material spec');
  print('  Purpose: Compact UI, denser layouts');

  // Test equality
  print('\nEquality tests:');
  print('padded == padded: ${padded == padded}');
  print('padded == shrinkWrap: ${padded == shrinkWrap}');

  // Usage with ThemeData
  print('\nUsage with ThemeData:');
  final theme1 = ThemeData(materialTapTargetSize: MaterialTapTargetSize.padded);
  print('ThemeData with padded: ${theme1.materialTapTargetSize}');

  final theme2 = ThemeData(materialTapTargetSize: MaterialTapTargetSize.shrinkWrap);
  print('ThemeData with shrinkWrap: ${theme2.materialTapTargetSize}');

  // Check current theme
  final currentTheme = Theme.of(context);
  print('\nCurrent theme materialTapTargetSize: ${currentTheme.materialTapTargetSize}');

  // Usage with Checkbox
  print('\nUsage with Checkbox:');
  final checkbox1 = Checkbox(
    value: true,
    onChanged: (v) {},
    materialTapTargetSize: MaterialTapTargetSize.padded,
  );
  print('Checkbox with padded created');

  final checkbox2 = Checkbox(
    value: false,
    onChanged: (v) {},
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
  print('Checkbox with shrinkWrap created');

  // Usage with Radio
  print('\nUsage with Radio:');
  final radio = Radio<int>(
    value: 1,
    groupValue: 1,
    onChanged: (v) {},
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
  print('Radio with shrinkWrap created');

  // Usage with Switch
  print('\nUsage with Switch:');
  final switchWidget = Switch(
    value: true,
    onChanged: (v) {},
    materialTapTargetSize: MaterialTapTargetSize.padded,
  );
  print('Switch with padded created');

  // Index ordering
  print('\nIndex ordering:');
  print('padded.index: ${padded.index}');
  print('shrinkWrap.index: ${shrinkWrap.index}');

  // Accessibility note
  print('\nAccessibility note:');
  print('padded (48x48) recommended for accessibility');
  print('shrinkWrap for space-constrained UIs');

  print('\n' + '=' * 50);
  print('MaterialTapTargetSize test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaterialTapTargetSize Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${MaterialTapTargetSize.values.length}'),
      Text('padded: 48x48 min (accessible)'),
      Text('shrinkWrap: compact layout'),
    ],
  );
}
