// D4rt test script: Tests WordBoundary from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WordBoundary test executing');

  // WordBoundary is created internally by TextPainter
  // It extends TextBoundary and has a private constructor
  print('WordBoundary overview:');
  print('- Extends TextBoundary');
  print('- Created internally by TextPainter.wordBoundaries');
  print('- Private constructor: WordBoundary._()');

  // Test TextRange which WordBoundary uses internally
  const wordRange = TextRange(start: 0, end: 5);
  print('\nTextRange (used by WordBoundary):');
  print('range: $wordRange');
  print('range.start: ${wordRange.start}');
  print('range.end: ${wordRange.end}');

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
  print('textPainter.wordBoundaries');
  print('- Returns WordBoundary');
  print('- getTextBoundaryAt(position) → TextRange');
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
      Text('range: $wordRange'),
      Text('For: word selection'),
    ],
  );
}
