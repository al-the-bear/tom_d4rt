// D4rt test script: Tests PathFillType from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PathFillType test executing');

  // Enumerate all PathFillType values
  print('PathFillType values:');
  for (final value in PathFillType.values) {
    print('  ${value.name}: $value');
  }
  print('PathFillType has ${ PathFillType.values.length} values');

  final first = PathFillType.values.first;
  final last = PathFillType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PathFillType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PathFillType Tests'),
      Text('Values: ${ PathFillType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
