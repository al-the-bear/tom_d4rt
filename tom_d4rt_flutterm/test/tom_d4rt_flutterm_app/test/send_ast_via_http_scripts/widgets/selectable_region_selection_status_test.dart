// D4rt test script: Tests SelectableRegionSelectionStatus from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectableRegionSelectionStatus test executing');

  // Enumerate all SelectableRegionSelectionStatus values
  print('SelectableRegionSelectionStatus values:');
  for (final value in SelectableRegionSelectionStatus.values) {
    print('  ${value.name}: $value');
  }
  print('SelectableRegionSelectionStatus has ${ SelectableRegionSelectionStatus.values.length} values');

  final first = SelectableRegionSelectionStatus.values.first;
  final last = SelectableRegionSelectionStatus.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SelectableRegionSelectionStatus test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectableRegionSelectionStatus Tests'),
      Text('Values: ${ SelectableRegionSelectionStatus.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
