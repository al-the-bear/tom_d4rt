// D4rt test script: Tests PlaceholderDimensions from painting
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('PlaceholderDimensions test executing');

  // Create PlaceholderDimensions
  final dimensions = PlaceholderDimensions(
    size: Size(24, 24),
    alignment: ui.PlaceholderAlignment.middle,
    baseline: TextBaseline.alphabetic,
    baselineOffset: 12.0,
  );

  print('Created: ${dimensions.runtimeType}');

  // Test properties
  print('\nDimension properties:');
  print('size: ${dimensions.size}');
  print('alignment: ${dimensions.alignment}');
  print('baseline: ${dimensions.baseline}');
  print('baselineOffset: ${dimensions.baselineOffset}');

  // Alignment values
  print('\nPlaceholderAlignment values:');
  print('- baseline: align to text baseline');
  print('- aboveBaseline: above text baseline');
  print('- belowBaseline: below text baseline');
  print('- top: align to top of text');
  print('- bottom: align to bottom');
  print('- middle: vertically centered');

  // Explain purpose
  print('\nPlaceholderDimensions purpose:');
  print('- Defines inline placeholder size');
  print('- Used by WidgetSpan');
  print('- Embedded widgets in text');

  // Usage with WidgetSpan
  print('\nUsage with WidgetSpan:');
  print('TextSpan(children: [');
  print('  TextSpan(text: "Hello "),');
  print('  WidgetSpan(');
  print('    child: Icon(Icons.star),');
  print('    alignment: PlaceholderAlignment.middle,');
  print('  ),');
  print('  TextSpan(text: " World"),');
  print('])');

  // empty constant
  print('\nEmpty constant:');
  print('PlaceholderDimensions.empty = Size.zero');

  print('\nPlaceholderDimensions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlaceholderDimensions Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Inline placeholder sizing'),
      Text('size: ${dimensions.size}'),
      Text('alignment: ${dimensions.alignment}'),
      Text('Used by: WidgetSpan'),
    ],
  );
}
