// ignore_for_file: avoid_print
// D4rt test script: Tests ContentSensitivity from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ContentSensitivity test executing');

  // Enumerate all ContentSensitivity values
  print('ContentSensitivity values:');
  for (final value in ContentSensitivity.values) {
    print('  ${value.name}: $value');
  }
  print('ContentSensitivity has ${ContentSensitivity.values.length} values');

  final first = ContentSensitivity.values.first;
  final last = ContentSensitivity.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ContentSensitivity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ContentSensitivity Tests'),
      Text('Values: ${ContentSensitivity.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
