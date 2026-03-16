// D4rt test script: Tests SelectionExtendDirection from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionExtendDirection test executing');

  // Enumerate all SelectionExtendDirection values
  print('SelectionExtendDirection values:');
  for (final value in SelectionExtendDirection.values) {
    print('  ${value.name}: $value');
  }
  print('SelectionExtendDirection has ${ SelectionExtendDirection.values.length} values');

  final first = SelectionExtendDirection.values.first;
  final last = SelectionExtendDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SelectionExtendDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionExtendDirection Tests'),
      Text('Values: ${ SelectionExtendDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
