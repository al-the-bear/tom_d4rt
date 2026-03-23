// ignore_for_file: avoid_print
// D4rt test script: Tests AndroidOverscrollIndicator from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AndroidOverscrollIndicator test executing');

  // Enumerate all AndroidOverscrollIndicator values
  print('AndroidOverscrollIndicator values:');
  for (final value in AndroidOverscrollIndicator.values) {
    print('  ${value.name}: $value');
  }
  print('AndroidOverscrollIndicator has ${ AndroidOverscrollIndicator.values.length} values');

  final first = AndroidOverscrollIndicator.values.first;
  final last = AndroidOverscrollIndicator.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('AndroidOverscrollIndicator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AndroidOverscrollIndicator Tests'),
      Text('Values: ${ AndroidOverscrollIndicator.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
