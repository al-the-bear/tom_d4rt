// D4rt test script: Tests WordBoundary from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WordBoundary test executing');

  // Create WordBoundary
  final boundary = WordBoundary(
    TextRange(start: 0, end: 5),
    true, // isDropped
  );

  print('Created: ${boundary.runtimeType}');

  // Test properties
  print('\nWordBoundary properties:');
  print('range: ${boundary.range}');
  print('range.start: ${boundary.range.start}');
  print('range.end: ${boundary.range.end}');

  // What it represents
  print('\nWhat it represents:');
  print('- A word within text');
  print('- Start/end character indices');
  print('- Used for word selection');

  // Word selection
  print('\nWord selection:');
  print('- Double-tap selects word');
  print('- WordBoundary defines extent');
  print('- Used by TextSelection');

  // TextPainter integration
  print('\nTextPainter integration:');
  print('textPainter.getWordBoundary(position)');
  print('- Returns TextRange');
  print('- Based on Unicode rules');

  // Unicode word boundaries
  print('\nUnicode word boundaries:');
  print('- Spaces separate words');
  print('- Punctuation varies');
  print('- Locale-aware');

  // Example text
  print('\nExample:');
  print('"Hello World"');
  print('Word 1: range(0, 5) "Hello"');
  print('Word 2: range(6, 11) "World"');

  print('\nWordBoundary test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WordBoundary Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Word extent in text'),
      Text('range: ${boundary.range}'),
      Text('For: word selection'),
    ],
  );
}
