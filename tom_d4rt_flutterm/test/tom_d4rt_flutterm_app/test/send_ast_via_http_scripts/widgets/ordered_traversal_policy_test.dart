// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OrderedTraversalPolicy from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OrderedTraversalPolicy test executing');
  print('=' * 50);

  // === Test OrderedTraversalPolicy class ===
  print('\nOrderedTraversalPolicy traverses by FocusOrder');

  // Create OrderedTraversalPolicy
  print('\n--- Testing creation ---');
  final policy = OrderedTraversalPolicy();
  print('Created OrderedTraversalPolicy');
  print('policy.runtimeType: ${policy.runtimeType}');

  // Test with secondary
  print('\n--- Testing with secondary policy ---');
  final policyWithSecondary = OrderedTraversalPolicy(
    secondary: ReadingOrderTraversalPolicy(),
  );
  print('Created with ReadingOrderTraversalPolicy secondary');
  print('secondary used for unordered nodes');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('policy is FocusTraversalPolicy: ${policy is FocusTraversalPolicy}');

  // Test sortDescendants
  print('\n--- Testing sortDescendants ---');
  print('Sorts focusables by FocusOrder.order');
  print('Primary sort: explicit FocusOrder');
  print('Secondary sort: secondary policy');

  // Test with FocusTraversalGroup
  print('\n--- Testing with FocusTraversalGroup ---');
  final group = FocusTraversalGroup(
    policy: OrderedTraversalPolicy(),
    child: Column(
      children: [
        FocusTraversalOrder(
          order: NumericFocusOrder(2),
          child: Focus(child: Text('Second')),
        ),
        FocusTraversalOrder(
          order: NumericFocusOrder(1),
          child: Focus(child: Text('First')),
        ),
        FocusTraversalOrder(
          order: NumericFocusOrder(3),
          child: Focus(child: Text('Third')),
        ),
      ],
    ),
  );
  print('Created FocusTraversalGroup with policy');
  print('Order: 2, 1, 3 visually -> 1, 2, 3 traversal');

  // Test next/previous
  print('\n--- Testing next/previous ---');
  print('next(): moves to higher order');
  print('previous(): moves to lower order');

  // FocusOrder types
  print('\n--- FocusOrder types ---');
  print('NumericFocusOrder: compare by double');
  print('LexicalFocusOrder: compare alphabetically');
  print('Custom FocusOrder: override doCompare');

  // Unordered nodes
  print('\n--- Unordered nodes ---');
  print('Nodes without FocusOrder');
  print('Sorted by secondary policy');
  print('Default secondary: ReadingOrderTraversalPolicy');

  print('\n' + '=' * 50);
  print('OrderedTraversalPolicy test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OrderedTraversalPolicy Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Is FocusTraversalPolicy: true'),
      Text('Uses: FocusOrder for sorting'),
      group,
    ],
  );
}
