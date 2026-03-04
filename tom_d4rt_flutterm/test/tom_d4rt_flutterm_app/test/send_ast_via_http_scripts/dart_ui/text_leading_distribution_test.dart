// D4rt test script: Tests TextLeadingDistribution from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextLeadingDistribution test executing');

  // Enumerate all TextLeadingDistribution values
  print('TextLeadingDistribution values:');
  for (final value in TextLeadingDistribution.values) {
    print('  ${value.name}: $value');
  }
  print('TextLeadingDistribution has ${ TextLeadingDistribution.values.length} values');

  final first = TextLeadingDistribution.values.first;
  final last = TextLeadingDistribution.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextLeadingDistribution test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextLeadingDistribution Tests'),
      Text('Values: ${ TextLeadingDistribution.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
