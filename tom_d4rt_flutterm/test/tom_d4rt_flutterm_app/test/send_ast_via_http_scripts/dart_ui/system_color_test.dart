// D4rt test script: Tests SystemColor from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SystemColor test executing');
  print('=' * 50);

  // SystemColor for platform system colors
  print('\nSystemColor:');
  print('Represents a system color from platform');
  print('May be unsupported on some platforms');

  // Create instance
  final color1 = Color(0xFF00FF00);
  final sc1 = ui.SystemColor(name: 'testColor', value: color1);
  print('\nInstance created:');
  print('name: ${sc1.name}');
  print('value: $color1');

  // Properties
  print('\nProperties:');
  print('name: ${sc1.name}');
  print('isSupported: ${sc1.isSupported}');

  // Platform support
  print('\nPlatform support:');
  print(
    'platformProvidesSystemColors: ${ui.SystemColor.platformProvidesSystemColors}',
  );

  // Multiple instances
  final color2 = Color(0xFFFF0000);
  final sc2 = ui.SystemColor(name: 'accent', value: color2);
  print('\nSecond instance:');
  print('name: ${sc2.name}');
  print('isSupported: ${sc2.isSupported}');

  // Color inheritance
  print('\nExtends Color:');
  print('is Color: ${sc1 is Color}');
  print('alpha: ${sc1.alpha}');
  print('red: ${sc1.red}');
  print('green: ${sc1.green}');
  print('blue: ${sc1.blue}');

  // System color names
  print('\nCommon system color names:');
  print('- accent');
  print('- background');
  print('- foreground');
  print('- highlight');
  print('- selection');

  // Use cases
  print('\nUse cases:');
  print('- Platform theme integration');
  print('- Native look and feel');
  print('- Accessibility colors');
  print('- System preference matching');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Color');
  print('  \u2514\u2500 SystemColor');

  // Explain purpose
  print('\nSystemColor purpose:');
  print('- Platform system colors');
  print('- name identifies color');
  print('- isSupported for availability');
  print('- Extends Color');
  print('- platformProvidesSystemColors static');

  print('\n' + '=' * 50);
  print('SystemColor test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SystemColor Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Name: ${sc1.name}'),
      Text('isSupported: ${sc1.isSupported}'),
      Text('platformProvides: ${ui.SystemColor.platformProvidesSystemColors}'),
      Text('Purpose: Platform colors'),
    ],
  );
}
