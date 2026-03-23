// ignore_for_file: avoid_print
// D4rt test script: Tests SnackBarClosedReason from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnackBarClosedReason test executing');

  // Enumerate all SnackBarClosedReason values
  print('SnackBarClosedReason values:');
  for (final value in SnackBarClosedReason.values) {
    print('  ${value.name}: $value');
  }
  print('SnackBarClosedReason has ${ SnackBarClosedReason.values.length} values');

  // Test first and last
  final first = SnackBarClosedReason.values.first;
  final last = SnackBarClosedReason.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SnackBarClosedReason test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SnackBarClosedReason Tests'),
      Text('Values: ${ SnackBarClosedReason.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
