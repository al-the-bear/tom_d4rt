// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetStateTextStyle from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetStateTextStyle test executing');
  print('=' * 50);

  // WidgetStateTextStyle resolves TextStyle based on state
  print('WidgetStateTextStyle overview:');
  print('  - Abstract class extending TextStyle');
  print('  - Implements WidgetStateProperty<TextStyle>');
  print('  - Resolves different styles per state');

  // Test resolveWith factory
  print('\nTesting resolveWith factory:');
  final textStyle = WidgetStateTextStyle.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return const TextStyle(color: Colors.grey, fontSize: 14);
    }
    if (states.contains(WidgetState.pressed)) {
      return const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14);
    }
    if (states.contains(WidgetState.hovered)) {
      return const TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 14);
    }
    return const TextStyle(color: Colors.black, fontSize: 14);
  });
  print('  Created resolveWith style');

  // Resolve with empty states
  print('\nResolving with empty states:');
  final defaultStyle = textStyle.resolve({});
  print('  Default color: ${defaultStyle.color}');
  print('  Default fontSize: ${defaultStyle.fontSize}');

  // Resolve with pressed
  print('\nResolving with pressed:');
  final pressedStyle = textStyle.resolve({WidgetState.pressed});
  print('  Pressed color: ${pressedStyle.color}');
  print('  Pressed fontWeight: ${pressedStyle.fontWeight}');

  // Resolve with hovered
  print('\nResolving with hovered:');
  final hoveredStyle = textStyle.resolve({WidgetState.hovered});
  print('  Hovered color: ${hoveredStyle.color}');
  print('  Hovered decoration: ${hoveredStyle.decoration}');

  // Resolve with disabled
  print('\nResolving with disabled:');
  final disabledStyle = textStyle.resolve({WidgetState.disabled});
  print('  Disabled color: ${disabledStyle.color}');

  // TextStyle properties
  print('\nTextStyle inherited properties:');
  print('  - color, backgroundColor');
  print('  - fontSize, fontWeight, fontStyle');
  print('  - letterSpacing, wordSpacing');
  print('  - height, decoration');

  // Priority with multiple states
  print('\nPriority with multiple states:');
  final multipleStates = {WidgetState.disabled, WidgetState.pressed};
  final multiStyle = textStyle.resolve(multipleStates);
  print('  Disabled+Pressed: color=${multiStyle.color}');
  print('  (disabled takes precedence)');

  print('\n' + '=' * 50);
  print('WidgetStateTextStyle test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetStateTextStyle Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: TextStyle + WidgetStateProperty'),
      Text('Factory: resolveWith()'),
      Text('Tested: pressed, hovered, disabled'),
    ],
  );
}
