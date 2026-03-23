// ignore_for_file: avoid_print
// D4rt test script: Tests KeyboardLockMode from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyboardLockMode test executing');

  // Enumerate all KeyboardLockMode values
  print('KeyboardLockMode values:');
  for (final value in KeyboardLockMode.values) {
    print('  ${value.name}: $value');
  }
  print('KeyboardLockMode has ${KeyboardLockMode.values.length} values');

  final first = KeyboardLockMode.values.first;
  final last = KeyboardLockMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('KeyboardLockMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyboardLockMode Tests'),
      Text('Values: ${KeyboardLockMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
