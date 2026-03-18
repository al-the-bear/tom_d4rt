// D4rt test script: Tests TextSelectionHandleType from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelectionHandleType test executing');

  // Enumerate all TextSelectionHandleType values
  print('TextSelectionHandleType values:');
  for (final value in TextSelectionHandleType.values) {
    print('  ${value.name}: $value');
  }
  print('TextSelectionHandleType has ${ TextSelectionHandleType.values.length} values');

  final first = TextSelectionHandleType.values.first;
  final last = TextSelectionHandleType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextSelectionHandleType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionHandleType Tests'),
      Text('Values: ${ TextSelectionHandleType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
