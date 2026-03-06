// D4rt test script: Tests PerformanceOverlayOption from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PerformanceOverlayOption test executing');

  // Enumerate all PerformanceOverlayOption values
  print('PerformanceOverlayOption values:');
  for (final value in PerformanceOverlayOption.values) {
    print('  ${value.name}: $value');
  }
  print('PerformanceOverlayOption has ${ PerformanceOverlayOption.values.length} values');

  final first = PerformanceOverlayOption.values.first;
  final last = PerformanceOverlayOption.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PerformanceOverlayOption test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PerformanceOverlayOption Tests'),
      Text('Values: ${ PerformanceOverlayOption.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
