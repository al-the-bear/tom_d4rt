// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextWidthBasis from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextWidthBasis test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nTextWidthBasis values:');
  for (final value in TextWidthBasis.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TextWidthBasis has ${TextWidthBasis.values.length} values');

  // First and last
  final first = TextWidthBasis.values.first;
  final last = TextWidthBasis.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('parent: ${TextWidthBasis.parent.name} (index ${TextWidthBasis.parent.index})');
  print('  Text width is determined by the parent constraints');
  print('  Uses the full available width from the parent');
  print('  Default behavior for Text widget');
  print('  Results in left-aligned text that fills container width');
  print('longestLine: ${TextWidthBasis.longestLine.name} (index ${TextWidthBasis.longestLine.index})');
  print('  Text width matches the width of the longest line');
  print('  Creates a tight-fitting text box');
  print('  Useful when centering multi-line text blocks');
  print('  Prevents unnecessary whitespace on short lines');

  // Visual difference example
  print('\nVisual difference:');
  print('  Text: "Hello\nworld!"');
  print('  parent: width = container width (e.g., 300px)');
  print('  longestLine: width = width of "world!" (e.g., 50px)');
  print('  With Center: parent centers the full-width block');
  print('  With Center: longestLine centers the tight block');

  // Text widget usage
  print('\nText widget usage:');
  for (final basis in TextWidthBasis.values) {
    print('  Text("...", textWidthBasis: TextWidthBasis.${basis.name})');
  }

  // TextPainter integration
  print('\nTextPainter integration:');
  print('  TextPainter uses textWidthBasis to determine layout width');
  print('  parent: TextPainter.width = maxWidth constraint');
  print('  longestLine: TextPainter.width = longest line measurement');

  // When to use each
  print('\nWhen to use:');
  print('  parent: left-aligned single column text');
  print('  parent: text that should fill available space');
  print('  longestLine: centered multi-line headings');
  print('  longestLine: text in bubbles/tooltips');
  print('  longestLine: poetry or short-form text');

  // Equality tests
  print('\nEquality tests:');
  print('parent == parent: ${TextWidthBasis.parent == TextWidthBasis.parent}');
  print('parent == longestLine: ${TextWidthBasis.parent == TextWidthBasis.longestLine}');
  print('identical: ${identical(TextWidthBasis.parent, TextWidthBasis.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is TextWidthBasis: ${first is TextWidthBasis}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in TextWidthBasis.values) {
    print('  toString: $value, name: ${value.name}');
  }

  print('\n' + '=' * 50);
  print('TextWidthBasis test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextWidthBasis Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${TextWidthBasis.values.length}'),
      for (final v in TextWidthBasis.values)
        Text('  ${v.name} (${v.index})'),
      Text('TextPainter: width calculation strategy'),
    ],
  );
}
