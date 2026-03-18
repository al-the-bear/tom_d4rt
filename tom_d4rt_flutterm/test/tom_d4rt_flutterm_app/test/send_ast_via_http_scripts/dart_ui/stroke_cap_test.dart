// D4rt test script: Tests StrokeCap from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StrokeCap test executing');

  // Enumerate all StrokeCap values
  print('StrokeCap values:');
  for (final value in StrokeCap.values) {
    print('  ${value.name}: $value');
  }
  print('StrokeCap has ${ StrokeCap.values.length} values');

  final first = StrokeCap.values.first;
  final last = StrokeCap.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('StrokeCap test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StrokeCap Tests'),
      Text('Values: ${ StrokeCap.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
