// ignore_for_file: avoid_print
// D4rt test script: Tests MaterialBannerClosedReason from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialBannerClosedReason test executing');

  // Enumerate all MaterialBannerClosedReason values
  print('MaterialBannerClosedReason values:');
  for (final value in MaterialBannerClosedReason.values) {
    print('  ${value.name}: $value');
  }
  print('MaterialBannerClosedReason has ${ MaterialBannerClosedReason.values.length} values');

  final first = MaterialBannerClosedReason.values.first;
  final last = MaterialBannerClosedReason.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('MaterialBannerClosedReason test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaterialBannerClosedReason Tests'),
      Text('Values: ${ MaterialBannerClosedReason.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
