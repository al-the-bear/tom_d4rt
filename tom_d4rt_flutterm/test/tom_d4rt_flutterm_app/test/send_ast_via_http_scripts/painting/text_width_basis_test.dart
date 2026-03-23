// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextWidthBasis from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextWidthBasis test executing');

  // Enumerate all TextWidthBasis values
  print('TextWidthBasis values:');
  for (final value in TextWidthBasis.values) {
    print('  ${value.name}: $value');
  }
  print('TextWidthBasis has ${ TextWidthBasis.values.length} values');

  final first = TextWidthBasis.values.first;
  final last = TextWidthBasis.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextWidthBasis test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextWidthBasis Tests'),
      Text('Values: ${ TextWidthBasis.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
