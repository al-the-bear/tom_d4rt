// D4rt test script: Tests ServicesServiceExtensions from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ServicesServiceExtensions test executing');

  // Enumerate all ServicesServiceExtensions values
  print('ServicesServiceExtensions values:');
  for (final value in ServicesServiceExtensions.values) {
    print('  ${value.name}: $value');
  }
  print('ServicesServiceExtensions has ${ ServicesServiceExtensions.values.length} values');

  final first = ServicesServiceExtensions.values.first;
  final last = ServicesServiceExtensions.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ServicesServiceExtensions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ServicesServiceExtensions Tests'),
      Text('Values: ${ ServicesServiceExtensions.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
