// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetOrderTraversalPolicy from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WidgetOrderTraversalPolicy test executing');
  print('=' * 50);

  // WidgetOrderTraversalPolicy for focus order
  print('WidgetOrderTraversalPolicy overview:');
  print('  - Extends FocusTraversalPolicy');
  print('  - With DirectionalFocusTraversalPolicyMixin');
  print('  - Focus order matches widget order');
  print('  - Natural reading order');

  // Test policy
  print('\nCreating policy:');
  final policy = WidgetOrderTraversalPolicy();
  print('  Created: $policy');

  // Focus order
  print('\nFocus order:');
  print('  - Matches widget tree order');
  print('  - Depth-first traversal');
  print('  - Left to right, top to bottom');
  print('  - Natural for reading flow');

  // sortDescendants method
  print('\nsortDescendants method:');
  print('  - Core ordering method');
  print('  - Returns sorted Iterable<FocusNode>');
  print('  - Based on widget tree position');
  print('  - No explicit order property');

  // DirectionalFocusTraversalPolicyMixin
  print('\nDirectionalFocusTraversalPolicyMixin:');
  print('  - Adds arrow key navigation');
  print('  - findFirstFocusInDirection');
  print('  - Handles up/down/left/right');
  print('  - Geometric focus movement');

  // vs OrderedTraversalPolicy
  print('\nvs OrderedTraversalPolicy:');
  print('  - WidgetOrderTraversalPolicy: implicit order');
  print('  - OrderedTraversalPolicy: explicit FocusOrder');
  print('  - Widget order is simpler');
  print('  - Explicit for custom order');

  // Usage
  print('\nUsage:');
  print('  FocusTraversalGroup(');
  print('    policy: WidgetOrderTraversalPolicy(),');
  print('    child: Column(');
  print('      children: [');
  print('        TextField(), // Focus order 1');
  print('        TextField(), // Focus order 2');
  print('        TextField(), // Focus order 3');
  print('      ],');
  print('    ),');
  print('  )');

  // Tab navigation
  print('\nTab navigation:');
  print('  - Tab moves to next in order');
  print('  - Shift+Tab moves to previous');
  print('  - Wraps at boundaries');
  print('  - Respects FocusTraversalGroup');

  // Benefits
  print('\nBenefits:');
  print('  - Predictable focus order');
  print('  - Matches visual layout');
  print('  - No extra configuration');
  print('  - Good for forms');

  print('\n' + '=' * 50);
  print('WidgetOrderTraversalPolicy test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WidgetOrderTraversalPolicy Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: FocusTraversalPolicy'),
      Text('Mixin: DirectionalFocusTraversalPolicyMixin'),
      Text('Order: Widget tree order'),
    ],
  );
}
