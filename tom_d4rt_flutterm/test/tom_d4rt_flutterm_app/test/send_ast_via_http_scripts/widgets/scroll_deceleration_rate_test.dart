// D4rt test script: Tests ScrollDecelerationRate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollDecelerationRate test executing');

  // Enumerate all ScrollDecelerationRate values
  print('ScrollDecelerationRate values:');
  for (final value in ScrollDecelerationRate.values) {
    print('  ${value.name}: $value');
  }
  print('ScrollDecelerationRate has ${ ScrollDecelerationRate.values.length} values');

  final first = ScrollDecelerationRate.values.first;
  final last = ScrollDecelerationRate.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ScrollDecelerationRate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollDecelerationRate Tests'),
      Text('Values: ${ ScrollDecelerationRate.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
