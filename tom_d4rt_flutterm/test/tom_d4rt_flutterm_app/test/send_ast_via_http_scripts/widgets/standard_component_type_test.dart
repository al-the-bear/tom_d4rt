// ignore_for_file: avoid_print
// D4rt test script: Tests StandardComponentType from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StandardComponentType test executing');

  // Enumerate all StandardComponentType values
  print('StandardComponentType values:');
  for (final value in StandardComponentType.values) {
    print('  ${value.name}: $value');
  }
  print('StandardComponentType has ${ StandardComponentType.values.length} values');

  final first = StandardComponentType.values.first;
  final last = StandardComponentType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('StandardComponentType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StandardComponentType Tests'),
      Text('Values: ${ StandardComponentType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
