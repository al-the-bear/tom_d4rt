// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SnackBarBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnackBarBehavior test executing');

  // Enumerate all SnackBarBehavior values
  print('SnackBarBehavior values:');
  for (final value in SnackBarBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('SnackBarBehavior has ${ SnackBarBehavior.values.length} values');

  // Test first and last
  final first = SnackBarBehavior.values.first;
  final last = SnackBarBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SnackBarBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SnackBarBehavior Tests'),
      Text('Values: ${ SnackBarBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
