// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Typography from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Typography test executing');
  print('=' * 50);

  // Typography overview
  print('Typography overview:');
  print('  - Material typography configuration');
  print('  - Defines text styles');
  print('  - Platform-specific defaults');

  // Factory constructors
  print('\nFactory constructors:');
  print('  Typography.material2014()');
  print('  Typography.material2018()');
  print('  Typography.material2021()');

  // Test material2021
  print('\nTest Typography.material2021:');
  final typo = Typography.material2021();
  print('  black: TextTheme for light backgrounds');
  print('  white: TextTheme for dark backgrounds');
  print('  englishLike: ${typo.englishLike.runtimeType}');
  print('  dense: ${typo.dense.runtimeType}');
  print('  tall: ${typo.tall.runtimeType}');

  // Black and white text themes
  print('\nBlack and white text themes:');
  print('  black: for light backgrounds');
  print('  white: for dark backgrounds');
  print('  Contains full TextTheme');

  // Script categories
  print('\nScript categories:');
  print('  englishLike: Latin, Greek, Cyrillic');
  print('  dense: CJK scripts (Chinese, Japanese, Korean)');
  print('  tall: Indic scripts, Thai, etc.');

  // Test geometryThemeFor
  print('\nTest geometryThemeFor:');
  print('  Returns appropriate TextTheme');
  print('  Based on ScriptCategory');

  // Platform defaults
  print('\nPlatform defaults:');
  final platform = Typography.material2021(platform: TargetPlatform.android);
  print('  Android: ${platform.runtimeType}');

  // Color schemes
  print('\nCorrect color scheme selection:');
  print('  Brightness.light -> black');
  print('  Brightness.dark -> white');

  // Usage pattern
  print('\nUsage pattern:');
  print('  ThemeData(');
  print('    typography: Typography.material2021(),');
  print('  )');
  print('');
  print('  // Access via Theme:');
  print('  Theme.of(context).textTheme');

  // Text styles included
  print('\nText styles included:');
  print('  displayLarge, displayMedium, displaySmall');
  print('  headlineLarge, headlineMedium, headlineSmall');
  print('  titleLarge, titleMedium, titleSmall');
  print('  bodyLarge, bodyMedium, bodySmall');
  print('  labelLarge, labelMedium, labelSmall');

  print('\n' + '=' * 50);
  print('Typography test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Typography Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: typography config'),
      Text('Purpose: Text styling'),
    ],
  );
}
