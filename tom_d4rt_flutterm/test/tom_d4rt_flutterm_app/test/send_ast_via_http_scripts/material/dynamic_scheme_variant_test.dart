// ignore_for_file: avoid_print
// D4rt test script: Tests DynamicSchemeVariant from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DynamicSchemeVariant test executing');

  // Enumerate all DynamicSchemeVariant values
  print('DynamicSchemeVariant values:');
  for (final value in DynamicSchemeVariant.values) {
    print('  ${value.name}: $value');
  }
  print('DynamicSchemeVariant has ${ DynamicSchemeVariant.values.length} values');

  final first = DynamicSchemeVariant.values.first;
  final last = DynamicSchemeVariant.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DynamicSchemeVariant test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DynamicSchemeVariant Tests'),
      Text('Values: ${ DynamicSchemeVariant.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
