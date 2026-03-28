// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BoxFit from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxFit test executing');
  print('=' * 50);

  // BoxFit enum overview
  print('BoxFit enum overview:');
  print('  - How to fit content into box');
  print('  - Used in Image, FittedBox');
  print('  - 7 values');

  // Enumerate all values
  print('\nBoxFit values:');
  for (final value in BoxFit.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('BoxFit has ${BoxFit.values.length} values');

  // Test fill
  print('\nTest BoxFit.fill:');
  print('  Stretches to fill, ignores aspect ratio');

  // Test contain
  print('\nTest BoxFit.contain:');
  print('  Scales to fit within, keeps aspect ratio');
  print('  May leave empty space');

  // Test cover
  print('\nTest BoxFit.cover:');
  print('  Scales to cover box, keeps aspect ratio');
  print('  May crop content');

  // Test fitWidth
  print('\nTest BoxFit.fitWidth:');
  print('  Scales to match width');
  print('  May overflow or underflow vertically');

  // Test fitHeight
  print('\nTest BoxFit.fitHeight:');
  print('  Scales to match height');
  print('  May overflow or underflow horizontally');

  // Test none
  print('\nTest BoxFit.none:');
  print('  No scaling, original size');
  print('  Centers content');

  // Test scaleDown
  print('\nTest BoxFit.scaleDown:');
  print('  Like contain but never scales up');
  print('  Only scales down if needed');

  // First and last
  print('\nFirst and last:');
  print('  First: ${BoxFit.values.first}');
  print('  Last: ${BoxFit.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  Image.fit');
  print('  FittedBox.fit');
  print('  DecorationImage.fit');

  // Common patterns
  print('\nCommon patterns:');
  print('  Avatar images: BoxFit.cover');
  print('  Logos: BoxFit.contain');
  print('  Backgrounds: BoxFit.cover');
  print('  Icons: BoxFit.scaleDown');

  print('\n' + '=' * 50);
  print('BoxFit test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxFit Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: fill, contain, cover, etc.'),
      Text('Purpose: Content scaling'),
    ],
  );
}
