// D4rt test script: Tests KeyEventDeviceType from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyEventDeviceType test executing');

  // Enumerate all KeyEventDeviceType values
  print('KeyEventDeviceType values:');
  for (final value in KeyEventDeviceType.values) {
    print('  ${value.name}: $value');
  }
  print('KeyEventDeviceType has ${ KeyEventDeviceType.values.length} values');

  final first = KeyEventDeviceType.values.first;
  final last = KeyEventDeviceType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('KeyEventDeviceType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyEventDeviceType Tests'),
      Text('Values: ${ KeyEventDeviceType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
