// D4rt test script: Tests PanAxis from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PanAxis test executing');

  // Enumerate all PanAxis values
  print('PanAxis values:');
  for (final value in PanAxis.values) {
    print('  ${value.name}: $value');
  }
  print('PanAxis has ${ PanAxis.values.length} values');

  final first = PanAxis.values.first;
  final last = PanAxis.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PanAxis test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PanAxis Tests'),
      Text('Values: ${ PanAxis.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
