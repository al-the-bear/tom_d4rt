// D4rt test script: Tests DiagnosticLevel from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DiagnosticLevel test executing');

  // Enumerate all DiagnosticLevel values
  print('DiagnosticLevel values:');
  for (final value in DiagnosticLevel.values) {
    print('  ${value.name}: $value');
  }
  print('DiagnosticLevel has ${ DiagnosticLevel.values.length} values');

  final first = DiagnosticLevel.values.first;
  final last = DiagnosticLevel.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DiagnosticLevel test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DiagnosticLevel Tests'),
      Text('Values: ${ DiagnosticLevel.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
