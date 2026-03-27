// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeyEventResult from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeyEventResult test executing');
  print('=' * 50);

  // === Test KeyEventResult enum ===
  print('\nKeyEventResult is an enum that describes how to handle a key event');

  // Enumerate all values
  print('\nKeyEventResult values:');
  for (final value in KeyEventResult.values) {
    print('  \${value.name}: index=\${value.index}');
  }
  print('KeyEventResult has \${KeyEventResult.values.length} values');

  // Test each value individually
  print('\n--- Testing KeyEventResult.handled ---');
  final handled = KeyEventResult.handled;
  print('handled: \$handled');
  print('handled.index: \${handled.index}');
  print('handled.name: \${handled.name}');
  print('Purpose: The key event has been handled and should not propagate');

  print('\n--- Testing KeyEventResult.ignored ---');
  final ignored = KeyEventResult.ignored;
  print('ignored: \$ignored');
  print('ignored.index: \${ignored.index}');
  print('ignored.name: \${ignored.name}');
  print('Purpose: The key event has not been handled and should propagate');

  print('\n--- Testing KeyEventResult.skipRemainingHandlers ---');
  final skip = KeyEventResult.skipRemainingHandlers;
  print('skipRemainingHandlers: \$skip');
  print('skipRemainingHandlers.index: \${skip.index}');
  print('skipRemainingHandlers.name: \${skip.name}');
  print('Purpose: Not handled but should not propagate to other handlers');

  // Test comparisons
  print('\n--- Testing comparisons ---');
  print('handled == handled: \${handled == KeyEventResult.handled}');
  print('handled == ignored: \${handled == ignored}');
  print('handled != skip: \${handled != skip}');

  // Test first and last
  print('\n--- Testing first and last ---');
  final first = KeyEventResult.values.first;
  final last = KeyEventResult.values.last;
  print('First value: \$first (index \${first.index})');
  print('Last value: \$last (index \${last.index})');

  // Test hashCode
  print('\n--- Testing hashCode ---');
  print('handled.hashCode: \${handled.hashCode}');
  print('ignored.hashCode: \${ignored.hashCode}');
  print('skipRemainingHandlers.hashCode: \${skip.hashCode}');
  print('All hashCodes are different: \${handled.hashCode != ignored.hashCode && ignored.hashCode != skip.hashCode}');

  // Test runtimeType
  print('\n--- Testing runtimeType ---');
  print('handled.runtimeType: \${handled.runtimeType}');

  // Test contains
  print('\n--- Testing list contains ---');
  print('values.contains(handled): \${KeyEventResult.values.contains(handled)}');

  print('\n' + '=' * 50);
  print('KeyEventResult test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'KeyEventResult Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: \${KeyEventResult.values.length}'),
      Text('handled: index \${KeyEventResult.handled.index}'),
      Text('ignored: index \${KeyEventResult.ignored.index}'),
      Text('skipRemainingHandlers: index \${KeyEventResult.skipRemainingHandlers.index}'),
    ],
  );
}
