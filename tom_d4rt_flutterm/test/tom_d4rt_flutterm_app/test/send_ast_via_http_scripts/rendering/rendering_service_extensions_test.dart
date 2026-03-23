// ignore_for_file: avoid_print
// D4rt test script: Tests RenderingServiceExtensions from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderingServiceExtensions test executing');

  // Enumerate all RenderingServiceExtensions values
  print('RenderingServiceExtensions values:');
  for (final value in RenderingServiceExtensions.values) {
    print('  ${value.name}: $value');
  }
  print('RenderingServiceExtensions has ${ RenderingServiceExtensions.values.length} values');

  final first = RenderingServiceExtensions.values.first;
  final last = RenderingServiceExtensions.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('RenderingServiceExtensions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderingServiceExtensions Tests'),
      Text('Values: ${ RenderingServiceExtensions.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
