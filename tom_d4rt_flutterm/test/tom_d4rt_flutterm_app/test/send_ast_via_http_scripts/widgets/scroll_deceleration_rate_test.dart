// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollDecelerationRate from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScrollDecelerationRate test executing');
  print('=' * 50);

  // ScrollDecelerationRate controls momentum decay speed
  print('\nScrollDecelerationRate Analysis:');
  print('  Type: enum');
  print('  Purpose: Rate at which scroll momentum decelerates');
  print('  Used by: ScrollPhysics');

  // Enumerate all values
  print('\nScrollDecelerationRate values:');
  for (final value in ScrollDecelerationRate.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ScrollDecelerationRate has ${ScrollDecelerationRate.values.length} values');

  // Test each value in detail
  print('\nDetailed Value Analysis:');

  // normal
  final normal = ScrollDecelerationRate.normal;
  print('\n1. ScrollDecelerationRate.normal:');
  print('   Name: ${normal.name}');
  print('   Index: ${normal.index}');
  print('   Description: Standard deceleration');
  print('   Aligned with: Mobile software expectations');
  print('   Use case: Touch screen scrolling');

  // fast
  final fast = ScrollDecelerationRate.fast;
  print('\n2. ScrollDecelerationRate.fast:');
  print('   Name: ${fast.name}');
  print('   Index: ${fast.index}');
  print('   Description: Increased deceleration');
  print('   Aligned with: Desktop software expectations');
  print('   Use case: Mouse wheel, trackpad scrolling');
  print('   Stops: More quickly than normal');

  // First and last
  print('\nBoundary Values:');
  final first = ScrollDecelerationRate.values.first;
  final last = ScrollDecelerationRate.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Equality
  print('\nEquality Tests:');
  print('  normal == normal: ${normal == ScrollDecelerationRate.normal}');
  print('  normal == fast: ${normal == fast}');
  print('  fast == fast: ${fast == ScrollDecelerationRate.fast}');

  // Usage in ScrollPhysics
  print('\nUsage in ScrollPhysics:');
  print('  ScrollPhysics uses decelerationRate property');
  print('  Affects ClampingScrollSimulation parameters');
  print('  Controls how momentum decays over time');

  // Platform defaults
  print('\nPlatform Defaults:');
  print('  Android/iOS: typically normal');
  print('  Desktop (mouse wheel): typically fast');

  print('\n' + '=' * 50);
  print('ScrollDecelerationRate test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ScrollDecelerationRate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Value count: ${ScrollDecelerationRate.values.length}'),
      Text('normal: For touch screens'),
      Text('fast: For mouse/trackpad'),
    ],
  );
}
