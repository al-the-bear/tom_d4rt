// D4rt test script: Tests BorderStyle from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BorderStyle test executing');

  // Enumerate all BorderStyle values
  print('BorderStyle values:');
  for (final value in BorderStyle.values) {
    print('  ${value.name}: $value');
  }
  print('BorderStyle has ${ BorderStyle.values.length} values');

  final first = BorderStyle.values.first;
  final last = BorderStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('BorderStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BorderStyle Tests'),
      Text('Values: ${ BorderStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
