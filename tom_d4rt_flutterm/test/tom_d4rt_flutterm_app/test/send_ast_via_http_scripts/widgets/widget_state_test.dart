// ignore_for_file: avoid_print
// D4rt test script: Tests WidgetState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetState test executing');

  // Enumerate all WidgetState values
  print('WidgetState values:');
  for (final value in WidgetState.values) {
    print('  ${value.name}: $value');
  }
  print('WidgetState has ${ WidgetState.values.length} values');

  final first = WidgetState.values.first;
  final last = WidgetState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('WidgetState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetState Tests'),
      Text('Values: ${ WidgetState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
