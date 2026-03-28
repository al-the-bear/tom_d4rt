// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetStateColor from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetStateColor test executing');
  print('=' * 50);

  // WidgetStateColor resolves Color based on state
  print('WidgetStateColor overview:');
  print('  - Abstract class extending Color');
  print('  - Implements WidgetStateProperty<Color>');
  print('  - Resolves different colors per state');

  // Test resolveWith factory
  print('\nTesting resolveWith factory:');
  final stateColor = WidgetStateColor.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return Colors.grey;
    }
    if (states.contains(WidgetState.pressed)) {
      return Colors.red;
    }
    if (states.contains(WidgetState.hovered)) {
      return Colors.blue;
    }
    return Colors.green;
  });
  print('  Created resolveWith color: $stateColor');

  // Resolve with empty states
  print('\nResolving with empty states:');
  final defaultColor = stateColor.resolve({});
  print('  Empty states: $defaultColor');
  print('  Is green: ${defaultColor == Colors.green}');

  // Resolve with pressed
  print('\nResolving with pressed:');
  final pressedColor = stateColor.resolve({WidgetState.pressed});
  print('  Pressed: $pressedColor');
  print('  Is red: ${pressedColor == Colors.red}');

  // Resolve with hovered
  print('\nResolving with hovered:');
  final hoveredColor = stateColor.resolve({WidgetState.hovered});
  print('  Hovered: $hoveredColor');
  print('  Is blue: ${hoveredColor == Colors.blue}');

  // Resolve with disabled (takes precedence)
  print('\nResolving with disabled:');
  final disabledColor = stateColor.resolve({WidgetState.disabled, WidgetState.pressed});
  print('  Disabled+Pressed: $disabledColor');
  print('  Is grey: ${disabledColor == Colors.grey}');

  // Test transparent factory
  print('\nWidgetStateColor.transparent:');
  final transparent = WidgetStateColor.transparent;
  final resolved = transparent.resolve({WidgetState.pressed});
  print('  Always resolves to: $resolved');
  print('  Alpha: ${resolved.a}');

  // Color properties
  print('\nColor inherited properties:');
  print('  - r, g, b, a: color components');
  print('  - opacity, value');
  print('  - withOpacity, withAlpha methods');

  print('\n' + '=' * 50);
  print('WidgetStateColor test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetStateColor Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract Color + WidgetStateProperty'),
      Text('Factory: resolveWith()'),
      Text('Static: WidgetStateColor.transparent'),
    ],
  );
}
