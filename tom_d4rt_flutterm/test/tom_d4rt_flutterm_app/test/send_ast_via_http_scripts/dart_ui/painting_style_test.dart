// D4rt test script: Tests PaintingStyle from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PaintingStyle test executing');

  // Enumerate all PaintingStyle values
  print('PaintingStyle values:');
  for (final value in PaintingStyle.values) {
    print('  ${value.name}: $value');
  }
  print('PaintingStyle has ${ PaintingStyle.values.length} values');

  final first = PaintingStyle.values.first;
  final last = PaintingStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PaintingStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PaintingStyle Tests'),
      Text('Values: ${ PaintingStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
