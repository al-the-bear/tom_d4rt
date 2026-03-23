// ignore_for_file: avoid_print
// D4rt test script: Tests ScrollPositionAlignmentPolicy from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollPositionAlignmentPolicy test executing');

  // Enumerate all ScrollPositionAlignmentPolicy values
  print('ScrollPositionAlignmentPolicy values:');
  for (final value in ScrollPositionAlignmentPolicy.values) {
    print('  ${value.name}: $value');
  }
  print('ScrollPositionAlignmentPolicy has ${ ScrollPositionAlignmentPolicy.values.length} values');

  final first = ScrollPositionAlignmentPolicy.values.first;
  final last = ScrollPositionAlignmentPolicy.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ScrollPositionAlignmentPolicy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollPositionAlignmentPolicy Tests'),
      Text('Values: ${ ScrollPositionAlignmentPolicy.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
