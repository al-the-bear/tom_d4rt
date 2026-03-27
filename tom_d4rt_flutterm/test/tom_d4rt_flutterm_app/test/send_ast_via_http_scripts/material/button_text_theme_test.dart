// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests ButtonTextTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonTextTheme test executing');
  print('=' * 50);

  // ButtonTextTheme is an enum with 3 values
  print('ButtonTextTheme enum values:');
  for (final theme in ButtonTextTheme.values) {
    print('  ${theme.name}: index=${theme.index}');
  }
  print('ButtonTextTheme has ${ButtonTextTheme.values.length} values');

  // Test first and last
  final first = ButtonTextTheme.values.first;
  final last = ButtonTextTheme.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test normal
  print('\nTesting ButtonTextTheme.normal:');
  final normal = ButtonTextTheme.normal;
  print('  name: ${normal.name}');
  print('  index: ${normal.index}');
  print('  toString: $normal');
  print('  Purpose: Black/white based on brightness');

  // Test accent
  print('\nTesting ButtonTextTheme.accent:');
  final accent = ButtonTextTheme.accent;
  print('  name: ${accent.name}');
  print('  index: ${accent.index}');
  print('  Purpose: Uses ColorScheme.secondary');

  // Test primary
  print('\nTesting ButtonTextTheme.primary:');
  final primary = ButtonTextTheme.primary;
  print('  name: ${primary.name}');
  print('  index: ${primary.index}');
  print('  Purpose: Based on ThemeData.primaryColor');

  // Test equality
  print('\nEquality tests:');
  print('normal == normal: ${normal == normal}');
  print('normal == accent: ${normal == accent}');
  print('accent == primary: ${accent == primary}');

  // Usage with ButtonTheme
  print('\nUsage with ButtonTheme:');
  final buttonTheme1 = ButtonTheme(
    textTheme: ButtonTextTheme.normal,
    child: Container(),
  );
  print('ButtonTheme with normal: ${buttonTheme1.runtimeType}');

  final buttonTheme2 = ButtonTheme(
    textTheme: ButtonTextTheme.accent,
    child: Container(),
  );
  print('ButtonTheme with accent created');

  final buttonTheme3 = ButtonTheme(
    textTheme: ButtonTextTheme.primary,
    child: Container(),
  );
  print('ButtonTheme with primary created');

  // Test in ButtonThemeData
  const themeData1 = ButtonThemeData(textTheme: ButtonTextTheme.normal);
  const themeData2 = ButtonThemeData(textTheme: ButtonTextTheme.accent);
  const themeData3 = ButtonThemeData(textTheme: ButtonTextTheme.primary);
  print('\nButtonThemeData values:');
  print('Theme 1 textTheme: ${themeData1.textTheme}');
  print('Theme 2 textTheme: ${themeData2.textTheme}');
  print('Theme 3 textTheme: ${themeData3.textTheme}');

  // Test index ordering
  print('\nIndex ordering:');
  print('normal.index: ${normal.index}');
  print('accent.index: ${accent.index}');
  print('primary.index: ${primary.index}');

  print('\n' + '=' * 50);
  print('ButtonTextTheme test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ButtonTextTheme Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${ButtonTextTheme.values.length}'),
      Text('normal: black/white by brightness'),
      Text('accent: ColorScheme.secondary'),
      Text('primary: ThemeData.primaryColor'),
    ],
  );
}
