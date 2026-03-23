// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BottomNavigationBarType from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BottomNavigationBarType test executing');

  // Enumerate all BottomNavigationBarType values
  print('BottomNavigationBarType values:');
  for (final value in BottomNavigationBarType.values) {
    print('  ${value.name}: $value');
  }
  print('BottomNavigationBarType has ${ BottomNavigationBarType.values.length} values');

  final first = BottomNavigationBarType.values.first;
  final last = BottomNavigationBarType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('BottomNavigationBarType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BottomNavigationBarType Tests'),
      Text('Values: ${ BottomNavigationBarType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
