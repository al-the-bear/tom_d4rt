// ignore_for_file: avoid_print
// D4rt test script: Tests SystemSoundType from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SystemSoundType test executing');

  // Enumerate all SystemSoundType values
  print('SystemSoundType values:');
  for (final value in SystemSoundType.values) {
    print('  ${value.name}: $value');
  }
  print('SystemSoundType has ${SystemSoundType.values.length} values');

  final first = SystemSoundType.values.first;
  final last = SystemSoundType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SystemSoundType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SystemSoundType Tests'),
      Text('Values: ${SystemSoundType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
