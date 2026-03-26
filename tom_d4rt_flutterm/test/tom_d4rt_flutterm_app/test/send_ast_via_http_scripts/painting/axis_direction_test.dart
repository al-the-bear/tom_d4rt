// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AxisDirection from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AxisDirection test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nAxisDirection values:');
  for (final value in AxisDirection.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('AxisDirection has ${AxisDirection.values.length} values');

  // First and last
  final first = AxisDirection.values.first;
  final last = AxisDirection.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values with geometric meaning
  print('\nSpecific values:');
  print('up: ${AxisDirection.up.name} (index ${AxisDirection.up.index})');
  print('  Points toward the top of the screen (negative y)');
  print('right: ${AxisDirection.right.name} (index ${AxisDirection.right.index})');
  print('  Points toward the right of the screen (positive x)');
  print('down: ${AxisDirection.down.name} (index ${AxisDirection.down.index})');
  print('  Points toward the bottom of the screen (positive y)');
  print('left: ${AxisDirection.left.name} (index ${AxisDirection.left.index})');
  print('  Points toward the left of the screen (negative x)');

  // axisDirectionToAxis mapping
  print('\nAxis mapping (axisDirectionToAxis):');
  for (final dir in AxisDirection.values) {
    final axis = axisDirectionToAxis(dir);
    print('  $dir -> $axis');
  }

  // Opposite directions
  print('\nFlip direction (flipAxisDirection):');
  for (final dir in AxisDirection.values) {
    final flipped = flipAxisDirection(dir);
    print('  $dir -> $flipped');
  }

  // Positive direction check
  print('\nIs positive (axisDirectionIsReversed):');
  for (final dir in AxisDirection.values) {
    final reversed = axisDirectionIsReversed(dir);
    print('  $dir: reversed=$reversed');
  }

  // Pairs of opposites
  print('\nOpposite pairs:');
  print('  up <-> down: ${flipAxisDirection(AxisDirection.up) == AxisDirection.down}');
  print('  left <-> right: ${flipAxisDirection(AxisDirection.left) == AxisDirection.right}');

  // Horizontal vs vertical
  print('\nHorizontal vs Vertical:');
  for (final dir in AxisDirection.values) {
    final axis = axisDirectionToAxis(dir);
    final isHoriz = axis == Axis.horizontal;
    print('  ${dir.name}: ${isHoriz ? "horizontal" : "vertical"}');
  }

  // Equality tests
  print('\nEquality tests:');
  print('up == up: ${AxisDirection.up == AxisDirection.up}');
  print('up == down: ${AxisDirection.up == AxisDirection.down}');
  print('identical: ${identical(AxisDirection.up, AxisDirection.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is AxisDirection: ${first is AxisDirection}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in AxisDirection.values) {
    print('  toString: $value, name: ${value.name}');
  }

  print('\n' + '=' * 50);
  print('AxisDirection test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AxisDirection Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${AxisDirection.values.length}'),
      for (final v in AxisDirection.values)
        Text('  ${v.name} -> ${axisDirectionToAxis(v)}'),
      Text('Scroll/layout direction utility'),
    ],
  );
}
