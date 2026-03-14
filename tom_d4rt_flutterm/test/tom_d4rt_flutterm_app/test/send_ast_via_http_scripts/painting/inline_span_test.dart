// D4rt test script: Tests InlineSpan from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('InlineSpan test executing');

  // InlineSpan is abstract - test via subclasses
  print('InlineSpan is abstract base class');

  // TextSpan is subclass
  final textSpan = TextSpan(
    text: 'Hello ',
    style: TextStyle(color: Colors.blue),
    children: [
      TextSpan(
        text: 'World',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  );

  print('\nTextSpan (subclass of InlineSpan):');
  print('type: ${textSpan.runtimeType}');
  print('is InlineSpan: ${textSpan is InlineSpan}');
  print('text: ${textSpan.text}');
  print('children: ${textSpan.children?.length ?? 0}');

  // WidgetSpan is also subclass
  final widgetSpan = WidgetSpan(
    child: Icon(Icons.star, size: 16),
    alignment: ui.PlaceholderAlignment.middle,
  );
  print('\nWidgetSpan (subclass of InlineSpan):');
  print('type: ${widgetSpan.runtimeType}');
  print('is InlineSpan: ${widgetSpan is InlineSpan}');
  print('alignment: ${widgetSpan.alignment}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('InlineSpan (abstract)');
  print('  └── TextSpan');
  print('  └── PlaceholderSpan (abstract)');
  print('      └── WidgetSpan');

  // Key methods/properties
  print('\nInlineSpan API:');
  print('- style: TextStyle for span');
  print('- visitChildren(): traverse tree');
  print('- build(): create rendering');
  print('- getSpanForPosition(): hit testing');

  print('\nInlineSpan test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'InlineSpan Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract span base class'),
      Text('Subclasses: TextSpan, WidgetSpan'),
      Text('Tree of styled text/widgets'),
    ],
  );
}
