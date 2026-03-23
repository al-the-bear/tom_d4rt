// ignore_for_file: avoid_print
// D4rt test script: Tests DeviceOrientation from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DeviceOrientation test executing');

  // Enumerate all DeviceOrientation values
  print('DeviceOrientation values:');
  for (final value in DeviceOrientation.values) {
    print('  ${value.name}: $value');
  }
  print('DeviceOrientation has ${DeviceOrientation.values.length} values');

  final first = DeviceOrientation.values.first;
  final last = DeviceOrientation.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DeviceOrientation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DeviceOrientation Tests'),
      Text('Values: ${DeviceOrientation.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
