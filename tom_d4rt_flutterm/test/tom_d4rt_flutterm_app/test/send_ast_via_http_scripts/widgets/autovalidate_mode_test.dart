// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AutovalidateMode from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AutovalidateMode test executing');

  // Enumerate all AutovalidateMode values
  print('AutovalidateMode values:');
  for (final value in AutovalidateMode.values) {
    print('  ${value.name}: $value');
  }
  print('AutovalidateMode has ${ AutovalidateMode.values.length} values');

  final first = AutovalidateMode.values.first;
  final last = AutovalidateMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('AutovalidateMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AutovalidateMode Tests'),
      Text('Values: ${ AutovalidateMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
