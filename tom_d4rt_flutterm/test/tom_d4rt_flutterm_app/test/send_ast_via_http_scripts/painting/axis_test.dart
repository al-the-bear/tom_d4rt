// D4rt test script: Tests Axis from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Axis test executing');

  // Enumerate all Axis values
  print('Axis values:');
  for (final value in Axis.values) {
    print('  ${value.name}: $value');
  }
  print('Axis has ${Axis.values.length} values');

  final first = Axis.values.first;
  final last = Axis.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('Axis test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Axis Tests'),
      Text('Values: ${Axis.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
