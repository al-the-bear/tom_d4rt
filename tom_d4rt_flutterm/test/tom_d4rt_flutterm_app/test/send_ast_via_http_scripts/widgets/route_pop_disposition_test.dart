// ignore_for_file: avoid_print
// D4rt test script: Tests RoutePopDisposition from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RoutePopDisposition test executing');

  // Enumerate all RoutePopDisposition values
  print('RoutePopDisposition values:');
  for (final value in RoutePopDisposition.values) {
    print('  ${value.name}: $value');
  }
  print('RoutePopDisposition has ${ RoutePopDisposition.values.length} values');

  final first = RoutePopDisposition.values.first;
  final last = RoutePopDisposition.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('RoutePopDisposition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RoutePopDisposition Tests'),
      Text('Values: ${ RoutePopDisposition.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
