// D4rt test script: Tests PointerDeviceKind from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PointerDeviceKind test executing');

  // Enumerate all PointerDeviceKind values
  print('PointerDeviceKind values:');
  for (final value in PointerDeviceKind.values) {
    print('  ${value.name}: $value');
  }
  print('PointerDeviceKind has ${ PointerDeviceKind.values.length} values');

  final first = PointerDeviceKind.values.first;
  final last = PointerDeviceKind.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PointerDeviceKind test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerDeviceKind Tests'),
      Text('Values: ${ PointerDeviceKind.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
