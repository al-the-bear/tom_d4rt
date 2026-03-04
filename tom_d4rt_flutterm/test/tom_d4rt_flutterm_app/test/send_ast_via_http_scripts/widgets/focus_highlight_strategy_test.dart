// D4rt test script: Tests FocusHighlightStrategy from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FocusHighlightStrategy test executing');

  // Enumerate all FocusHighlightStrategy values
  print('FocusHighlightStrategy values:');
  for (final value in FocusHighlightStrategy.values) {
    print('  ${value.name}: $value');
  }
  print('FocusHighlightStrategy has ${ FocusHighlightStrategy.values.length} values');

  final first = FocusHighlightStrategy.values.first;
  final last = FocusHighlightStrategy.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FocusHighlightStrategy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FocusHighlightStrategy Tests'),
      Text('Values: ${ FocusHighlightStrategy.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
