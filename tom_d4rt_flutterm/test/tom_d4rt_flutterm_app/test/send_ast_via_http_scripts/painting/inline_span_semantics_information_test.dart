// D4rt test script: Tests InlineSpanSemanticsInformation from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InlineSpanSemanticsInformation test executing');

  // Create InlineSpanSemanticsInformation
  final info = InlineSpanSemanticsInformation(
    'Click here',
    isPlaceholder: false,
    stringAttributes: [],
  );

  print('Created: ${info.runtimeType}');

  // Test properties
  print('\nSemantics info properties:');
  print('text: ${info.text}');
  print('isPlaceholder: ${info.isPlaceholder}');
  print('semanticsLabel: ${info.semanticsLabel}');
  print('recognizer: ${info.recognizer}');

  // What it represents
  print('\nWhat it represents:');
  print('- Semantics for a span of text');
  print('- Used by screen readers');
  print('- Includes tap handlers for links');

  // isPlaceholder
  print('\nisPlaceholder:');
  print('- true for WidgetSpan');
  print('- false for TextSpan');
  print('- Affects how semantics are built');

  // Recognizer
  print('\nRecognizer:');
  print('- GestureRecognizer for taps');
  print('- Makes text tappable for a11y');
  print('- Used by TapGestureRecognizer');

  // String attributes
  print('\nstringAttributes:');
  print('- SpellOutStringAttribute');
  print('- LocaleStringAttribute');
  print('- For custom pronunciation');

  // Usage
  print('\nUsage:');
  print('TextSpan.getSemanticsInformation()');
  print('- Returns List<InlineSpanSemanticsInformation>');
  print('- Used to build SemanticsNode');

  print('\nInlineSpanSemanticsInformation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'InlineSpanSemanticsInformation Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Span semantics data'),
      Text('text: ${info.text}'),
      Text('For: screen readers'),
    ],
  );
}
