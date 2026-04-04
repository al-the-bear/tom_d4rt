// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScriptCategory from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScriptCategory test executing');
  print('=' * 50);

  // ScriptCategory enum for typography
  print('ScriptCategory overview:');
  print('  - Enum for script typography categories');
  print('  - Used with Typography');
  print('  - Groups scripts by visual characteristics');

  // All enum values
  print('\nAll ScriptCategory values:');
  for (final value in ScriptCategory.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${ScriptCategory.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const englishLike = ScriptCategory.englishLike;
  const dense = ScriptCategory.dense;
  const tall = ScriptCategory.tall;

  print('  englishLike: $englishLike');
  print('    - Latin, Greek, Cyrillic scripts');
  print('    - Western typography metrics');
  print('    - Based on English x-height');
  print('    - Standard line heights');

  print('  dense: $dense');
  print('    - CJK scripts (Chinese, Japanese, Korean)');
  print('    - Denser character shapes');
  print('    - Square character bounding');
  print('    - Adjusted line heights');

  print('  tall: $tall');
  print('    - Tall scripts (Arabic, Hindi, Thai)');
  print('    - Taller ascenders/descenders');
  print('    - Increased line spacing');
  print('    - Complex glyph shapes');

  // Usage in Typography
  print('\nUsage in Typography:');
  print('  Typography(');
  print('    englishLike: TextTheme(...),');
  print('    dense: TextTheme(...),');
  print('    tall: TextTheme(...),');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = ScriptCategory.values.first;
  final last = ScriptCategory.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Material Design guidelines
  print('\nMaterial Design note:');
  print('  Different scripts need different metrics');
  print('  Typography adapts to locale');

  print('\n' + '=' * 50);
  print('ScriptCategory test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ScriptCategory Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: englishLike, dense, tall'),
      Text('Use: Typography script types'),
    ],
  ));
}
