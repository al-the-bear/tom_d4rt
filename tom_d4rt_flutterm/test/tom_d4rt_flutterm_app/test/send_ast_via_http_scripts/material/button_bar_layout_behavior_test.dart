// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests ButtonBarLayoutBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonBarLayoutBehavior test executing');
  print('=' * 50);

  // ButtonBarLayoutBehavior is an enum with 2 values
  print('ButtonBarLayoutBehavior enum values:');
  for (final behavior in ButtonBarLayoutBehavior.values) {
    print('  ${behavior.name}: index=${behavior.index}');
  }
  print('ButtonBarLayoutBehavior has ${ButtonBarLayoutBehavior.values.length} values');

  // Test first and last
  final first = ButtonBarLayoutBehavior.values.first;
  final last = ButtonBarLayoutBehavior.values.last;
  print('\nFirst value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test constrained
  print('\nTesting ButtonBarLayoutBehavior.constrained:');
  final constrained = ButtonBarLayoutBehavior.constrained;
  print('  name: ${constrained.name}');
  print('  index: ${constrained.index}');
  print('  toString: $constrained');
  print('  Purpose: Min height 52px per Material spec');

  // Test padded
  print('\nTesting ButtonBarLayoutBehavior.padded:');
  final padded = ButtonBarLayoutBehavior.padded;
  print('  name: ${padded.name}');
  print('  index: ${padded.index}');
  print('  toString: $padded');
  print('  Purpose: Padding from button theme');

  // Test equality
  print('\nEquality tests:');
  print('constrained == constrained: ${constrained == constrained}');
  print('constrained == padded: ${constrained == padded}');

  // Usage with ButtonTheme (deprecated but still available)
  print('\nUsage context:');
  print('Used with ButtonTheme and ButtonThemeData');
  print('Defines button bar sizing behavior');

  // Test in ButtonTheme
  final buttonTheme = ButtonTheme(
    layoutBehavior: ButtonBarLayoutBehavior.constrained,
    child: Container(),
  );
  print('\nButtonTheme created with constrained layout');
  print('ButtonTheme type: ${buttonTheme.runtimeType}');

  final buttonTheme2 = ButtonTheme(
    layoutBehavior: ButtonBarLayoutBehavior.padded,
    child: Container(),
  );
  print('ButtonTheme created with padded layout');

  // Test comparison
  print('\nIndex comparison:');
  print('constrained.index < padded.index: ${constrained.index < padded.index}');

  // Test in ButtonThemeData
  const themeData = ButtonThemeData(
    layoutBehavior: ButtonBarLayoutBehavior.constrained,
  );
  print('\nButtonThemeData created');
  print('layoutBehavior: ${themeData.layoutBehavior}');

  const themeData2 = ButtonThemeData(
    layoutBehavior: ButtonBarLayoutBehavior.padded,
  );
  print('Second ButtonThemeData layoutBehavior: ${themeData2.layoutBehavior}');

  print('\n' + '=' * 50);
  print('ButtonBarLayoutBehavior test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ButtonBarLayoutBehavior Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Values: ${ButtonBarLayoutBehavior.values.length}'),
      Text('constrained: min 52px height'),
      Text('padded: uses theme padding'),
    ],
  );
}
