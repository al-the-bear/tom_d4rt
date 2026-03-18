// D4rt test script: Tests BoxFit from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxFit test executing');

  // Enumerate all BoxFit values
  print('BoxFit values:');
  for (final value in BoxFit.values) {
    print('  ${value.name}: $value');
  }
  print('BoxFit has ${ BoxFit.values.length} values');

  final first = BoxFit.values.first;
  final last = BoxFit.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('BoxFit test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxFit Tests'),
      Text('Values: ${ BoxFit.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
