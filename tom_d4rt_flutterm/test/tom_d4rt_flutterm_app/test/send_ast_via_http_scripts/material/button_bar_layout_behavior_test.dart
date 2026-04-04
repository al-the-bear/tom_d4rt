// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ButtonBarLayoutBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonBarLayoutBehavior test executing');
  print('=' * 50);

  // ButtonBarLayoutBehavior enum for button bar sizing
  print('ButtonBarLayoutBehavior overview:');
  print('  - Enum for ButtonBar layout behavior');
  print('  - Used with ButtonTheme and ButtonThemeData');
  print('  - Controls button bar height and padding');

  // All enum values
  print('\nAll ButtonBarLayoutBehavior values:');
  for (final value in ButtonBarLayoutBehavior.values) {
    print('  - ${value.name} (index: ${value.index})');
  }
  print('  Total: ${ButtonBarLayoutBehavior.values.length} values');

  // Test individual values
  print('\nTesting individual values:');
  const constrained = ButtonBarLayoutBehavior.constrained;
  const padded = ButtonBarLayoutBehavior.padded;

  print('  constrained: $constrained');
  print('    - Minimum height of 52 pixels');
  print('    - Conforms to Material Design spec');
  print('    - Fixed constraint behavior');

  print('  padded: $padded');
  print('    - Padding calculated from button theme');
  print('    - More flexible sizing');
  print('    - Default behavior');

  // Usage in ButtonTheme
  print('\nUsage in ButtonTheme:');
  print('  ButtonTheme(');
  print('    layoutBehavior: ButtonBarLayoutBehavior.constrained,');
  print('    child: ButtonBar(');
  print('      children: [');
  print('        TextButton(...),');
  print('        ElevatedButton(...),');
  print('      ],');
  print('    ),');
  print('  )');

  // First and last
  print('\nFirst and last:');
  final first = ButtonBarLayoutBehavior.values.first;
  final last = ButtonBarLayoutBehavior.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Comparison
  print('\nComparison:');
  print('  constrained == constrained: ${constrained == ButtonBarLayoutBehavior.constrained}');
  print('  padded.index > constrained.index: ${padded.index > constrained.index}');

  // Default value
  print('\nDefault value:');
  print('  ButtonTheme default: ButtonBarLayoutBehavior.padded');

  // Material 3 note
  print('\nMaterial 3 note:');
  print('  ButtonBar is deprecated in Material 3');
  print('  Use OverflowBar or Row instead');
  print('  This enum still used for legacy compatibility');

  print('\n' + '=' * 50);
  print('ButtonBarLayoutBehavior test completed');

  return SingleChildScrollView(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ButtonBarLayoutBehavior Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: enum'),
      Text('Values: constrained, padded'),
      Text('Use: ButtonBar sizing behavior'),
    ],
  ));
}
