// D4rt test script: Tests VerticalDirection from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('VerticalDirection test executing');

  // Enumerate all VerticalDirection values
  print('VerticalDirection values:');
  for (final value in VerticalDirection.values) {
    print('  ${value.name}: $value');
  }
  print('VerticalDirection has ${ VerticalDirection.values.length} values');

  final first = VerticalDirection.values.first;
  final last = VerticalDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('VerticalDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VerticalDirection Tests'),
      Text('Values: ${ VerticalDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
