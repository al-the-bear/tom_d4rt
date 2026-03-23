// ignore_for_file: avoid_print
// D4rt test script: Tests OverlayChildLocation from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverlayChildLocation test executing');

  // Enumerate all OverlayChildLocation values
  print('OverlayChildLocation values:');
  for (final value in OverlayChildLocation.values) {
    print('  ${value.name}: $value');
  }
  print('OverlayChildLocation has ${ OverlayChildLocation.values.length} values');

  final first = OverlayChildLocation.values.first;
  final last = OverlayChildLocation.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('OverlayChildLocation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverlayChildLocation Tests'),
      Text('Values: ${ OverlayChildLocation.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
