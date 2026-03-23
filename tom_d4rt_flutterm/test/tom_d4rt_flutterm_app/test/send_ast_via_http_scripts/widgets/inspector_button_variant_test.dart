// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InspectorButtonVariant from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InspectorButtonVariant test executing');

  // Enumerate all InspectorButtonVariant values
  print('InspectorButtonVariant values:');
  for (final value in InspectorButtonVariant.values) {
    print('  ${value.name}: $value');
  }
  print('InspectorButtonVariant has ${ InspectorButtonVariant.values.length} values');

  final first = InspectorButtonVariant.values.first;
  final last = InspectorButtonVariant.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('InspectorButtonVariant test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InspectorButtonVariant Tests'),
      Text('Values: ${ InspectorButtonVariant.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
