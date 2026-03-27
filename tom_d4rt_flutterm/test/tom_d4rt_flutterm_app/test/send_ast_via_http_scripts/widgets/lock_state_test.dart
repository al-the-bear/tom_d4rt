// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LockState from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LockState test executing');
  print('=' * 50);

  // === Test LockState enum ===
  print('\nLockState indicates keyboard lock key states');

  // Enumerate all values
  print('\nLockState values:');
  for (final value in LockState.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('LockState has ${LockState.values.length} values');

  // Test each value
  print('\n--- Testing LockState.ignored ---');
  final ignored = LockState.ignored;
  print('ignored: $ignored');
  print('ignored.index: ${ignored.index}');
  print('ignored.name: ${ignored.name}');
  print('Meaning: Lock state is not relevant for activation');

  print('\n--- Testing LockState.locked ---');
  final locked = LockState.locked;
  print('locked: $locked');
  print('locked.index: ${locked.index}');
  print('locked.name: ${locked.name}');
  print('Meaning: Lock key must be active');

  print('\n--- Testing LockState.unlocked ---');
  final unlocked = LockState.unlocked;
  print('unlocked: $unlocked');
  print('unlocked.index: ${unlocked.index}');
  print('unlocked.name: ${unlocked.name}');
  print('Meaning: Lock key must be inactive');

  // Test comparisons
  print('\n--- Testing comparisons ---');
  print('ignored == ignored: ${ignored == LockState.ignored}');
  print('locked == unlocked: ${locked == unlocked}');
  print('ignored != locked: ${ignored != locked}');

  // Test first and last
  print('\n--- Testing first and last ---');
  final first = LockState.values.first;
  final last = LockState.values.last;
  print('First value: $first (index ${first.index})');
  print('Last value: $last (index ${last.index})');

  // Test hashCode
  print('\n--- Testing hashCode ---');
  print('ignored.hashCode: ${ignored.hashCode}');
  print('locked.hashCode: ${locked.hashCode}');
  print('unlocked.hashCode: ${unlocked.hashCode}');

  // Usage context
  print('\n--- Usage context ---');
  print('Used with KeySet and ShortcutActivator');
  print('Tracks Caps Lock, Num Lock, Scroll Lock');
  print('Affects keyboard shortcut matching');

  print('\n' + '=' * 50);
  print('LockState test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LockState Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${LockState.values.length}'),
      Text('ignored: ${LockState.ignored.index}'),
      Text('locked: ${LockState.locked.index}'),
      Text('unlocked: ${LockState.unlocked.index}'),
    ],
  );
}
