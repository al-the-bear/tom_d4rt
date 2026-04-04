// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ButtonTextTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonTextTheme test executing');
  print('=' * 50);

  // ButtonTextTheme enum for button text color
  print('ButtonTextTheme overview:');
  print('  - Enum for button text theming');
  print('  - Used with ButtonTheme and ButtonThemeData');
  print('  - Defines button text base color');

  // All enum values
  print('\nAll ButtonTextTheme values:');
  for (final value in ButtonTextTheme.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${ButtonTextTheme.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const normal = ButtonTextTheme.normal;
  const accent = ButtonTextTheme.accent;
  const primary = ButtonTextTheme.primary;

  print('  normal: $normal');
  print('    - Black or white depending on brightness');
  print('    - ThemeData.brightness determines color');
  print('    - Default for most buttons');

  print('  accent: $accent');
  print('    - Uses ColorScheme.secondary');
  print('    - For secondary emphasis');
  print('    - Legacy Material 2 terminology');

  print('  primary: $primary');
  print('    - Based on ThemeData.primaryColor');
  print('    - For primary emphasis');
  print('    - High visibility actions');

  // Usage in ButtonTheme
  print('\nUsage in ButtonTheme:');
  print('  ButtonTheme(');
  print('    textTheme: ButtonTextTheme.primary,');
  print('    child: MaterialButton(');
  print('      onPressed: () {},');
  print('      child: Text("Press Me"),');
  print('    ),');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = ButtonTextTheme.values.first;
  final last = ButtonTextTheme.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Default value
  print('\nDefault value:');
  print('  ButtonTheme default: ButtonTextTheme.normal');

  // Deprecation note
  print('\nMaterial 3 note:');
  print('  ButtonTheme is deprecated in Material 3');
  print('  Use ElevatedButton, TextButton, OutlinedButton instead');
  print('  These have their own style system');

  print('\n' + '=' * 50);
  print('ButtonTextTheme test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ButtonTextTheme Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: normal, accent, primary'),
      Text('Use: Button text color theme'),
    ],
  ));
}
