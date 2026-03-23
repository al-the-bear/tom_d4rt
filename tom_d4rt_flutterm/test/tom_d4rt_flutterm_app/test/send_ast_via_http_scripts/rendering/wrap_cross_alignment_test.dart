// ignore_for_file: avoid_print
// D4rt test script: Tests WrapCrossAlignment from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WrapCrossAlignment test executing');

  // Enumerate all WrapCrossAlignment values
  print('WrapCrossAlignment values:');
  for (final value in WrapCrossAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('WrapCrossAlignment has ${ WrapCrossAlignment.values.length} values');

  final first = WrapCrossAlignment.values.first;
  final last = WrapCrossAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('WrapCrossAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WrapCrossAlignment Tests'),
      Text('Values: ${ WrapCrossAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
