// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SnapshotMode enum from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnapshotMode test executing');
  print('=' * 50);

  // Test enum values
  print('SnapshotMode values:');
  for (final mode in SnapshotMode.values) {
    print('  ${mode.name}: index=${mode.index}');
  }
  print('SnapshotMode has ${SnapshotMode.values.length} values');

  // Test individual values
  print('\nDetailed value inspection:');
  
  // permissive
  final permissive = SnapshotMode.permissive;
  print('\npermissive:');
  print('  index: ${permissive.index}');
  print('  name: ${permissive.name}');
  print('  Behavior: Snapshot if all descendants can be snapshotted');
  print('  Platform views: Falls back to non-snapshotted painting');

  // normal (default)
  final normal = SnapshotMode.normal;
  print('\nnormal (default):');
  print('  index: ${normal.index}');
  print('  name: ${normal.name}');
  print('  Behavior: Error if child cannot be snapshotted');
  print('  Platform views: Throws error');

  // forced
  final forced = SnapshotMode.forced;
  print('\nforced:');
  print('  index: ${forced.index}');
  print('  name: ${forced.name}');
  print('  Behavior: Snapshot regardless of descendants');
  print('  Platform views: Ignored in snapshot');

  // First and last
  print('\nRange verification:');
  print('  First: ${SnapshotMode.values.first}');
  print('  Last: ${SnapshotMode.values.last}');

  // Equality tests
  print('\nEquality tests:');
  print('  permissive == SnapshotMode.permissive: ${permissive == SnapshotMode.permissive}');
  print('  normal == forced: ${normal == forced}');

  // Use in SnapshotWidget
  print('\nUsage in SnapshotWidget:');
  print('  - Passed to SnapshotWidget\'s mode parameter');
  print('  - Controls platform view handling');
  print('  - Default is SnapshotMode.normal');

  // Platform view considerations
  print('\nPlatform view handling by mode:');
  print('  permissive: Uses non-snapshotted child rendering');
  print('  normal: Throws error (strictest)');
  print('  forced: Ignores platform views in snapshot');

  print('\n' + '=' * 50);
  print('SnapshotMode test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SnapshotMode Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: permissive, normal, forced'),
      Text('Default: normal'),
      Text('Controls platform view handling'),
    ],
  );
}
