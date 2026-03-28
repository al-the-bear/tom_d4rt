// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextButtonThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextButtonThemeData test executing');
  print('=' * 50);

  // TextButtonThemeData overview
  print('TextButtonThemeData overview:');
  print('  - Theme data for TextButton');
  print('  - Used with TextButtonTheme');
  print('  - Customizes TextButton appearance');

  // Test default constructor
  print('\nTest default constructor:');
  final theme1 = TextButtonThemeData();
  print('  Created: ${theme1.runtimeType}');
  print('  Style: ${theme1.style}');

  // Test with style
  print('\nTest with ButtonStyle:');
  final theme2 = TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.blue),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      textStyle: WidgetStateProperty.all(TextStyle(fontSize: 16)),
      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16)),
    ),
  );
  print('  Has style: ${theme2.style != null}');
  print('  ForegroundColor: resolved from style');

  // Test overlay and splash
  print('\nTest interaction styling:');
  final theme3 = TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) return Colors.blue.withAlpha(12);
        if (states.contains(WidgetState.pressed)) return Colors.blue.withAlpha(25);
        return null;
      }),
      splashFactory: InkRipple.splashFactory,
    ),
  );
  print('  Has overlay styling: ${theme3.style?.overlayColor != null}');

  // Test shape
  print('\nTest shape styling:');
  final theme4 = TextButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
  print('  Has shape: ${theme4.style?.shape != null}');

  // Test immutability
  print('\nTest immutability:');
  final original = TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.red)),
  );
  final another = TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.blue)),
  );
  print('  TextButtonThemeData is immutable');
  print('  Create new instance for different styling');
  print('  Original != another: ${original != another}');

  // Test lerp
  print('\nTest lerp:');
  final lerped = TextButtonThemeData.lerp(theme1, theme2, 0.5);
  print('  Lerped: ${lerped?.runtimeType}');

  // Usage pattern
  print('\nUsage pattern:');
  print('  TextButtonTheme(');
  print('    data: TextButtonThemeData(...),');
  print('    child: TextButton(...),');
  print('  )');

  print('\n' + '=' * 50);
  print('TextButtonThemeData test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextButtonThemeData Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Theme data class'),
      Text('Purpose: TextButton theming'),
    ],
  );
}
