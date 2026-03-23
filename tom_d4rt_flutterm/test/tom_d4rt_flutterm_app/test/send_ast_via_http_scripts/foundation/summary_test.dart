// ignore_for_file: avoid_print
// D4rt test script: Tests Summary annotation from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Summary test executing');
  print('=' * 50);

  // Create Summary with basic description
  final s1 = Summary('A brief description of the class.');
  print('\nSummary created:');
  print('runtimeType: ${s1.runtimeType}');
  print('text: ${s1.text}');

  // Create with longer text
  final s2 = Summary(
    'This is a more detailed summary that explains the purpose and functionality of a class in the Flutter framework. It provides context for developers.',
  );
  print('\nLonger summary:');
  print('text length: ${s2.text.length}');
  print('first 50 chars: ${s2.text.substring(0, 50)}...');

  // Create with empty text
  final s3 = Summary('');
  print('\nEmpty summary:');
  print('text: "${s3.text}"');
  print('text.isEmpty: ${s3.text.isEmpty}');

  // Create with special characters
  final s4 = Summary(
    'A widget for displaying text<T> with "quotes" and apostrophe\'s.',
  );
  print('\nSpecial characters:');
  print('text: ${s4.text}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: true /* s1 is Object */');

  // Compare instances
  final sameSummary1 = Summary('Same text');
  final sameSummary2 = Summary('Same text');
  print('\nInstance comparison:');
  print('sameSummary1 == sameSummary2: ${sameSummary1 == sameSummary2}');
  print(
    'identical(sameSummary1, sameSummary2): ${identical(sameSummary1, sameSummary2)}',
  );
  print(
    'sameSummary1.text == sameSummary2.text: ${sameSummary1.text == sameSummary2.text}',
  );

  // Text properties
  print('\nText properties:');
  print('s1.text.length: ${s1.text.length}');
  print('s1.text.contains("class"): ${s1.text.contains("class")}');
  print('s1.text.startsWith("A"): ${s1.text.startsWith("A")}');

  // Common usage patterns
  print('\nCommon Summary examples:');
  final widgetSummary = Summary(
    'A widget that displays its children in a horizontal array.',
  );
  final mixinSummary = Summary(
    'A mixin that provides debugging methods for diagnostics.',
  );
  final classSummary = Summary('Represents a color in the ARGB color space.');
  print('Widget summary: ${widgetSummary.text.substring(0, 30)}...');
  print('Mixin summary: ${mixinSummary.text.substring(0, 30)}...');
  print('Class summary: ${classSummary.text.substring(0, 30)}...');

  // Explain purpose
  print('\nSummary purpose:');
  print('- Annotation used to provide brief API descriptions');
  print('- Text appears in API documentation summaries');
  print('- Helps dartdoc generate meaningful overview text');
  print('- Should be concise and informative');
  print('- Usually one or two sentences');

  print('\n' + '=' * 50);
  print('Summary test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Summary Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${s1.runtimeType}'),
      Text('Basic text: ${s1.text}'),
      Text('Empty isEmpty: ${s3.text.isEmpty}'),
      Text('Same text equals: ${sameSummary1.text == sameSummary2.text}'),
      Text('Purpose: Documentation summary annotation'),
    ],
  );
}
