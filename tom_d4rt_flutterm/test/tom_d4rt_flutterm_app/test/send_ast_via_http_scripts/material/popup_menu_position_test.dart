// ignore_for_file: avoid_print
// D4rt test script: Tests PopupMenuPosition from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PopupMenuPosition test executing');

  // Enumerate all PopupMenuPosition values
  print('PopupMenuPosition values:');
  for (final value in PopupMenuPosition.values) {
    print('  ${value.name}: $value');
  }
  print('PopupMenuPosition has ${ PopupMenuPosition.values.length} values');

  final first = PopupMenuPosition.values.first;
  final last = PopupMenuPosition.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PopupMenuPosition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopupMenuPosition Tests'),
      Text('Values: ${ PopupMenuPosition.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
