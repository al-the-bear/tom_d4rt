// D4rt test script: Tests OverflowBoxFit from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverflowBoxFit test executing');

  // Enumerate all OverflowBoxFit values
  print('OverflowBoxFit values:');
  for (final value in OverflowBoxFit.values) {
    print('  ${value.name}: $value');
  }
  print('OverflowBoxFit has ${ OverflowBoxFit.values.length} values');

  final first = OverflowBoxFit.values.first;
  final last = OverflowBoxFit.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('OverflowBoxFit test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverflowBoxFit Tests'),
      Text('Values: ${ OverflowBoxFit.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
