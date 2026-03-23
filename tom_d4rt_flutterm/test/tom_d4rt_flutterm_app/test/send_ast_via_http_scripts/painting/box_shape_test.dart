// ignore_for_file: avoid_print
// D4rt test script: Tests BoxShape from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxShape test executing');

  // Enumerate all BoxShape values
  print('BoxShape values:');
  for (final value in BoxShape.values) {
    print('  ${value.name}: $value');
  }
  print('BoxShape has ${ BoxShape.values.length} values');

  final first = BoxShape.values.first;
  final last = BoxShape.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('BoxShape test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxShape Tests'),
      Text('Values: ${ BoxShape.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
