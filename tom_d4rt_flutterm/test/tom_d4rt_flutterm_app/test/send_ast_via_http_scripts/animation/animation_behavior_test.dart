// D4rt test script: Tests AnimationBehavior from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationBehavior test executing');

  // Enumerate all AnimationBehavior values
  print('AnimationBehavior values:');
  for (final value in AnimationBehavior.values) {
    print('  ${value.name}: $value');
  }
  print('AnimationBehavior has ${ AnimationBehavior.values.length} values');

  final first = AnimationBehavior.values.first;
  final last = AnimationBehavior.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('AnimationBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimationBehavior Tests'),
      Text('Values: ${ AnimationBehavior.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
