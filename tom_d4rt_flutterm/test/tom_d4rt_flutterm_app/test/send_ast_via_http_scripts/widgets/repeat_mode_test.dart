// ignore_for_file: avoid_print
// D4rt test script: Tests RepeatMode from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RepeatMode test executing');

  // Enumerate all RepeatMode values
  print('RepeatMode values:');
  for (final value in RepeatMode.values) {
    print('  ${value.name}: $value');
  }
  print('RepeatMode has ${ RepeatMode.values.length} values');

  final first = RepeatMode.values.first;
  final last = RepeatMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('RepeatMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RepeatMode Tests'),
      Text('Values: ${ RepeatMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
