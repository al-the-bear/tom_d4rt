// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IconAlignment from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IconAlignment test executing');

  // Enumerate all IconAlignment values
  print('IconAlignment values:');
  for (final value in IconAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('IconAlignment has ${ IconAlignment.values.length} values');

  final first = IconAlignment.values.first;
  final last = IconAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('IconAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IconAlignment Tests'),
      Text('Values: ${ IconAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
