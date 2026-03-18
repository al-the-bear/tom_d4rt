// D4rt test script: Tests TileMode from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TileMode test executing');

  // Enumerate all TileMode values
  print('TileMode values:');
  for (final value in TileMode.values) {
    print('  ${value.name}: $value');
  }
  print('TileMode has ${ TileMode.values.length} values');

  final first = TileMode.values.first;
  final last = TileMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TileMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TileMode Tests'),
      Text('Values: ${ TileMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
