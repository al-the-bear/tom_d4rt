// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Axis from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Axis test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nAxis values:');
  for (final value in Axis.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('Axis has ${Axis.values.length} values');

  // First and last
  final first = Axis.values.first;
  final last = Axis.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('horizontal: ${Axis.horizontal.name} (index ${Axis.horizontal.index})');
  print('  Represents the x-axis, left-to-right or right-to-left');
  print('  Used by: Row, ListView.horizontal, horizontal scroll');
  print('vertical: ${Axis.vertical.name} (index ${Axis.vertical.index})');
  print('  Represents the y-axis, top-to-bottom or bottom-to-top');
  print('  Used by: Column, ListView, vertical scroll');

  // flipAxis utility
  print('\nflipAxis utility:');
  print('  flipAxis(horizontal): ${flipAxis(Axis.horizontal)}');
  print('  flipAxis(vertical): ${flipAxis(Axis.vertical)}');
  print('  Round-trip horizontal: ${flipAxis(flipAxis(Axis.horizontal))}');
  print('  Round-trip vertical: ${flipAxis(flipAxis(Axis.vertical))}');

  // Widget usage contexts
  print('\nWidget usage:');
  print('  Flex(direction: Axis.horizontal) == Row');
  print('  Flex(direction: Axis.vertical) == Column');
  print('  ListView(scrollDirection: Axis.horizontal)');
  print('  ListView(scrollDirection: Axis.vertical) // default');
  print('  Wrap(direction: Axis.horizontal) // default');
  print('  Wrap(direction: Axis.vertical)');

  // Relation to AxisDirection
  print('\nRelation to AxisDirection:');
  print('  horizontal maps to: left, right');
  print('  vertical maps to: up, down');
  for (final dir in AxisDirection.values) {
    print('  axisDirectionToAxis($dir) = ${axisDirectionToAxis(dir)}');
  }

  // Equality tests
  print('\nEquality tests:');
  print('horizontal == horizontal: ${Axis.horizontal == Axis.horizontal}');
  print('horizontal == vertical: ${Axis.horizontal == Axis.vertical}');
  print('identical: ${identical(Axis.horizontal, Axis.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is Axis: ${first is Axis}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in Axis.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Collection operations
  print('\nCollection operations:');
  final axisMap = {for (final a in Axis.values) a.name: a.index};
  print('  Map: $axisMap');
  print('  Reversed: ${Axis.values.reversed.map((v) => v.name).join(', ')}');

  print('\n' + '=' * 50);
  print('Axis test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Axis Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${Axis.values.length}'),
      for (final v in Axis.values)
        Text('  ${v.name} (${v.index})'),
      Text('Layout direction: horizontal/vertical'),
    ],
  );
}
