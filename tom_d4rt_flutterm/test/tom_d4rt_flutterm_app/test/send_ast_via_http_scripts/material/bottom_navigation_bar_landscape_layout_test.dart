// D4rt test script: Tests BottomNavigationBarLandscapeLayout from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BottomNavigationBarLandscapeLayout test executing');

  // Enumerate all BottomNavigationBarLandscapeLayout values
  print('BottomNavigationBarLandscapeLayout values:');
  for (final value in BottomNavigationBarLandscapeLayout.values) {
    print('  ${value.name}: $value');
  }
  print('BottomNavigationBarLandscapeLayout has ${ BottomNavigationBarLandscapeLayout.values.length} values');

  final first = BottomNavigationBarLandscapeLayout.values.first;
  final last = BottomNavigationBarLandscapeLayout.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('BottomNavigationBarLandscapeLayout test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BottomNavigationBarLandscapeLayout Tests'),
      Text('Values: ${ BottomNavigationBarLandscapeLayout.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
