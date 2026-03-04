// D4rt test script: Tests CupertinoListSectionType from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoListSectionType test executing');

  // Enumerate all CupertinoListSectionType values
  print('CupertinoListSectionType values:');
  for (final value in CupertinoListSectionType.values) {
    print('  ${value.name}: $value');
  }
  print('CupertinoListSectionType has ${ CupertinoListSectionType.values.length} values');

  final first = CupertinoListSectionType.values.first;
  final last = CupertinoListSectionType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('CupertinoListSectionType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CupertinoListSectionType Tests'),
      Text('Values: ${ CupertinoListSectionType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
