// ignore_for_file: avoid_print
// D4rt test script: Tests TabIndicatorAnimation from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabIndicatorAnimation test executing');

  // Enumerate all TabIndicatorAnimation values
  print('TabIndicatorAnimation values:');
  for (final value in TabIndicatorAnimation.values) {
    print('  ${value.name}: $value');
  }
  print('TabIndicatorAnimation has ${ TabIndicatorAnimation.values.length} values');

  final first = TabIndicatorAnimation.values.first;
  final last = TabIndicatorAnimation.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TabIndicatorAnimation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TabIndicatorAnimation Tests'),
      Text('Values: ${ TabIndicatorAnimation.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
