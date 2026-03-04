// D4rt test script: Tests ClipboardStatus from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClipboardStatus test executing');

  // Enumerate all ClipboardStatus values
  print('ClipboardStatus values:');
  for (final value in ClipboardStatus.values) {
    print('  ${value.name}: $value');
  }
  print('ClipboardStatus has ${ ClipboardStatus.values.length} values');

  final first = ClipboardStatus.values.first;
  final last = ClipboardStatus.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ClipboardStatus test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClipboardStatus Tests'),
      Text('Values: ${ ClipboardStatus.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
