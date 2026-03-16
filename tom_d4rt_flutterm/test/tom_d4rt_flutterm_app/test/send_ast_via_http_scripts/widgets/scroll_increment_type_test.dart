// D4rt test script: Tests ScrollIncrementType from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollIncrementType test executing');

  // Enumerate all ScrollIncrementType values
  print('ScrollIncrementType values:');
  for (final value in ScrollIncrementType.values) {
    print('  ${value.name}: $value');
  }
  print('ScrollIncrementType has ${ ScrollIncrementType.values.length} values');

  final first = ScrollIncrementType.values.first;
  final last = ScrollIncrementType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ScrollIncrementType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollIncrementType Tests'),
      Text('Values: ${ ScrollIncrementType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
