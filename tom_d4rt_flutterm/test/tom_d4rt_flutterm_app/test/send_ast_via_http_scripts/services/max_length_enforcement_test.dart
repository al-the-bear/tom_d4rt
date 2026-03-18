// D4rt test script: Tests MaxLengthEnforcement from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MaxLengthEnforcement test executing');

  // Enumerate all MaxLengthEnforcement values
  print('MaxLengthEnforcement values:');
  for (final value in MaxLengthEnforcement.values) {
    print('  ${value.name}: $value');
  }
  print(
    'MaxLengthEnforcement has ${MaxLengthEnforcement.values.length} values',
  );

  final first = MaxLengthEnforcement.values.first;
  final last = MaxLengthEnforcement.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('MaxLengthEnforcement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MaxLengthEnforcement Tests'),
      Text('Values: ${MaxLengthEnforcement.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
