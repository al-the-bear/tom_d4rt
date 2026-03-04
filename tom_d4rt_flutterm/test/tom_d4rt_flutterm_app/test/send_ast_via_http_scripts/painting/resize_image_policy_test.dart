// D4rt test script: Tests ResizeImagePolicy from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ResizeImagePolicy test executing');

  // Enumerate all ResizeImagePolicy values
  print('ResizeImagePolicy values:');
  for (final value in ResizeImagePolicy.values) {
    print('  ${value.name}: $value');
  }
  print('ResizeImagePolicy has ${ ResizeImagePolicy.values.length} values');

  final first = ResizeImagePolicy.values.first;
  final last = ResizeImagePolicy.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ResizeImagePolicy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ResizeImagePolicy Tests'),
      Text('Values: ${ ResizeImagePolicy.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
