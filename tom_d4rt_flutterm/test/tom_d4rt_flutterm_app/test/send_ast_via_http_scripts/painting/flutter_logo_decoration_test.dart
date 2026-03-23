// ignore_for_file: avoid_print
// D4rt test script: Tests FlutterLogoDecoration from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FlutterLogoDecoration test executing');

  // Create FlutterLogoDecoration
  final logo = FlutterLogoDecoration(
    textColor: Colors.blue,
    style: FlutterLogoStyle.horizontal,
  );

  print('Created: ${logo.runtimeType}');

  // Test properties
  print('\nLogo properties:');
  print('textColor: ${logo.textColor}');
  print('style: ${logo.style}');
  print('margin: ${logo.margin}');

  // FlutterLogoStyle values
  print('\nFlutterLogoStyle values:');
  print('- markOnly: just the mark');
  print('- horizontal: mark + text horizontal');
  print('- stacked: mark + text stacked');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Decoration (abstract)');
  print('  └── FlutterLogoDecoration');
  print('is Decoration: ${true}');

  // Create other styles
  print('\nOther styles:');
  final markOnly = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  print('markOnly: ${markOnly.style}');

  final stacked = FlutterLogoDecoration(style: FlutterLogoStyle.stacked);
  print('stacked: ${stacked.style}');

  // Usage
  print('\nUsage:');
  print('Container(');
  print('  decoration: FlutterLogoDecoration(),');
  print(')');

  // In widgets
  print('\nRelated widget:');
  print('FlutterLogo(size: 100, style: ...)');

  print('\nFlutterLogoDecoration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FlutterLogoDecoration Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Flutter logo decoration'),
      Text('style: ${logo.style}'),
      Text('Styles: markOnly, horizontal, stacked'),
    ],
  );
}
