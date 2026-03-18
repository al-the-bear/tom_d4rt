// D4rt test script: Tests SmartQuotesType from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SmartQuotesType test executing');

  // Enumerate all SmartQuotesType values
  print('SmartQuotesType values:');
  for (final value in SmartQuotesType.values) {
    print('  ${value.name}: $value');
  }
  print('SmartQuotesType has ${ SmartQuotesType.values.length} values');

  final first = SmartQuotesType.values.first;
  final last = SmartQuotesType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SmartQuotesType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SmartQuotesType Tests'),
      Text('Values: ${ SmartQuotesType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
