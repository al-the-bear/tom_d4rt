// D4rt test script: Tests WrapAlignment from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WrapAlignment test executing');

  // Enumerate all WrapAlignment values
  print('WrapAlignment values:');
  for (final value in WrapAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('WrapAlignment has ${ WrapAlignment.values.length} values');

  final first = WrapAlignment.values.first;
  final last = WrapAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('WrapAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WrapAlignment Tests'),
      Text('Values: ${ WrapAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
