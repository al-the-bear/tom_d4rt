// ignore_for_file: avoid_print
// D4rt test script: Tests Assertiveness from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Assertiveness test executing');

  // Enumerate all Assertiveness values
  print('Assertiveness values:');
  for (final value in Assertiveness.values) {
    print('  ${value.name}: $value');
  }
  print('Assertiveness has ${Assertiveness.values.length} values');

  final first = Assertiveness.values.first;
  final last = Assertiveness.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('Assertiveness test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Assertiveness Tests'),
      Text('Values: ${Assertiveness.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
