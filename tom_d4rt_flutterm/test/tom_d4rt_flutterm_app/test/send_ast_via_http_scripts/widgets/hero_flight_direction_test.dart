// ignore_for_file: avoid_print
// D4rt test script: Tests HeroFlightDirection from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('HeroFlightDirection test executing');

  // Enumerate all HeroFlightDirection values
  print('HeroFlightDirection values:');
  for (final value in HeroFlightDirection.values) {
    print('  ${value.name}: $value');
  }
  print('HeroFlightDirection has ${ HeroFlightDirection.values.length} values');

  final first = HeroFlightDirection.values.first;
  final last = HeroFlightDirection.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('HeroFlightDirection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HeroFlightDirection Tests'),
      Text('Values: ${ HeroFlightDirection.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
