// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextInputAction from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextInputAction test executing');

  // Enumerate all TextInputAction values
  print('TextInputAction values:');
  for (final value in TextInputAction.values) {
    print('  ${value.name}: $value');
  }
  print('TextInputAction has ${TextInputAction.values.length} values');

  final first = TextInputAction.values.first;
  final last = TextInputAction.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextInputAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextInputAction Tests'),
      Text('Values: ${TextInputAction.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
