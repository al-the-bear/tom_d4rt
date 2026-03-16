// D4rt test script: Tests SystemUiMode from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SystemUiMode test executing');

  // Enumerate all SystemUiMode values
  print('SystemUiMode values:');
  for (final value in SystemUiMode.values) {
    print('  ${value.name}: $value');
  }
  print('SystemUiMode has ${ SystemUiMode.values.length} values');

  final first = SystemUiMode.values.first;
  final last = SystemUiMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SystemUiMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SystemUiMode Tests'),
      Text('Values: ${ SystemUiMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
