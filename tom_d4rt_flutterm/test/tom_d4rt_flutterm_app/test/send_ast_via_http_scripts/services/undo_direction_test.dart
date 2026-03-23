// ignore_for_file: avoid_print
// D4rt test script: Tests UndoDirection from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UndoDirection test executing');

  // Enumerate all UndoDirection values
  print('UndoDirection values:');
  for (final value in UndoDirection.values) {
    print('  ${value.name}: $value');
  }
  print('UndoDirection has ${UndoDirection.values.length} values');

  final first = UndoDirection.values.first;
  final last = UndoDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('UndoDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UndoDirection Tests'),
      Text('Values: ${UndoDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
