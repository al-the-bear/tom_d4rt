// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests VerticalDirection from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('VerticalDirection test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nVerticalDirection values:');
  for (final value in VerticalDirection.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('VerticalDirection has ${VerticalDirection.values.length} values');

  // First and last
  final first = VerticalDirection.values.first;
  final last = VerticalDirection.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('up: ${VerticalDirection.up.name} (index ${VerticalDirection.up.index})');
  print('  Children are laid out from bottom to top');
  print('  First child is at the bottom, last child at the top');
  print('  Reverses the natural top-to-bottom order');
  print('down: ${VerticalDirection.down.name} (index ${VerticalDirection.down.index})');
  print('  Children are laid out from top to bottom');
  print('  First child is at the top, last child at the bottom');
  print('  Default direction for Column and Flex(vertical)');

  // Column usage
  print('\nColumn usage:');
  print('  Column(verticalDirection: VerticalDirection.down) — default');
  print('  Column(verticalDirection: VerticalDirection.up) — reversed');
  print('  Affects both layout order and mainAxisAlignment behavior');

  // Flex usage
  print('\nFlex usage:');
  print('  Flex(direction: Axis.vertical, verticalDirection: VerticalDirection.down)');
  print('  Flex(direction: Axis.vertical, verticalDirection: VerticalDirection.up)');
  print('  Also affects cross-axis alignment interpretation');

  // Interaction with MainAxisAlignment
  print('\nMainAxisAlignment interaction:');
  print('  down + start: children at the top');
  print('  down + end: children at the bottom');
  print('  up + start: children at the bottom');
  print('  up + end: children at the top');
  print('  up effectively reverses start/end semantics');

  // ListView and CustomScrollView
  print('\nScroll views:');
  print('  ListView does not directly use VerticalDirection');
  print('  ListView uses reverse: true/false instead');
  print('  But Slivers use GrowthDirection which relates to VerticalDirection');

  // Equality tests
  print('\nEquality tests:');
  print('up == up: ${VerticalDirection.up == VerticalDirection.up}');
  print('up == down: ${VerticalDirection.up == VerticalDirection.down}');
  print('identical: ${identical(VerticalDirection.up, VerticalDirection.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is VerticalDirection: ${first is VerticalDirection}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in VerticalDirection.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Collection operations
  print('\nCollection operations:');
  final dirMap = {for (final d in VerticalDirection.values) d.name: d.index};
  print('  Map: $dirMap');
  print('  Reversed: ${VerticalDirection.values.reversed.map((v) => v.name).join(', ')}');

  print('\n' + '=' * 50);
  print('VerticalDirection test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'VerticalDirection Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${VerticalDirection.values.length}'),
      for (final v in VerticalDirection.values)
        Text('  ${v.name} (${v.index})'),
      Text('Column/Flex: child ordering direction'),
    ],
  );
}
