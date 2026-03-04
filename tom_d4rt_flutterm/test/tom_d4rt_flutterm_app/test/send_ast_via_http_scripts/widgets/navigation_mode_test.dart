// D4rt test script: Tests NavigationMode from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NavigationMode test executing');

  // Enumerate all NavigationMode values
  print('NavigationMode values:');
  for (final value in NavigationMode.values) {
    print('  ${value.name}: $value');
  }
  print('NavigationMode has ${ NavigationMode.values.length} values');

  final first = NavigationMode.values.first;
  final last = NavigationMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('NavigationMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationMode Tests'),
      Text('Values: ${ NavigationMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
