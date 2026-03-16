// D4rt test script: Tests NavigationBarBottomMode from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('NavigationBarBottomMode test executing');

  // Enumerate all NavigationBarBottomMode values
  print('NavigationBarBottomMode values:');
  for (final value in NavigationBarBottomMode.values) {
    print('  ${value.name}: $value');
  }
  print('NavigationBarBottomMode has ${ NavigationBarBottomMode.values.length} values');

  final first = NavigationBarBottomMode.values.first;
  final last = NavigationBarBottomMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('NavigationBarBottomMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationBarBottomMode Tests'),
      Text('Values: ${ NavigationBarBottomMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
