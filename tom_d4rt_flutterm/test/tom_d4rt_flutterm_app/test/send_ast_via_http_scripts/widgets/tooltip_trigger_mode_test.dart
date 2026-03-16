// D4rt test script: Tests TooltipTriggerMode from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TooltipTriggerMode test executing');

  // Enumerate all TooltipTriggerMode values
  print('TooltipTriggerMode values:');
  for (final value in TooltipTriggerMode.values) {
    print('  ${value.name}: $value');
  }
  print('TooltipTriggerMode has ${ TooltipTriggerMode.values.length} values');

  // Test first and last
  final first = TooltipTriggerMode.values.first;
  final last = TooltipTriggerMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TooltipTriggerMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TooltipTriggerMode Tests'),
      Text('Values: ${ TooltipTriggerMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
