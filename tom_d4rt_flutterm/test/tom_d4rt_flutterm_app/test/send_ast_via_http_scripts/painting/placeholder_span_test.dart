// D4rt test script: Tests PlaceholderSpan from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('PlaceholderSpan test executing');

  // PlaceholderSpan is abstract - test via WidgetSpan
  final widgetSpan = WidgetSpan(
    child: Icon(Icons.star, size: 16),
    alignment: ui.PlaceholderAlignment.middle,
  );

  print('WidgetSpan (extends PlaceholderSpan):');
  print('type: ${widgetSpan.runtimeType}');
  print('is PlaceholderSpan: ${widgetSpan is PlaceholderSpan}');

  // Properties
  print('\nPlaceholderSpan properties:');
  print('alignment: ${widgetSpan.alignment}');
  print('baseline: ${widgetSpan.baseline}');

  // PlaceholderAlignment values
  print('\nPlaceholderAlignment values:');
  print('- baseline: align to text baseline');
  print('- aboveBaseline: above baseline');
  print('- belowBaseline: below baseline');
  print('- top: top of line box');
  print('- bottom: bottom of line box');
  print('- middle: vertically centered');

  // Type hierarchy
  print('\nType hierarchy:');
  print('InlineSpan (abstract)');
  print('  └── PlaceholderSpan (abstract)');
  print('      └── WidgetSpan');

  // Purpose
  print('\nPurpose:');
  print('- Reserves space in text');
  print('- For inline non-text content');
  print('- Emoji, icons, widgets');

  // Usage
  print('\nUsage:');
  print('RichText(text: TextSpan(children: [');
  print('  TextSpan(text: "Stars: "),');
  print('  WidgetSpan(child: Icon(Icons.star)),');
  print(']))');

  print('\nPlaceholderSpan test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlaceholderSpan Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract inline placeholder'),
      Text('Subclass: WidgetSpan'),
      Text('For inline widgets in text'),
    ],
  );
}
