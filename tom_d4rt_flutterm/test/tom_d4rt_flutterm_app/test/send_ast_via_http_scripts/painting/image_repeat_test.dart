// D4rt test script: Tests ImageRepeat from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageRepeat test executing');

  // Enumerate all ImageRepeat values
  print('ImageRepeat values:');
  for (final value in ImageRepeat.values) {
    print('  ${value.name}: $value');
  }
  print('ImageRepeat has ${ ImageRepeat.values.length} values');

  final first = ImageRepeat.values.first;
  final last = ImageRepeat.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ImageRepeat test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageRepeat Tests'),
      Text('Values: ${ ImageRepeat.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
