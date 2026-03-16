// D4rt test script: Tests PointerChange from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PointerChange test executing');

  // Enumerate all PointerChange values
  print('PointerChange values:');
  for (final value in PointerChange.values) {
    print('  ${value.name}: $value');
  }
  print('PointerChange has ${ PointerChange.values.length} values');

  final first = PointerChange.values.first;
  final last = PointerChange.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PointerChange test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerChange Tests'),
      Text('Values: ${ PointerChange.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
