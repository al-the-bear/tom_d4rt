// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FlutterLogoStyle from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterLogoStyle test executing');
  print('=' * 50);

  // FlutterLogoStyle enum overview
  print('FlutterLogoStyle enum overview:');
  print('  - Flutter logo display style');
  print('  - Used in FlutterLogo');
  print('  - 3 values: markOnly, horizontal, stacked');

  // Enumerate all values
  print('\nFlutterLogoStyle values:');
  for (final value in FlutterLogoStyle.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('FlutterLogoStyle has ${FlutterLogoStyle.values.length} values');

  // Test markOnly
  print('\nTest FlutterLogoStyle.markOnly:');
  final markOnly = FlutterLogoStyle.markOnly;
  print('  Name: ${markOnly.name}');
  print('  Index: ${markOnly.index}');
  print('  Shows: Just the F logo mark');

  // Test horizontal
  print('\nTest FlutterLogoStyle.horizontal:');
  final horizontal = FlutterLogoStyle.horizontal;
  print('  Name: ${horizontal.name}');
  print('  Index: ${horizontal.index}');
  print('  Shows: Logo mark + "Flutter" text horizontal');

  // Test stacked
  print('\nTest FlutterLogoStyle.stacked:');
  final stacked = FlutterLogoStyle.stacked;
  print('  Name: ${stacked.name}');
  print('  Index: ${stacked.index}');
  print('  Shows: Logo mark above "Flutter" text');

  // First and last
  print('\nFirst and last:');
  print('  First: ${FlutterLogoStyle.values.first}');
  print('  Last: ${FlutterLogoStyle.values.last}');

  // Usage in FlutterLogo
  print('\nUsage in FlutterLogo:');
  print('  FlutterLogo(style: FlutterLogoStyle.markOnly)');
  print('  FlutterLogo(style: FlutterLogoStyle.horizontal)');
  print('  FlutterLogo(style: FlutterLogoStyle.stacked)');

  // Switch pattern
  print('\nSwitch pattern:');
  final style = FlutterLogoStyle.horizontal;
  switch (style) {
    case FlutterLogoStyle.markOnly:
      print('  Just the mark');
      break;
    case FlutterLogoStyle.horizontal:
      print('  Horizontal with text');
      break;
    case FlutterLogoStyle.stacked:
      print('  Stacked with text');
      break;
  }

  // Size considerations
  print('\nSize considerations:');
  print('  markOnly: square aspect ratio');
  print('  horizontal: wide aspect ratio');
  print('  stacked: tall aspect ratio');

  // Default
  print('\nDefault:');
  print('  FlutterLogo default: markOnly');

  print('\n' + '=' * 50);
  print('FlutterLogoStyle test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlutterLogoStyle Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: markOnly, horizontal, stacked'),
      Text('Purpose: Logo display style'),
    ],
  );
}
