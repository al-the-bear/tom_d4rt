// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ReadingOrderTraversalPolicy from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ReadingOrderTraversalPolicy test executing');
  print('=' * 50);

  // === Test ReadingOrderTraversalPolicy ===
  print('\nReadingOrderTraversalPolicy sorts in reading order');

  // Create policy
  print('\n--- Creating policy ---');
  final policy = ReadingOrderTraversalPolicy();
  print('Created ReadingOrderTraversalPolicy()');
  print('policy.runtimeType: ${policy.runtimeType}');

  // Test inheritance
  print('\n--- Inheritance ---');
  print('policy is FocusTraversalPolicy: ${policy is FocusTraversalPolicy}');
  print('Extends FocusTraversalPolicy');
  print('Mixes DirectionalFocusTraversalPolicyMixin');

  // Sort method
  print('\n--- Static sort() method ---');
  print('Iterable<FocusNode> sort(Iterable<FocusNode> nodes)');
  print('Sorts nodes into reading order');
  print('Top-to-bottom, start-to-end');

  // Reading order algorithm
  print('\n--- Reading order algorithm ---');
  print('1. Find topmost nodes');
  print('2. Pick leftmost (LTR) or rightmost (RTL)');
  print('3. Remove picked, repeat');
  print('4. Considers Directionality');

  // Directionality handling
  print('\n--- Directionality handling ---');
  print('Respects text direction');
  print('Groups by directionality');
  print('Sorts each group separately');

  // Directional focus
  print('\n--- Directional focus ---');
  print('Arrow keys navigate spatially');
  print('Uses DirectionalFocusTraversalPolicyMixin');
  print('Finds nearest in direction');

  // Usage
  print('\n--- Default usage ---');
  print('Default policy in FocusTraversalGroup');
  print('Used by Tab key navigation');
  print('Applied via FocusScope');

  // Related policies
  print('\n--- Related policies ---');
  print('OrderedTraversalPolicy: explicit order');
  print('WidgetOrderTraversalPolicy: widget order');


  // Band algorithm
  print('\n--- Band algorithm ---');
  print('Groups nodes into horizontal bands');
  print('Sorts within band by reading direction');
  print('Picks next from adjacent bands');

  // Custom policy
  print('\n--- Using custom policy ---');
  print('FocusTraversalGroup(');
  print('  policy: ReadingOrderTraversalPolicy(),');
  print('  child: ...,');
  print(')');

  print('\n' + '=' * 50);
  print('ReadingOrderTraversalPolicy test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ReadingOrderTraversalPolicy Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: FocusTraversalPolicy'),
      Text('Method: sort()'),
      Text('Default for: FocusTraversalGroup'),
    ],
  );
}
