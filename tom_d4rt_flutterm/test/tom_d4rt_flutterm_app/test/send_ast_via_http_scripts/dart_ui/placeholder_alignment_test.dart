// D4rt test script: Tests PlaceholderAlignment from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlaceholderAlignment test executing');

  // Enumerate all PlaceholderAlignment values
  print('PlaceholderAlignment values:');
  for (final value in PlaceholderAlignment.values) {
    print('  ${value.name}: $value');
  }
  print('PlaceholderAlignment has ${ PlaceholderAlignment.values.length} values');

  final first = PlaceholderAlignment.values.first;
  final last = PlaceholderAlignment.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PlaceholderAlignment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlaceholderAlignment Tests'),
      Text('Values: ${ PlaceholderAlignment.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
