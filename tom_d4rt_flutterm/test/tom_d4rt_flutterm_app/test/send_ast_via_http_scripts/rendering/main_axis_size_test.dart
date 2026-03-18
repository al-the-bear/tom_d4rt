// D4rt test script: Tests MainAxisSize from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MainAxisSize test executing');

  // Enumerate all MainAxisSize values
  print('MainAxisSize values:');
  for (final value in MainAxisSize.values) {
    print('  ${value.name}: $value');
  }
  print('MainAxisSize has ${ MainAxisSize.values.length} values');

  final first = MainAxisSize.values.first;
  final last = MainAxisSize.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('MainAxisSize test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MainAxisSize Tests'),
      Text('Values: ${ MainAxisSize.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
