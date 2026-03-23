// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextOverflow from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextOverflow test executing');

  // Enumerate all TextOverflow values
  print('TextOverflow values:');
  for (final value in TextOverflow.values) {
    print('  ${value.name}: $value');
  }
  print('TextOverflow has ${ TextOverflow.values.length} values');

  final first = TextOverflow.values.first;
  final last = TextOverflow.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextOverflow test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextOverflow Tests'),
      Text('Values: ${ TextOverflow.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
