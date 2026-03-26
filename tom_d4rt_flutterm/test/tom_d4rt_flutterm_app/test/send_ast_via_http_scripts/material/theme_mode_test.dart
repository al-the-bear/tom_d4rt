// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ThemeMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ThemeMode test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nThemeMode values:');
  for (final value in ThemeMode.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ThemeMode has ${ThemeMode.values.length} values');

  // First and last
  final first = ThemeMode.values.first;
  final last = ThemeMode.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('system: ${ThemeMode.system.name} (index ${ThemeMode.system.index})');
  print('light: ${ThemeMode.light.name} (index ${ThemeMode.light.index})');
  print('dark: ${ThemeMode.dark.name} (index ${ThemeMode.dark.index})');

  // Usage description
  print('\nUsage context:');
  print('system: Use the system theme setting (light or dark)');
  print('  Follows the platform brightness setting');
  print('  Automatically adapts when user changes system theme');
  print('light: Always use the light theme');
  print('  Ignores the system theme setting');
  print('  Uses the theme property of MaterialApp');
  print('dark: Always use the dark theme');
  print('  Ignores the system theme setting');
  print('  Uses the darkTheme property of MaterialApp');

  // Equality
  print('\nEquality tests:');
  print('system == system: ${ThemeMode.system == ThemeMode.system}');
  print('system == light: ${ThemeMode.system == ThemeMode.light}');
  print('identical: ${identical(ThemeMode.system, ThemeMode.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is ThemeMode: ${first is ThemeMode}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in ThemeMode.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // MaterialApp usage
  print('\nMaterialApp integration:');
  for (final mode in ThemeMode.values) {
    print('  ThemeMode.${mode.name} controls which theme MaterialApp uses');
  }

  // Theme resolution logic
  print('\nTheme resolution:');
  print('  system + brightness=light -> uses ThemeData from theme');
  print('  system + brightness=dark -> uses ThemeData from darkTheme');
  print('  light -> always uses ThemeData from theme');
  print('  dark -> always uses ThemeData from darkTheme');
  print('  If darkTheme is null, falls back to theme');

  // Indexed iteration
  print('\nIndexed iteration:');
  for (var i = 0; i < ThemeMode.values.length; i++) {
    final v = ThemeMode.values[i];
    print('  [$i] ${v.name} (index=${v.index})');
  }

  print('\n' + '=' * 50);
  print('ThemeMode test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ThemeMode Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${ThemeMode.values.length}'),
      for (final v in ThemeMode.values)
        Text('  ${v.name} (${v.index})'),
      Text('MaterialApp: all theme modes supported'),
    ],
  );
}
