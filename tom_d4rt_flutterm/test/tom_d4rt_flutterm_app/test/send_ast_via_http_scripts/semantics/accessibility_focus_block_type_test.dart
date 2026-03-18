// D4rt test script: Tests AccessibilityFocusBlockType from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AccessibilityFocusBlockType test executing');

  // Enumerate all AccessibilityFocusBlockType values
  print('AccessibilityFocusBlockType values:');
  for (final value in AccessibilityFocusBlockType.values) {
    print('  ${value.name}: $value');
  }
  print(
    'AccessibilityFocusBlockType has ${AccessibilityFocusBlockType.values.length} values',
  );

  final first = AccessibilityFocusBlockType.values.first;
  final last = AccessibilityFocusBlockType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('AccessibilityFocusBlockType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AccessibilityFocusBlockType Tests'),
      Text('Values: ${AccessibilityFocusBlockType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
