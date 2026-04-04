// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MaterialTapTargetSize from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialTapTargetSize test executing');
  print('=' * 50);

  // MaterialTapTargetSize enum for touch targets
  print('MaterialTapTargetSize overview:');
  print('  - Enum for Material touch target sizing');
  print('  - Used in ThemeData and button styles');
  print('  - Controls minimum hit test area');

  // All enum values
  print('\nAll MaterialTapTargetSize values:');
  for (final value in MaterialTapTargetSize.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${MaterialTapTargetSize.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const padded = MaterialTapTargetSize.padded;
  const shrinkWrap = MaterialTapTargetSize.shrinkWrap;

  print('  padded: $padded');
  print('    - Enforces 48x48 minimum tap target');
  print('    - Material Design guideline');
  print('    - Accessibility recommended');
  print('    - Default for most themes');

  print('  shrinkWrap: $shrinkWrap');
  print('    - No minimum tap target');
  print('    - Button is as small as content');
  print('    - Compact layouts');
  print('    - Less accessible');

  // Usage in ThemeData
  print('\nUsage in ThemeData:');
  print('  ThemeData(');
  print('    materialTapTargetSize: MaterialTapTargetSize.padded,');
  print('  )');

  // Usage in button styles
  print('\nUsage in button styles:');
  print('  ElevatedButton.styleFrom(');
  print('    tapTargetSize: MaterialTapTargetSize.shrinkWrap,');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = MaterialTapTargetSize.values.first;
  final last = MaterialTapTargetSize.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Accessibility note
  print('\nAccessibility note:');
  print('  Material Design recommends 48x48dp');
  print('  Use padded for better accessibility');
  print('  shrinkWrap only for constrained layouts');

  // Default value
  print('\nDefault: MaterialTapTargetSize.padded');

  print('\n' + '=' * 50);
  print('MaterialTapTargetSize test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MaterialTapTargetSize Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: padded, shrinkWrap'),
      Text('Use: Touch target sizing'),
    ],
  ));
}
