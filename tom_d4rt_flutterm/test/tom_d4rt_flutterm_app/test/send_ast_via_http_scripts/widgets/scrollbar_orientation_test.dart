// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScrollbarOrientation from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollbarOrientation test executing');

  // Enumerate all ScrollbarOrientation values
  print('ScrollbarOrientation values:');
  for (final value in ScrollbarOrientation.values) {
    print('  ${value.name}: $value');
  }
  print('ScrollbarOrientation has ${ ScrollbarOrientation.values.length} values');

  final first = ScrollbarOrientation.values.first;
  final last = ScrollbarOrientation.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ScrollbarOrientation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollbarOrientation Tests'),
      Text('Values: ${ ScrollbarOrientation.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
