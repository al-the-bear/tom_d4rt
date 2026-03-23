// ignore_for_file: avoid_print
// D4rt test script: Tests AutofillContextAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AutofillContextAction test executing');

  // Enumerate all AutofillContextAction values
  print('AutofillContextAction values:');
  for (final value in AutofillContextAction.values) {
    print('  ${value.name}: $value');
  }
  print('AutofillContextAction has ${ AutofillContextAction.values.length} values');

  final first = AutofillContextAction.values.first;
  final last = AutofillContextAction.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('AutofillContextAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AutofillContextAction Tests'),
      Text('Values: ${ AutofillContextAction.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
