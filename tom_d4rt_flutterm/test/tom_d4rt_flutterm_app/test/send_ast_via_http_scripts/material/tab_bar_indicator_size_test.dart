// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TabBarIndicatorSize from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabBarIndicatorSize test executing');

  // Enumerate all TabBarIndicatorSize values
  print('TabBarIndicatorSize values:');
  for (final value in TabBarIndicatorSize.values) {
    print('  ${value.name}: $value');
  }
  print('TabBarIndicatorSize has ${ TabBarIndicatorSize.values.length} values');

  // Test first and last
  final first = TabBarIndicatorSize.values.first;
  final last = TabBarIndicatorSize.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TabBarIndicatorSize test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TabBarIndicatorSize Tests'),
      Text('Values: ${ TabBarIndicatorSize.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
