// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TabAlignment from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabAlignment test executing');

  // Enumerate all TabAlignment values
  print('TabAlignment values:');
  for (final value in TabAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('TabAlignment has ${ TabAlignment.values.length} values');

  final first = TabAlignment.values.first;
  final last = TabAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TabAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TabAlignment Tests'),
      Text('Values: ${ TabAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
