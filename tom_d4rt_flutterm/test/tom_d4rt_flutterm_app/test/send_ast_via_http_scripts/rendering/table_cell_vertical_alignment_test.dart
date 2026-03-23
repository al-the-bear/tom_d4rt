// ignore_for_file: avoid_print
// D4rt test script: Tests TableCellVerticalAlignment from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TableCellVerticalAlignment test executing');

  // Enumerate all TableCellVerticalAlignment values
  print('TableCellVerticalAlignment values:');
  for (final value in TableCellVerticalAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('TableCellVerticalAlignment has ${ TableCellVerticalAlignment.values.length} values');

  final first = TableCellVerticalAlignment.values.first;
  final last = TableCellVerticalAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TableCellVerticalAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TableCellVerticalAlignment Tests'),
      Text('Values: ${ TableCellVerticalAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
