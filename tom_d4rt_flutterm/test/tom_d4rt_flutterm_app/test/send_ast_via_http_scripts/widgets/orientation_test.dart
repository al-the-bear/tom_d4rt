// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Orientation from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Orientation test executing');

  // Enumerate all Orientation values
  print('Orientation values:');
  for (final value in Orientation.values) {
    print('  ${value.name}: $value');
  }
  print('Orientation has ${ Orientation.values.length} values');

  final first = Orientation.values.first;
  final last = Orientation.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('Orientation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Orientation Tests'),
      Text('Values: ${ Orientation.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
