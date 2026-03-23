// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextGranularity from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextGranularity test executing');

  // Enumerate all TextGranularity values
  print('TextGranularity values:');
  for (final value in TextGranularity.values) {
    print('  ${value.name}: $value');
  }
  print('TextGranularity has ${ TextGranularity.values.length} values');

  final first = TextGranularity.values.first;
  final last = TextGranularity.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextGranularity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextGranularity Tests'),
      Text('Values: ${ TextGranularity.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
