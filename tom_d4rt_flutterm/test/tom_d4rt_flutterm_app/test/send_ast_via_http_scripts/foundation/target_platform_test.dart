// D4rt test script: Tests TargetPlatform from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TargetPlatform test executing');

  // Enumerate all TargetPlatform values
  print('TargetPlatform values:');
  for (final value in TargetPlatform.values) {
    print('  ${value.name}: $value');
  }
  print('TargetPlatform has ${ TargetPlatform.values.length} values');

  final first = TargetPlatform.values.first;
  final last = TargetPlatform.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TargetPlatform test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TargetPlatform Tests'),
      Text('Values: ${ TargetPlatform.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
