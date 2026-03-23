// ignore_for_file: avoid_print
// D4rt test script: Tests CrossFadeState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CrossFadeState test executing');

  // Enumerate all CrossFadeState values
  print('CrossFadeState values:');
  for (final value in CrossFadeState.values) {
    print('  ${value.name}: $value');
  }
  print('CrossFadeState has ${ CrossFadeState.values.length} values');

  final first = CrossFadeState.values.first;
  final last = CrossFadeState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('CrossFadeState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CrossFadeState Tests'),
      Text('Values: ${ CrossFadeState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
