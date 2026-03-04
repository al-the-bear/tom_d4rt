// D4rt test script: Tests AppLifecycleState from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AppLifecycleState test executing');

  // Enumerate all AppLifecycleState values
  print('AppLifecycleState values:');
  for (final value in AppLifecycleState.values) {
    print('  ${value.name}: $value');
  }
  print('AppLifecycleState has ${ AppLifecycleState.values.length} values');

  final first = AppLifecycleState.values.first;
  final last = AppLifecycleState.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('AppLifecycleState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AppLifecycleState Tests'),
      Text('Values: ${ AppLifecycleState.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
