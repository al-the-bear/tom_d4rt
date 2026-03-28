// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ToggleButtonsThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ToggleButtonsThemeData test executing');
  print('=' * 50);

  // ToggleButtonsThemeData overview
  print('ToggleButtonsThemeData overview:');
  print('  - Theme data for ToggleButtons');
  print('  - Configures colors, shape, borders');
  print('  - Used with ToggleButtonsTheme');

  // Test default constructor
  print('\nTest default constructor:');
  final theme1 = ToggleButtonsThemeData();
  print('  Created: ${theme1.runtimeType}');

  // Test with colors
  print('\nTest with colors:');
  final theme2 = ToggleButtonsThemeData(
    color: Colors.blue,
    selectedColor: Colors.white,
    fillColor: Colors.blue,
    focusColor: Colors.blue.withAlpha(30),
    highlightColor: Colors.blue.withAlpha(50),
    hoverColor: Colors.blue.withAlpha(20),
    splashColor: Colors.blue.withAlpha(80),
    disabledColor: Colors.grey,
  );
  print('  color: ${theme2.color}');
  print('  selectedColor: ${theme2.selectedColor}');
  print('  fillColor: ${theme2.fillColor}');

  // Test border styling
  print('\nTest border styling:');
  final theme3 = ToggleButtonsThemeData(
    borderColor: Colors.blue,
    selectedBorderColor: Colors.blue,
    disabledBorderColor: Colors.grey,
    borderWidth: 2.0,
    borderRadius: BorderRadius.circular(8),
  );
  print('  borderColor: ${theme3.borderColor}');
  print('  borderWidth: ${theme3.borderWidth}');
  print('  borderRadius: ${theme3.borderRadius}');

  // Test text and constraints
  print('\nTest text and constraints:');
  final theme4 = ToggleButtonsThemeData(
    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    constraints: BoxConstraints(minWidth: 48, minHeight: 48),
  );
  print('  textStyle: ${theme4.textStyle}');
  print('  constraints: ${theme4.constraints}');

  // Test copyWith
  print('\nTest copyWith:');
  final copied = theme2.copyWith(color: Colors.red);
  print('  Original color: ${theme2.color}');
  print('  Copied color: ${copied.color}');

  // Test lerp
  print('\nTest lerp:');
  final lerped = ToggleButtonsThemeData.lerp(theme2, theme3, 0.5);
  print('  Lerped: ${lerped?.runtimeType}');

  // Usage pattern
  print('\nUsage pattern:');
  print('  ToggleButtonsTheme(');
  print('    data: ToggleButtonsThemeData(...),');
  print('    child: ToggleButtons(...),');
  print('  )');

  print('\n' + '=' * 50);
  print('ToggleButtonsThemeData test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ToggleButtonsThemeData Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Theme data class'),
      Text('Purpose: ToggleButtons theming'),
    ],
  );
}
