// ignore_for_file: avoid_print
// D4rt test script: Tests SliverPaintOrder from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverPaintOrder test executing');

  // Enumerate all SliverPaintOrder values
  print('SliverPaintOrder values:');
  for (final value in SliverPaintOrder.values) {
    print('  ${value.name}: $value');
  }
  print('SliverPaintOrder has ${ SliverPaintOrder.values.length} values');

  final first = SliverPaintOrder.values.first;
  final last = SliverPaintOrder.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SliverPaintOrder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverPaintOrder Tests'),
      Text('Values: ${ SliverPaintOrder.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
