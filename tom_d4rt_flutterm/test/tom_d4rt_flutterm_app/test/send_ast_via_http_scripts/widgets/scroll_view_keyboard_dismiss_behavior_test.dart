// ignore_for_file: avoid_print
// D4rt test script: Tests ScrollViewKeyboardDismissBehavior from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollViewKeyboardDismissBehavior test executing');

  // Enumerate all ScrollViewKeyboardDismissBehavior values
  print('ScrollViewKeyboardDismissBehavior values:');
  for (final value in ScrollViewKeyboardDismissBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('ScrollViewKeyboardDismissBehavior has ${ ScrollViewKeyboardDismissBehavior.values.length} values');

  final first = ScrollViewKeyboardDismissBehavior.values.first;
  final last = ScrollViewKeyboardDismissBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ScrollViewKeyboardDismissBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollViewKeyboardDismissBehavior Tests'),
      Text('Values: ${ ScrollViewKeyboardDismissBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
