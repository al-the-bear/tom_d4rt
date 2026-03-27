// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LocalHistoryEntry from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LocalHistoryEntry test executing');
  print('=' * 50);

  // === Test LocalHistoryEntry class ===
  print('\nLocalHistoryEntry represents an entry in local navigation history');

  // Create a basic LocalHistoryEntry
  print('\n--- Testing LocalHistoryEntry creation ---');
  var removeCallCount = 0;
  final entry = LocalHistoryEntry(
    onRemove: () {
      removeCallCount++;
      print('Entry removed! Count: $removeCallCount');
    },
  );
  print('Created LocalHistoryEntry with onRemove callback');
  print('entry.runtimeType: ${entry.runtimeType}');
  print('entry.impliesAppBarDismissal: ${entry.impliesAppBarDismissal}');

  // Test with impliesAppBarDismissal = false
  print('\n--- Testing with impliesAppBarDismissal = false ---');
  final entryNoDismissal = LocalHistoryEntry(
    onRemove: () => print('No dismissal entry removed'),
    impliesAppBarDismissal: false,
  );
  print('entryNoDismissal.impliesAppBarDismissal: ${entryNoDismissal.impliesAppBarDismissal}');

  // Test without onRemove
  print('\n--- Testing without onRemove ---');
  final entryNoCallback = LocalHistoryEntry();
  print('Created entry without onRemove callback');
  print('entryNoCallback.impliesAppBarDismissal: ${entryNoCallback.impliesAppBarDismissal}');

  // Test remove method behavior
  print('\n--- Understanding remove method ---');
  print('entry.remove() removes from owning LocalHistoryRoute');
  print('Calls onRemove callback when removed');
  print('Note: Cannot call remove() without route owner');

  // Test with various callbacks
  print('\n--- Testing callback patterns ---');
  var stateValue = 'initial';
  final stateEntry = LocalHistoryEntry(
    onRemove: () {
      stateValue = 'removed';
    },
  );
  print('Created entry that modifies state on remove');
  print('Current state: $stateValue');

  // Test default values
  print('\n--- Testing default values ---');
  print('Default impliesAppBarDismissal: true');
  print('Default onRemove: null');

  // Usage context
  print('\n--- Usage context ---');
  print('Used with LocalHistoryRoute mixin');
  print('ModalRoute.addLocalHistoryEntry(entry)');
  print('Enables sub-page navigation within a route');
  print('Back button pops local history before route');

  print('\n' + '=' * 50);
  print('LocalHistoryEntry test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LocalHistoryEntry Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('impliesAppBarDismissal: ${entry.impliesAppBarDismissal}'),
      Text('Has onRemove: true'),
      Text('Purpose: Local navigation history'),
    ],
  );
}
