// ignore_for_file: avoid_print
// D4rt test script: Tests WidgetInspectorServiceExtensions from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetInspectorServiceExtensions test executing');

  // Enumerate all WidgetInspectorServiceExtensions values
  print('WidgetInspectorServiceExtensions values:');
  for (final value in WidgetInspectorServiceExtensions.values) {
    print('  ${value.name}: $value');
  }
  print('WidgetInspectorServiceExtensions has ${ WidgetInspectorServiceExtensions.values.length} values');

  final first = WidgetInspectorServiceExtensions.values.first;
  final last = WidgetInspectorServiceExtensions.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('WidgetInspectorServiceExtensions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetInspectorServiceExtensions Tests'),
      Text('Values: ${ WidgetInspectorServiceExtensions.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
