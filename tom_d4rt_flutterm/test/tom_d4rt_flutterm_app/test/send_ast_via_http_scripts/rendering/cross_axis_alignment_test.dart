// D4rt test script: Tests CrossAxisAlignment from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CrossAxisAlignment test executing');

  // Enumerate all CrossAxisAlignment values
  print('CrossAxisAlignment values:');
  for (final value in CrossAxisAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('CrossAxisAlignment has ${ CrossAxisAlignment.values.length} values');

  final first = CrossAxisAlignment.values.first;
  final last = CrossAxisAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('CrossAxisAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CrossAxisAlignment Tests'),
      Text('Values: ${ CrossAxisAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
