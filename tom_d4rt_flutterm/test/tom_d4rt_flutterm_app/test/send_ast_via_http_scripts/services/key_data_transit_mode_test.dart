// D4rt test script: Tests KeyDataTransitMode from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyDataTransitMode test executing');

  // Enumerate all KeyDataTransitMode values
  print('KeyDataTransitMode values:');
  for (final value in KeyDataTransitMode.values) {
    print('  ${value.name}: $value');
  }
  print('KeyDataTransitMode has ${ KeyDataTransitMode.values.length} values');

  final first = KeyDataTransitMode.values.first;
  final last = KeyDataTransitMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('KeyDataTransitMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyDataTransitMode Tests'),
      Text('Values: ${ KeyDataTransitMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
