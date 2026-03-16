// D4rt test script: Tests ChangeReportingBehavior from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ChangeReportingBehavior test executing');

  // Enumerate all ChangeReportingBehavior values
  print('ChangeReportingBehavior values:');
  for (final value in ChangeReportingBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('ChangeReportingBehavior has ${ ChangeReportingBehavior.values.length} values');

  final first = ChangeReportingBehavior.values.first;
  final last = ChangeReportingBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ChangeReportingBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ChangeReportingBehavior Tests'),
      Text('Values: ${ ChangeReportingBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
