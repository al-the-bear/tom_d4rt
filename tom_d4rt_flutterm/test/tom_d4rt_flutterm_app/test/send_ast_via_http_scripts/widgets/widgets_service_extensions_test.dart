// D4rt test script: Tests WidgetsServiceExtensions from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetsServiceExtensions test executing');

  // Enumerate all WidgetsServiceExtensions values
  print('WidgetsServiceExtensions values:');
  for (final value in WidgetsServiceExtensions.values) {
    print('  ${value.name}: $value');
  }
  print('WidgetsServiceExtensions has ${ WidgetsServiceExtensions.values.length} values');

  final first = WidgetsServiceExtensions.values.first;
  final last = WidgetsServiceExtensions.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('WidgetsServiceExtensions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetsServiceExtensions Tests'),
      Text('Values: ${ WidgetsServiceExtensions.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
