// D4rt test script: Tests PointerSignalKind from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PointerSignalKind test executing');

  // Enumerate all PointerSignalKind values
  print('PointerSignalKind values:');
  for (final value in PointerSignalKind.values) {
    print('  ${value.name}: $value');
  }
  print('PointerSignalKind has ${ PointerSignalKind.values.length} values');

  final first = PointerSignalKind.values.first;
  final last = PointerSignalKind.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PointerSignalKind test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PointerSignalKind Tests'),
      Text('Values: ${ PointerSignalKind.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
