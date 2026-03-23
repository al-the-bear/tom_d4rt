// ignore_for_file: avoid_print
// D4rt test script: Tests DebugSemanticsDumpOrder from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DebugSemanticsDumpOrder test executing');

  // Enumerate all DebugSemanticsDumpOrder values
  print('DebugSemanticsDumpOrder values:');
  for (final value in DebugSemanticsDumpOrder.values) {
    print('  ${value.name}: $value');
  }
  print(
    'DebugSemanticsDumpOrder has ${DebugSemanticsDumpOrder.values.length} values',
  );

  final first = DebugSemanticsDumpOrder.values.first;
  final last = DebugSemanticsDumpOrder.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DebugSemanticsDumpOrder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DebugSemanticsDumpOrder Tests'),
      Text('Values: ${DebugSemanticsDumpOrder.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
