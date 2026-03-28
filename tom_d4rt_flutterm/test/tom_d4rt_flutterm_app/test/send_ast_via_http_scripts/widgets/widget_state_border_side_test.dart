// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetStateBorderSide from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetStateBorderSide test executing');
  print('=' * 50);

  // WidgetStateBorderSide resolves BorderSide based on state
  print('WidgetStateBorderSide overview:');
  print('  - Abstract class extending BorderSide');
  print('  - Implements WidgetStateProperty<BorderSide?>');
  print('  - Resolves different borders per state');

  // Test resolveWith factory
  print('\nTesting resolveWith factory:');
  final borderSide = WidgetStateBorderSide.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) {
      return const BorderSide(color: Colors.red, width: 2.0);
    }
    if (states.contains(WidgetState.hovered)) {
      return const BorderSide(color: Colors.blue, width: 1.5);
    }
    return const BorderSide(color: Colors.grey, width: 1.0);
  });
  print('  Created resolveWith border: $borderSide');

  // Resolve with empty states
  print('\nResolving with empty states:');
  final defaultBorder = borderSide.resolve({});
  print('  Empty states: width=${defaultBorder?.width}, color=${defaultBorder?.color}');

  // Resolve with pressed state
  print('\nResolving with pressed state:');
  final pressedBorder = borderSide.resolve({WidgetState.pressed});
  print('  Pressed: width=${pressedBorder?.width}, color=${pressedBorder?.color}');

  // Resolve with hovered state
  print('\nResolving with hovered state:');
  final hoveredBorder = borderSide.resolve({WidgetState.hovered});
  print('  Hovered: width=${hoveredBorder?.width}, color=${hoveredBorder?.color}');

  // Resolve with multiple states (pressed takes precedence)
  print('\nResolving with multiple states:');
  final multiBorder = borderSide.resolve({WidgetState.pressed, WidgetState.hovered});
  print('  Pressed+Hovered: width=${multiBorder?.width}, color=${multiBorder?.color}');

  // Test with disabled state
  print('\nTesting disabled state:');
  final disabledBorder = WidgetStateBorderSide.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return BorderSide.none;
    }
    return const BorderSide(color: Colors.black);
  });
  final disabled = disabledBorder.resolve({WidgetState.disabled});
  print('  Disabled resolves to: ${disabled?.style}');

  // BorderSide properties
  print('\nBorderSide inherited properties:');
  print('  - color: border color');
  print('  - width: border width');
  print('  - style: BorderStyle.solid/none');
  print('  - strokeAlign: inside/center/outside');

  print('\n' + '=' * 50);
  print('WidgetStateBorderSide test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetStateBorderSide Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract BorderSide + WidgetStateProperty'),
      Text('Factory: resolveWith()'),
      Text('Tested: pressed, hovered, disabled states'),
    ],
  );
}
