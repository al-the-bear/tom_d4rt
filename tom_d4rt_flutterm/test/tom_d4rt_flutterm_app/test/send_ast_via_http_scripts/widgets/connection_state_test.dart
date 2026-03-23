// ignore_for_file: avoid_print
// D4rt test script: Tests ConnectionState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ConnectionState test executing');

  // Enumerate all ConnectionState values
  print('ConnectionState values:');
  for (final value in ConnectionState.values) {
    print('  ${value.name}: $value');
  }
  print('ConnectionState has ${ ConnectionState.values.length} values');

  final first = ConnectionState.values.first;
  final last = ConnectionState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ConnectionState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ConnectionState Tests'),
      Text('Values: ${ ConnectionState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
