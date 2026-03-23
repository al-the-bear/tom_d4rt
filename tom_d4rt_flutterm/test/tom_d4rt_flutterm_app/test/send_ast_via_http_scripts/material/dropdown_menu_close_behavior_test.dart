// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DropdownMenuCloseBehavior from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DropdownMenuCloseBehavior test executing');

  // Enumerate all DropdownMenuCloseBehavior values
  print('DropdownMenuCloseBehavior values:');
  for (final value in DropdownMenuCloseBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('DropdownMenuCloseBehavior has ${ DropdownMenuCloseBehavior.values.length} values');

  final first = DropdownMenuCloseBehavior.values.first;
  final last = DropdownMenuCloseBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DropdownMenuCloseBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DropdownMenuCloseBehavior Tests'),
      Text('Values: ${ DropdownMenuCloseBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
