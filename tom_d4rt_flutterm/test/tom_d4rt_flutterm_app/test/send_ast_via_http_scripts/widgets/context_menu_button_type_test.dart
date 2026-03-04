// D4rt test script: Tests ContextMenuButtonType from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ContextMenuButtonType test executing');

  // Enumerate all ContextMenuButtonType values
  print('ContextMenuButtonType values:');
  for (final value in ContextMenuButtonType.values) {
    print('  ${value.name}: $value');
  }
  print('ContextMenuButtonType has ${ ContextMenuButtonType.values.length} values');

  final first = ContextMenuButtonType.values.first;
  final last = ContextMenuButtonType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ContextMenuButtonType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ContextMenuButtonType Tests'),
      Text('Values: ${ ContextMenuButtonType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
