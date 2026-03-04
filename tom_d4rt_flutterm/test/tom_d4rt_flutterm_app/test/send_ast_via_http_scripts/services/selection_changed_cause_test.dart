// D4rt test script: Tests SelectionChangedCause from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionChangedCause test executing');

  // Enumerate all SelectionChangedCause values
  print('SelectionChangedCause values:');
  for (final value in SelectionChangedCause.values) {
    print('  ${value.name}: $value');
  }
  print('SelectionChangedCause has ${ SelectionChangedCause.values.length} values');

  final first = SelectionChangedCause.values.first;
  final last = SelectionChangedCause.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SelectionChangedCause test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionChangedCause Tests'),
      Text('Values: ${ SelectionChangedCause.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
