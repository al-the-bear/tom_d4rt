// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ButtonBarLayoutBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonBarLayoutBehavior test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nButtonBarLayoutBehavior values:');
  for (final value in ButtonBarLayoutBehavior.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ButtonBarLayoutBehavior has ${ButtonBarLayoutBehavior.values.length} values');

  // First and last
  final first = ButtonBarLayoutBehavior.values.first;
  final last = ButtonBarLayoutBehavior.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('constrained: ${ButtonBarLayoutBehavior.constrained.name} (index ${ButtonBarLayoutBehavior.constrained.index})');
  print('padded: ${ButtonBarLayoutBehavior.padded.name} (index ${ButtonBarLayoutBehavior.padded.index})');

  // Usage description
  print('\nUsage context:');
  print('constrained: Constrains buttons to minimum dialog width');
  print('  Ensures dialog buttons do not overflow');
  print('padded: Applies standard padding around buttons');
  print('  Allows natural button sizing with added spacing');

  // Equality
  print('\nEquality tests:');
  print('constrained == constrained: ${ButtonBarLayoutBehavior.constrained == ButtonBarLayoutBehavior.constrained}');
  print('constrained == padded: ${ButtonBarLayoutBehavior.constrained == ButtonBarLayoutBehavior.padded}');
  print('identical: ${identical(ButtonBarLayoutBehavior.constrained, ButtonBarLayoutBehavior.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is ButtonBarLayoutBehavior: ${first is ButtonBarLayoutBehavior}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in ButtonBarLayoutBehavior.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage with ButtonBarThemeData
  print('\nButtonBarThemeData integration:');
  final theme1 = ButtonBarThemeData(layoutBehavior: ButtonBarLayoutBehavior.constrained);
  print('Theme constrained: ${theme1.layoutBehavior}');
  print('Theme alignment: ${theme1.alignment}');
  print('Theme buttonPadding: ${theme1.buttonPadding}');

  final theme2 = ButtonBarThemeData(layoutBehavior: ButtonBarLayoutBehavior.padded);
  print('Theme padded: ${theme2.layoutBehavior}');

  // Full ButtonBarThemeData
  final fullTheme = ButtonBarThemeData(
    alignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    buttonPadding: EdgeInsets.symmetric(horizontal: 8),
    layoutBehavior: ButtonBarLayoutBehavior.constrained,
    overflowDirection: VerticalDirection.down,
  );
  print('\nFull ButtonBarThemeData:');
  print('alignment: ${fullTheme.alignment}');
  print('mainAxisSize: ${fullTheme.mainAxisSize}');
  print('buttonPadding: ${fullTheme.buttonPadding}');
  print('layoutBehavior: ${fullTheme.layoutBehavior}');
  print('overflowDirection: ${fullTheme.overflowDirection}');

  print('\n' + '=' * 50);
  print('ButtonBarLayoutBehavior test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ButtonBarLayoutBehavior Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${ButtonBarLayoutBehavior.values.length}'),
      for (final v in ButtonBarLayoutBehavior.values)
        Text('  ${v.name} (${v.index})'),
      Text('ButtonBarTheme: constrained & padded'),
    ],
  );
}
