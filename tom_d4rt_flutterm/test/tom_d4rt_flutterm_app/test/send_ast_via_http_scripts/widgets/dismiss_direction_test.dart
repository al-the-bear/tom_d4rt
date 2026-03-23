// ignore_for_file: avoid_print
// D4rt test script: Tests DismissDirection from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DismissDirection test executing');

  // Enumerate all DismissDirection values
  print('DismissDirection values:');
  for (final value in DismissDirection.values) {
    print('  ${value.name}: $value');
  }
  print('DismissDirection has ${ DismissDirection.values.length} values');

  final first = DismissDirection.values.first;
  final last = DismissDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DismissDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DismissDirection Tests'),
      Text('Values: ${ DismissDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
