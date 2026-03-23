// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests UnfocusDisposition from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UnfocusDisposition test executing');

  // Enumerate all UnfocusDisposition values
  print('UnfocusDisposition values:');
  for (final value in UnfocusDisposition.values) {
    print('  ${value.name}: $value');
  }
  print('UnfocusDisposition has ${ UnfocusDisposition.values.length} values');

  final first = UnfocusDisposition.values.first;
  final last = UnfocusDisposition.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('UnfocusDisposition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UnfocusDisposition Tests'),
      Text('Values: ${ UnfocusDisposition.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
