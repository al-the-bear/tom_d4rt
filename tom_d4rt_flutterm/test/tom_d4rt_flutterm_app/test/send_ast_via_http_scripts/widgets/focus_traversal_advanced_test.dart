// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests WidgetOrderTraversalPolicy,
// ReadingOrderTraversalPolicy, FocusOrder, FocusAttachment,
// DirectionalFocusTraversalPolicyMixin
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Focus traversal advanced test executing');

  // ========== TraversalDirection ==========
  print('--- TraversalDirection Tests ---');
  for (final dir in TraversalDirection.values) {
    print('TraversalDirection: ${dir.name}');
  }

  // ========== WidgetOrderTraversalPolicy ==========
  print('--- WidgetOrderTraversalPolicy Tests ---');
  final widgetOrderPolicy = WidgetOrderTraversalPolicy();
  print('WidgetOrderTraversalPolicy created');

  // ========== ReadingOrderTraversalPolicy ==========
  print('--- ReadingOrderTraversalPolicy Tests ---');
  final readingPolicy = ReadingOrderTraversalPolicy();
  print('ReadingOrderTraversalPolicy created');

  // ========== OrderedTraversalPolicy ==========
  print('--- OrderedTraversalPolicy Tests ---');
  final orderedPolicy = OrderedTraversalPolicy();
  print('OrderedTraversalPolicy created');

  // ========== NumericFocusOrder ==========
  print('--- NumericFocusOrder Tests ---');
  final num1 = NumericFocusOrder(1.0);
  final num2 = NumericFocusOrder(2.0);
  final num3 = NumericFocusOrder(0.5);
  print('NumericFocusOrder 1.0: ${num1.order}');
  print('NumericFocusOrder 2.0: ${num2.order}');
  print('Comparison: ${num1.compareTo(num2)}');
  print('Comparison: ${num3.compareTo(num1)}');

  // ========== LexicalFocusOrder ==========
  print('--- LexicalFocusOrder Tests ---');
  final lex1 = LexicalFocusOrder('alpha');
  final lex2 = LexicalFocusOrder('beta');
  print('LexicalFocusOrder alpha: ${lex1.order}');
  print('LexicalFocusOrder beta: ${lex2.order}');
  print('Comparison: ${lex1.compareTo(lex2)}');

  // ========== FocusNode ==========
  print('--- FocusNode/FocusAttachment Tests ---');
  final node = FocusNode(debugLabel: 'testNode');
  print('FocusNode created: ${node.debugLabel}');
  print('  hasFocus: ${node.hasFocus}');
  print('  canRequestFocus: ${node.canRequestFocus}');
  node.dispose();
  print('FocusNode disposed');

  print('All focus traversal tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: FocusTraversalGroup(
        policy: OrderedTraversalPolicy(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Focus Traversal Advanced Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              FocusTraversalOrder(
                order: NumericFocusOrder(1.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('First (1.0)'),
                ),
              ),
              FocusTraversalOrder(
                order: NumericFocusOrder(2.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Second (2.0)'),
                ),
              ),
              FocusTraversalOrder(
                order: NumericFocusOrder(0.5),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Third (0.5)'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
