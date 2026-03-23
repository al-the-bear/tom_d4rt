// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FlutterLogoStyle from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlutterLogoStyle test executing');

  // Enumerate all FlutterLogoStyle values
  print('FlutterLogoStyle values:');
  for (final value in FlutterLogoStyle.values) {
    print('  ${value.name}: $value');
  }
  print('FlutterLogoStyle has ${ FlutterLogoStyle.values.length} values');

  final first = FlutterLogoStyle.values.first;
  final last = FlutterLogoStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FlutterLogoStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlutterLogoStyle Tests'),
      Text('Values: ${ FlutterLogoStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
