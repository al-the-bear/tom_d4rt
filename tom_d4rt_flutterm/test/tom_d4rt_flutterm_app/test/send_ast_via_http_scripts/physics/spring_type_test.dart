// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SpringType from physics
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SpringType test executing');

  // Enumerate all SpringType values
  print('SpringType values:');
  for (final value in SpringType.values) {
    print('  ${value.name}: $value');
  }
  print('SpringType has ${SpringType.values.length} values');

  final first = SpringType.values.first;
  final last = SpringType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SpringType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SpringType Tests'),
      Text('Values: ${SpringType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
