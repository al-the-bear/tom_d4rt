// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LiveTextInputStatus from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LiveTextInputStatus test executing');

  // Enumerate all LiveTextInputStatus values
  print('LiveTextInputStatus values:');
  for (final value in LiveTextInputStatus.values) {
    print('  ${value.name}: $value');
  }
  print('LiveTextInputStatus has ${ LiveTextInputStatus.values.length} values');

  final first = LiveTextInputStatus.values.first;
  final last = LiveTextInputStatus.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('LiveTextInputStatus test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LiveTextInputStatus Tests'),
      Text('Values: ${ LiveTextInputStatus.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
