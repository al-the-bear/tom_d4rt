// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SnapshotMode from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SnapshotMode test executing');

  // Enumerate all SnapshotMode values
  print('SnapshotMode values:');
  for (final value in SnapshotMode.values) {
    print('  ${value.name}: $value');
  }
  print('SnapshotMode has ${ SnapshotMode.values.length} values');

  final first = SnapshotMode.values.first;
  final last = SnapshotMode.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SnapshotMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SnapshotMode Tests'),
      Text('Values: ${ SnapshotMode.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
