// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ThemeMode from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ThemeMode test executing');
  print('=' * 50);

  // ThemeMode enum overview
  print('ThemeMode enum overview:');
  print('  - App theme brightness mode');
  print('  - Used in MaterialApp');
  print('  - 3 values: system, light, dark');

  // Enumerate all values
  print('\nThemeMode values:');
  for (final value in ThemeMode.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ThemeMode has ${ThemeMode.values.length} values');

  // Test system mode
  print('\nTest ThemeMode.system:');
  final system = ThemeMode.system;
  print('  Name: ${system.name}');
  print('  Index: ${system.index}');
  print('  Follows platform setting: Yes');

  // Test light mode
  print('\nTest ThemeMode.light:');
  final light = ThemeMode.light;
  print('  Name: ${light.name}');
  print('  Index: ${light.index}');
  print('  Always light theme: Yes');

  // Test dark mode
  print('\nTest ThemeMode.dark:');
  final dark = ThemeMode.dark;
  print('  Name: ${dark.name}');
  print('  Index: ${dark.index}');
  print('  Always dark theme: Yes');

  // First and last
  print('\nFirst and last:');
  print('  First: ${ThemeMode.values.first}');
  print('  Last: ${ThemeMode.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  MaterialApp.themeMode parameter');
  print('  Controls which theme is active');
  print('  Works with theme and darkTheme');

  // Switch pattern
  print('\nSwitch pattern:');
  final mode = ThemeMode.system;
  switch (mode) {
    case ThemeMode.system:
      print('  Following system brightness');
      break;
    case ThemeMode.light:
      print('  Using light theme');
      break;
    case ThemeMode.dark:
      print('  Using dark theme');
      break;
  }

  // Comparison
  print('\nComparison:');
  print('  system == system: ${ThemeMode.system == ThemeMode.system}');
  print('  light == dark: ${ThemeMode.light == ThemeMode.dark}');

  // Theme selection logic
  print('\nTheme selection logic:');
  print('  system: Uses MediaQuery.platformBrightness');
  print('  light: Uses MaterialApp.theme');
  print('  dark: Uses MaterialApp.darkTheme');

  // Default value
  print('\nDefault value:');
  print('  MaterialApp default: ThemeMode.system');

  print('\n' + '=' * 50);
  print('ThemeMode test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ThemeMode Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: system, light, dark'),
      Text('Purpose: App theme mode'),
    ],
  ));
}
