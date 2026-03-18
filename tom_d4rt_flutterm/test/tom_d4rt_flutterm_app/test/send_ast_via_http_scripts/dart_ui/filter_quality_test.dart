// D4rt test script: Tests FilterQuality from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FilterQuality test executing');

  // Enumerate all FilterQuality values
  print('FilterQuality values:');
  for (final value in FilterQuality.values) {
    print('  ${value.name}: $value');
  }
  print('FilterQuality has ${ FilterQuality.values.length} values');

  final first = FilterQuality.values.first;
  final last = FilterQuality.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FilterQuality test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FilterQuality Tests'),
      Text('Values: ${ FilterQuality.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
