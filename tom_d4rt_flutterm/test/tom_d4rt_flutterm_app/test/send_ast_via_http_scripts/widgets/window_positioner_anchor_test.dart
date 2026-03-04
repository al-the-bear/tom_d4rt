// D4rt test script: Tests WindowPositionerAnchor from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WindowPositionerAnchor test executing');

  // Enumerate all WindowPositionerAnchor values
  print('WindowPositionerAnchor values:');
  for (final value in WindowPositionerAnchor.values) {
    print('  ${value.name}: $value');
  }
  print('WindowPositionerAnchor has ${ WindowPositionerAnchor.values.length} values');

  final first = WindowPositionerAnchor.values.first;
  final last = WindowPositionerAnchor.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('WindowPositionerAnchor test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WindowPositionerAnchor Tests'),
      Text('Values: ${ WindowPositionerAnchor.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
