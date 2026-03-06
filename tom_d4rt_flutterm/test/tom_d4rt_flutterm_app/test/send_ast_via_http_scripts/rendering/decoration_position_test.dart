// D4rt test script: Tests DecorationPosition from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DecorationPosition test executing');

  // Enumerate all DecorationPosition values
  print('DecorationPosition values:');
  for (final value in DecorationPosition.values) {
    print('  ${value.name}: $value');
  }
  print('DecorationPosition has ${ DecorationPosition.values.length} values');

  final first = DecorationPosition.values.first;
  final last = DecorationPosition.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DecorationPosition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DecorationPosition Tests'),
      Text('Values: ${ DecorationPosition.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
