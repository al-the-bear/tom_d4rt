// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MaterialTapTargetSize from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialTapTargetSize test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nMaterialTapTargetSize values:');
  for (final value in MaterialTapTargetSize.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('MaterialTapTargetSize has ${MaterialTapTargetSize.values.length} values');

  // First and last
  final first = MaterialTapTargetSize.values.first;
  final last = MaterialTapTargetSize.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('padded: ${MaterialTapTargetSize.padded.name} (index ${MaterialTapTargetSize.padded.index})');
  print('shrinkWrap: ${MaterialTapTargetSize.shrinkWrap.name} (index ${MaterialTapTargetSize.shrinkWrap.index})');

  // Usage description
  print('\nUsage context:');
  print('padded: Expands tap target to minimum 48x48 logical pixels');
  print('  Follows Material Design accessibility guidelines');
  print('  Default for most Material widgets');
  print('shrinkWrap: Shrinks tap target to match child size');
  print('  Useful for dense layouts where space is limited');
  print('  May not meet accessibility minimum tap target size');

  // Equality
  print('\nEquality tests:');
  print('padded == padded: ${MaterialTapTargetSize.padded == MaterialTapTargetSize.padded}');
  print('padded == shrinkWrap: ${MaterialTapTargetSize.padded == MaterialTapTargetSize.shrinkWrap}');
  print('identical: ${identical(MaterialTapTargetSize.padded, MaterialTapTargetSize.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is MaterialTapTargetSize: ${first is MaterialTapTargetSize}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in MaterialTapTargetSize.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage with ThemeData
  print('\nThemeData integration:');
  final theme1 = ThemeData(materialTapTargetSize: MaterialTapTargetSize.padded);
  print('Theme padded: ${theme1.materialTapTargetSize}');

  final theme2 = ThemeData(materialTapTargetSize: MaterialTapTargetSize.shrinkWrap);
  print('Theme shrinkWrap: ${theme2.materialTapTargetSize}');

  // Default theme value
  final defaultTheme = ThemeData();
  print('\nDefault theme materialTapTargetSize: ${defaultTheme.materialTapTargetSize}');

  // Usage with specific widgets
  print('\nWidget integration examples:');
  print('Checkbox: uses materialTapTargetSize for hit area');
  print('Radio: uses materialTapTargetSize for hit area');
  print('Switch: uses materialTapTargetSize for hit area');
  print('IconButton: affected by materialTapTargetSize');

  print('\n' + '=' * 50);
  print('MaterialTapTargetSize test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MaterialTapTargetSize Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${MaterialTapTargetSize.values.length}'),
      for (final v in MaterialTapTargetSize.values)
        Text('  ${v.name} (${v.index})'),
      Text('Default: ${defaultTheme.materialTapTargetSize}'),
    ],
  );
}
