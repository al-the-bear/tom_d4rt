// ignore_for_file: avoid_print
// D4rt test script: Tests TextCapitalization from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextCapitalization test executing');

  // Enumerate all TextCapitalization values
  print('TextCapitalization values:');
  for (final value in TextCapitalization.values) {
    print('  ${value.name}: $value');
  }
  print('TextCapitalization has ${TextCapitalization.values.length} values');

  final first = TextCapitalization.values.first;
  final last = TextCapitalization.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('TextCapitalization test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextCapitalization Tests'),
      Text('Values: ${TextCapitalization.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
