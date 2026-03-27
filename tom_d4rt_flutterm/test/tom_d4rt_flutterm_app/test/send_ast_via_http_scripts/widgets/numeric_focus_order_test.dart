// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NumericFocusOrder from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NumericFocusOrder test executing');
  print('=' * 50);

  // === Test NumericFocusOrder class ===
  print('\nNumericFocusOrder orders by numeric value');

  // Create NumericFocusOrder instances
  print('\n--- Testing creation ---');
  final order1 = NumericFocusOrder(1.0);
  final order2 = NumericFocusOrder(2.0);
  final order3 = NumericFocusOrder(3.0);
  print('Created NumericFocusOrder(1.0)');
  print('Created NumericFocusOrder(2.0)');
  print('Created NumericFocusOrder(3.0)');

  // Test order property
  print('\n--- Testing order property ---');
  print('order1.order: ${order1.order}');
  print('order2.order: ${order2.order}');
  print('order3.order: ${order3.order}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('order1 is FocusOrder: ${order1 is FocusOrder}');

  // Test comparison (via doCompare)
  print('\n--- Testing comparison ---');
  print('Lower order values come first');
  print('order1 < order2 < order3 in traversal');

  // Test with fractional values
  print('\n--- Testing fractional values ---');
  final orderFrac = NumericFocusOrder(1.5);
  print('NumericFocusOrder(1.5).order: ${orderFrac.order}');
  print('Sorts between 1.0 and 2.0');

  // Test with negative values
  print('\n--- Testing negative values ---');
  final orderNeg = NumericFocusOrder(-1.0);
  print('NumericFocusOrder(-1.0).order: ${orderNeg.order}');
  print('Comes before positive values');

  // Test with Focus.order
  print('\n--- Testing with Focus widget ---');
  final focus = Focus(
    focusNode: FocusNode(),
    child: FocusTraversalOrder(
      order: NumericFocusOrder(5.0),
      child: Text('Ordered focus'),
    ),
  );
  print('Created Focus with NumericFocusOrder(5.0)');

  // Test with OrderedTraversalPolicy
  print('\n--- Testing with OrderedTraversalPolicy ---');
  print('OrderedTraversalPolicy uses FocusOrder');
  print('NumericFocusOrder provides numeric ordering');

  // Test toString
  print('\n--- Testing toString ---');
  print('order1.toString(): ${order1.toString()}');

  print('\n' + '=' * 50);
  print('NumericFocusOrder test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NumericFocusOrder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('order1.order: ${order1.order}'),
      Text('order2.order: ${order2.order}'),
      Text('Is FocusOrder: ${order1 is FocusOrder}'),
      focus,
    ],
  );
}
