// D4rt test script: Tests KeyboardSide from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyboardSide test executing');

  // Enumerate all KeyboardSide values
  print('KeyboardSide values:');
  for (final value in KeyboardSide.values) {
    print('  ${value.name}: $value');
  }
  print('KeyboardSide has ${KeyboardSide.values.length} values');

  final first = KeyboardSide.values.first;
  final last = KeyboardSide.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('KeyboardSide test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyboardSide Tests'),
      Text('Values: ${KeyboardSide.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
