// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WrapCrossAlignment from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WrapCrossAlignment test executing');
  print('=' * 50);

  // WrapCrossAlignment enum overview
  print('WrapCrossAlignment enum overview:');
  print('  - Cross axis alignment for Wrap');
  print('  - Controls item alignment within run');
  print('  - 3 values: start, end, center');

  // Enumerate all values
  print('\nWrapCrossAlignment values:');
  for (final value in WrapCrossAlignment.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('WrapCrossAlignment has ${WrapCrossAlignment.values.length} values');

  // Test start
  print('\nTest WrapCrossAlignment.start:');
  final start = WrapCrossAlignment.start;
  print('  Name: ${start.name}');
  print('  Index: ${start.index}');
  print('  Items align at cross axis start');

  // Test end
  print('\nTest WrapCrossAlignment.end:');
  final end = WrapCrossAlignment.end;
  print('  Name: ${end.name}');
  print('  Index: ${end.index}');
  print('  Items align at cross axis end');

  // Test center
  print('\nTest WrapCrossAlignment.center:');
  final center = WrapCrossAlignment.center;
  print('  Name: ${center.name}');
  print('  Index: ${center.index}');
  print('  Items align at cross axis center');

  // Visual behavior (horizontal wrap)
  print('\nVisual behavior (horizontal wrap):');
  print('  start: Items align to top of run');
  print('  end: Items align to bottom of run');
  print('  center: Items center vertically');

  // Visual behavior (vertical wrap)
  print('\nVisual behavior (vertical wrap):');
  print('  start: Items align to left of run');
  print('  end: Items align to right of run');
  print('  center: Items center horizontally');

  // Usage context
  print('\nUsage context:');
  print('  Wrap.crossAxisAlignment');
  print('  RenderWrap uses this');

  // Comparison
  print('\nComparison:');
  print('  start == start: ${WrapCrossAlignment.start == WrapCrossAlignment.start}');
  print('  start == end: ${WrapCrossAlignment.start == WrapCrossAlignment.end}');

  // Switch pattern
  print('\nSwitch pattern:');
  final align = WrapCrossAlignment.center;
  switch (align) {
    case WrapCrossAlignment.start:
      print('  Align at start');
      break;
    case WrapCrossAlignment.end:
      print('  Align at end');
      break;
    case WrapCrossAlignment.center:
      print('  Align at center');
      break;
  }

  // Related enums
  print('\nRelated enums:');
  print('  WrapAlignment: Main axis');
  print('  CrossAxisAlignment: Flex');

  print('\n' + '=' * 50);
  print('WrapCrossAlignment test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WrapCrossAlignment Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: start, end, center'),
      Text('Purpose: Wrap cross alignment'),
    ],
  );
}
