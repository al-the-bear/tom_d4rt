// D4rt test script: Tests FoundationServiceExtensions from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FoundationServiceExtensions test executing');

  // Enumerate all FoundationServiceExtensions values
  print('FoundationServiceExtensions values:');
  for (final value in FoundationServiceExtensions.values) {
    print('  ${value.name}: $value');
  }
  print(
    'FoundationServiceExtensions has ${FoundationServiceExtensions.values.length} values',
  );

  final first = FoundationServiceExtensions.values.first;
  final last = FoundationServiceExtensions.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('FoundationServiceExtensions test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FoundationServiceExtensions Tests'),
      Text('Values: ${FoundationServiceExtensions.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
