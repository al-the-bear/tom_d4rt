// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ButtonTextTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonTextTheme test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nButtonTextTheme values:');
  for (final value in ButtonTextTheme.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ButtonTextTheme has ${ButtonTextTheme.values.length} values');

  // First and last
  final first = ButtonTextTheme.values.first;
  final last = ButtonTextTheme.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('normal: ${ButtonTextTheme.normal.name} (index ${ButtonTextTheme.normal.index})');
  print('accent: ${ButtonTextTheme.accent.name} (index ${ButtonTextTheme.accent.index})');
  print('primary: ${ButtonTextTheme.primary.name} (index ${ButtonTextTheme.primary.index})');

  // Usage description
  print('\nUsage context:');
  print('normal: Button uses the default text color');
  print('accent: Button uses the accent/secondary color');
  print('primary: Button uses the primary color');

  // Equality
  print('\nEquality tests:');
  print('normal == normal: ${ButtonTextTheme.normal == ButtonTextTheme.normal}');
  print('normal == accent: ${ButtonTextTheme.normal == ButtonTextTheme.accent}');
  print('normal == primary: ${ButtonTextTheme.normal == ButtonTextTheme.primary}');
  print('identical: ${identical(ButtonTextTheme.normal, ButtonTextTheme.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is ButtonTextTheme: ${first is ButtonTextTheme}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in ButtonTextTheme.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage with ButtonThemeData
  print('\nButtonThemeData integration:');
  final theme1 = ButtonThemeData(textTheme: ButtonTextTheme.normal);
  print('Theme normal: ${theme1.textTheme}');

  final theme2 = ButtonThemeData(textTheme: ButtonTextTheme.accent);
  print('Theme accent: ${theme2.textTheme}');

  final theme3 = ButtonThemeData(textTheme: ButtonTextTheme.primary);
  print('Theme primary: ${theme3.textTheme}');

  // Full ButtonThemeData
  final fullTheme = ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    minWidth: 88.0,
    height: 36.0,
    padding: EdgeInsets.symmetric(horizontal: 16),
    layoutBehavior: ButtonBarLayoutBehavior.padded,
  );
  print('\nFull ButtonThemeData:');
  print('textTheme: ${fullTheme.textTheme}');
  print('minWidth: ${fullTheme.minWidth}');
  print('height: ${fullTheme.height}');
  print('padding: ${fullTheme.padding}');

  print('\n' + '=' * 50);
  print('ButtonTextTheme test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ButtonTextTheme Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${ButtonTextTheme.values.length}'),
      for (final v in ButtonTextTheme.values)
        Text('  ${v.name} (${v.index})'),
      Text('ButtonThemeData: all 3 themes'),
    ],
  );
}
