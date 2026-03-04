// D4rt test script: Tests FloatingHeaderSnapMode from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FloatingHeaderSnapMode test executing');

  // Enumerate all FloatingHeaderSnapMode values
  print('FloatingHeaderSnapMode values:');
  for (final value in FloatingHeaderSnapMode.values) {
    print('  ${value.name}: $value');
  }
  print('FloatingHeaderSnapMode has ${ FloatingHeaderSnapMode.values.length} values');

  final first = FloatingHeaderSnapMode.values.first;
  final last = FloatingHeaderSnapMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FloatingHeaderSnapMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FloatingHeaderSnapMode Tests'),
      Text('Values: ${ FloatingHeaderSnapMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
