// ignore_for_file: avoid_print
// D4rt test script: Tests OverflowBarAlignment from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverflowBarAlignment test executing');

  // Enumerate all OverflowBarAlignment values
  print('OverflowBarAlignment values:');
  for (final value in OverflowBarAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('OverflowBarAlignment has ${ OverflowBarAlignment.values.length} values');

  final first = OverflowBarAlignment.values.first;
  final last = OverflowBarAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('OverflowBarAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverflowBarAlignment Tests'),
      Text('Values: ${ OverflowBarAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
