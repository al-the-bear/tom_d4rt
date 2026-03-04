// D4rt test script: Tests OverlayVisibilityMode from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('OverlayVisibilityMode test executing');

  // Enumerate all OverlayVisibilityMode values
  print('OverlayVisibilityMode values:');
  for (final value in OverlayVisibilityMode.values) {
    print('  ${value.name}: $value');
  }
  print('OverlayVisibilityMode has ${ OverlayVisibilityMode.values.length} values');

  final first = OverlayVisibilityMode.values.first;
  final last = OverlayVisibilityMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('OverlayVisibilityMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverlayVisibilityMode Tests'),
      Text('Values: ${ OverlayVisibilityMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
