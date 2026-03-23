// ignore_for_file: avoid_print
// D4rt test script: Tests StackFit from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StackFit test executing');

  // Enumerate all StackFit values
  print('StackFit values:');
  for (final value in StackFit.values) {
    print('  ${value.name}: $value');
  }
  print('StackFit has ${ StackFit.values.length} values');

  final first = StackFit.values.first;
  final last = StackFit.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('StackFit test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StackFit Tests'),
      Text('Values: ${ StackFit.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
