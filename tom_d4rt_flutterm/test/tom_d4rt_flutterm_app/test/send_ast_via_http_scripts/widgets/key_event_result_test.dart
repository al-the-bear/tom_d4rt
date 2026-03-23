// ignore_for_file: avoid_print
// D4rt test script: Tests KeyEventResult from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyEventResult test executing');

  // Enumerate all KeyEventResult values
  print('KeyEventResult values:');
  for (final value in KeyEventResult.values) {
    print('  ${value.name}: $value');
  }
  print('KeyEventResult has ${ KeyEventResult.values.length} values');

  final first = KeyEventResult.values.first;
  final last = KeyEventResult.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('KeyEventResult test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyEventResult Tests'),
      Text('Values: ${ KeyEventResult.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
