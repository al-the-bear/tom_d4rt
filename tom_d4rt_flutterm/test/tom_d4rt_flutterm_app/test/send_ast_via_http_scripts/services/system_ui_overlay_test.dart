// ignore_for_file: avoid_print
// D4rt test script: Tests SystemUiOverlay from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SystemUiOverlay test executing');

  // Enumerate all SystemUiOverlay values
  print('SystemUiOverlay values:');
  for (final value in SystemUiOverlay.values) {
    print('  ${value.name}: $value');
  }
  print('SystemUiOverlay has ${SystemUiOverlay.values.length} values');

  final first = SystemUiOverlay.values.first;
  final last = SystemUiOverlay.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SystemUiOverlay test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SystemUiOverlay Tests'),
      Text('Values: ${SystemUiOverlay.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
