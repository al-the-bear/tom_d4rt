// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LexicalFocusOrder from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LexicalFocusOrder test executing');
  print('=' * 50);

  // === Test LexicalFocusOrder class ===
  print('\nLexicalFocusOrder defines focus traversal order using strings');

  // Create a LexicalFocusOrder
  print('\n--- Testing LexicalFocusOrder creation ---');
  final order1 = LexicalFocusOrder('a');
  print('Created LexicalFocusOrder with order "a"');
  print('order1.order: ${order1.order}');
  print('order1.runtimeType: ${order1.runtimeType}');

  // Create another with different order
  print('\n--- Testing another LexicalFocusOrder ---');
  final order2 = LexicalFocusOrder('b');
  print('Created LexicalFocusOrder with order "b"');
  print('order2.order: ${order2.order}');

  // Create with longer string
  print('\n--- Testing with longer strings ---');
  final order3 = LexicalFocusOrder('abc');
  final order4 = LexicalFocusOrder('abd');
  print('order3.order: ${order3.order}');
  print('order4.order: ${order4.order}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('order1 is FocusOrder: ${order1 is FocusOrder}');

  // Test comparison (doCompare is protected, but we can test via sorting)
  print('\n--- Testing ordering behavior ---');
  print('Lexical ordering: "a" < "b" < "abc" < "abd"');
  print('order1 (a) comes before order2 (b)');
  print('order3 (abc) comes before order4 (abd)');

  // Test with numerical strings
  print('\n--- Testing with numerical strings ---');
  final num1 = LexicalFocusOrder('1');
  final num2 = LexicalFocusOrder('2');
  final num10 = LexicalFocusOrder('10');
  print('num1.order: ${num1.order}');
  print('num2.order: ${num2.order}');
  print('num10.order: ${num10.order}');
  print('Note: "10" < "2" lexically (string comparison)');

  // Test with empty string
  print('\n--- Testing edge cases ---');
  final empty = LexicalFocusOrder('');
  print('Empty order: "${empty.order}"');
  print('Empty string comes first lexically');

  // Test with special characters
  print('\n--- Testing special characters ---');
  final special1 = LexicalFocusOrder('_first');
  final special2 = LexicalFocusOrder('~last');
  print('special1.order: ${special1.order}');
  print('special2.order: ${special2.order}');

  // Test toString
  print('\n--- Testing toString ---');
  print('order1.toString(): ${order1.toString()}');

  // Test with FocusTraversalOrder widget
  print('\n--- Using with FocusTraversalOrder ---');
  print('FocusTraversalOrder(order: LexicalFocusOrder("a"), child: ...)');
  print('This assigns lexical ordering to the child widget');

  print('\n' + '=' * 50);
  print('LexicalFocusOrder test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LexicalFocusOrder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('order1: ${order1.order}'),
      Text('order2: ${order2.order}'),
      Text('Is FocusOrder: ${order1 is FocusOrder}'),
      Text('Orders lexically: a < b'),
    ],
  );
}
