// D4rt test script: Tests AxisDirection from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AxisDirection test executing');

  // Enumerate all AxisDirection values
  print('AxisDirection values:');
  for (final value in AxisDirection.values) {
    print('  ${value.name}: $value');
  }
  print('AxisDirection has ${ AxisDirection.values.length} values');

  final first = AxisDirection.values.first;
  final last = AxisDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('AxisDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AxisDirection Tests'),
      Text('Values: ${ AxisDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
