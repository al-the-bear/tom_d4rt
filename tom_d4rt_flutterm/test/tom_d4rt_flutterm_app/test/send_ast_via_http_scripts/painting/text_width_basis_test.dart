// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextWidthBasis from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextWidthBasis test executing');
  print('=' * 50);

  // TextWidthBasis enum overview
  print('TextWidthBasis enum overview:');
  print('  - How to measure text width');
  print('  - Used in TextPainter');
  print('  - 2 values: parent, longestLine');

  // Enumerate all values
  print('\nTextWidthBasis values:');
  for (final value in TextWidthBasis.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TextWidthBasis has ${TextWidthBasis.values.length} values');

  // Test parent
  print('\nTest TextWidthBasis.parent:');
  final parent = TextWidthBasis.parent;
  print('  Name: ${parent.name}');
  print('  Width: Uses parent constraint');
  print('  Behavior: Full available width');

  // Test longestLine
  print('\nTest TextWidthBasis.longestLine:');
  final longestLine = TextWidthBasis.longestLine;
  print('  Name: ${longestLine.name}');
  print('  Width: Actual longest line');
  print('  Behavior: Tight to content');

  // First and last
  print('\nFirst and last:');
  print('  First: ${TextWidthBasis.values.first}');
  print('  Last: ${TextWidthBasis.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  TextPainter.textWidthBasis');
  print('  RenderParagraph');
  print('  Text layout calculations');

  // Practical difference
  print('\nPractical difference:');
  print('  parent: Good for alignment in column');
  print('  longestLine: Tight intrinsic sizing');

  // Example scenario
  print('\nExample scenario:');
  print('  Text: "Hello world"');
  print('  parent: May be wider than text');
  print('  longestLine: Exactly text width');

  // Switch pattern
  print('\nSwitch pattern:');
  final basis = TextWidthBasis.longestLine;
  switch (basis) {
    case TextWidthBasis.parent:
      print('  Using parent width');
      break;
    case TextWidthBasis.longestLine:
      print('  Using content width');
      break;
  }

  // Comparison
  print('\nComparison:');
  print('  parent == parent: ${TextWidthBasis.parent == TextWidthBasis.parent}');
  print('  parent == longestLine: ${TextWidthBasis.parent == TextWidthBasis.longestLine}');

  // Default
  print('\nDefault:');
  print('  TextPainter default: parent');

  print('\n' + '=' * 50);
  print('TextWidthBasis test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextWidthBasis Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: parent, longestLine'),
      Text('Purpose: Width measurement'),
    ],
  );
}
