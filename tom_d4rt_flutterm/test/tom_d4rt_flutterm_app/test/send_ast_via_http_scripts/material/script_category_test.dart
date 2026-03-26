// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScriptCategory from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScriptCategory test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nScriptCategory values:');
  for (final value in ScriptCategory.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ScriptCategory has ${ScriptCategory.values.length} values');

  // First and last
  final first = ScriptCategory.values.first;
  final last = ScriptCategory.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('englishLike: ${ScriptCategory.englishLike.name} (index ${ScriptCategory.englishLike.index})');
  print('dense: ${ScriptCategory.dense.name} (index ${ScriptCategory.dense.index})');
  print('tall: ${ScriptCategory.tall.name} (index ${ScriptCategory.tall.index})');

  // Usage description
  print('\nUsage context:');
  print('englishLike: Latin, Cyrillic, Greek, and similar scripts');
  print('  Used for English, German, French, Russian, etc.');
  print('  Standard line height and spacing');
  print('dense: CJK (Chinese, Japanese, Korean) scripts');
  print('  Denser character sets with tighter line spacing');
  print('  Characters occupy more uniform space');
  print('tall: South and Southeast Asian scripts');
  print('  Taller glyphs requiring more vertical space');
  print('  Thai, Hindi, Arabic, etc.');

  // Equality
  print('\nEquality tests:');
  print('englishLike == englishLike: ${ScriptCategory.englishLike == ScriptCategory.englishLike}');
  print('englishLike == dense: ${ScriptCategory.englishLike == ScriptCategory.dense}');
  print('englishLike == tall: ${ScriptCategory.englishLike == ScriptCategory.tall}');
  print('identical: ${identical(ScriptCategory.englishLike, ScriptCategory.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is ScriptCategory: ${first is ScriptCategory}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in ScriptCategory.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Typography association
  print('\nTypography integration:');
  final typography = Typography.material2021();
  print('Typography.material2021() created');
  print('englishLike: ${typography.englishLike.bodyMedium?.fontSize}px body');
  print('dense: ${typography.dense.bodyMedium?.fontSize}px body');
  print('tall: ${typography.tall.bodyMedium?.fontSize}px body');

  print('\n' + '=' * 50);
  print('ScriptCategory test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ScriptCategory Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${ScriptCategory.values.length}'),
      for (final v in ScriptCategory.values)
        Text('  ${v.name} (${v.index})'),
      Text('Typography: englishLike, dense, tall'),
    ],
  );
}
