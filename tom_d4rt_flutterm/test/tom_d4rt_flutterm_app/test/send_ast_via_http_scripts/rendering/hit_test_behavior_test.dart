// D4rt test script: Tests HitTestBehavior from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('HitTestBehavior test executing');

  // Enumerate all HitTestBehavior values
  print('HitTestBehavior values:');
  for (final value in HitTestBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('HitTestBehavior has ${ HitTestBehavior.values.length} values');

  final first = HitTestBehavior.values.first;
  final last = HitTestBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('HitTestBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HitTestBehavior Tests'),
      Text('Values: ${ HitTestBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
