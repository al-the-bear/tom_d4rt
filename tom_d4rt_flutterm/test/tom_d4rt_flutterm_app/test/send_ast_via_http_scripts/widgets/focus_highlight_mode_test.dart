// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FocusHighlightMode from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FocusHighlightMode test executing');

  // Enumerate all FocusHighlightMode values
  print('FocusHighlightMode values:');
  for (final value in FocusHighlightMode.values) {
    print('  ${value.name}: $value');
  }
  print('FocusHighlightMode has ${ FocusHighlightMode.values.length} values');

  final first = FocusHighlightMode.values.first;
  final last = FocusHighlightMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FocusHighlightMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FocusHighlightMode Tests'),
      Text('Values: ${ FocusHighlightMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
