// D4rt test script: Tests CacheExtentStyle from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CacheExtentStyle test executing');

  // Enumerate all CacheExtentStyle values
  print('CacheExtentStyle values:');
  for (final value in CacheExtentStyle.values) {
    print('  ${value.name}: $value');
  }
  print('CacheExtentStyle has ${ CacheExtentStyle.values.length} values');

  final first = CacheExtentStyle.values.first;
  final last = CacheExtentStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('CacheExtentStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CacheExtentStyle Tests'),
      Text('Values: ${ CacheExtentStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
