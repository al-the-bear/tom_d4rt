// ignore_for_file: avoid_print
// D4rt test script: Tests LockState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LockState test executing');

  // Enumerate all LockState values
  print('LockState values:');
  for (final value in LockState.values) {
    print('  ${value.name}: $value');
  }
  print('LockState has ${ LockState.values.length} values');

  final first = LockState.values.first;
  final last = LockState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('LockState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LockState Tests'),
      Text('Values: ${ LockState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
