// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OptionsViewOpenDirection from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OptionsViewOpenDirection test executing');

  // Enumerate all OptionsViewOpenDirection values
  print('OptionsViewOpenDirection values:');
  for (final value in OptionsViewOpenDirection.values) {
    print('  ${value.name}: $value');
  }
  print('OptionsViewOpenDirection has ${ OptionsViewOpenDirection.values.length} values');

  final first = OptionsViewOpenDirection.values.first;
  final last = OptionsViewOpenDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('OptionsViewOpenDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OptionsViewOpenDirection Tests'),
      Text('Values: ${ OptionsViewOpenDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
