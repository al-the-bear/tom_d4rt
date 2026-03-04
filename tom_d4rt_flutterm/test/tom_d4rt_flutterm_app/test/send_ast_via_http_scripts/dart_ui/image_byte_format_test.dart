// D4rt test script: Tests ImageByteFormat from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageByteFormat test executing');

  // Enumerate all ImageByteFormat values
  print('ImageByteFormat values:');
  for (final value in ImageByteFormat.values) {
    print('  ${value.name}: $value');
  }
  print('ImageByteFormat has ${ ImageByteFormat.values.length} values');

  final first = ImageByteFormat.values.first;
  final last = ImageByteFormat.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ImageByteFormat test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageByteFormat Tests'),
      Text('Values: ${ ImageByteFormat.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
