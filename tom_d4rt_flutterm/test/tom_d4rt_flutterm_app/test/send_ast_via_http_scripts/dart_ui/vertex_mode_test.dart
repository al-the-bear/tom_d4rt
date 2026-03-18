// D4rt test script: Tests VertexMode from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('VertexMode test executing');

  // Enumerate all VertexMode values
  print('VertexMode values:');
  for (final value in VertexMode.values) {
    print('  ${value.name}: $value');
  }
  print('VertexMode has ${ VertexMode.values.length} values');

  final first = VertexMode.values.first;
  final last = VertexMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('VertexMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VertexMode Tests'),
      Text('Values: ${ VertexMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
