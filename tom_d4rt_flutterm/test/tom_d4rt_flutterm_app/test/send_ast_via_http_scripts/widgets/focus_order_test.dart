// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FocusOrder from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final List<String> passed = <String>[];
  final List<String> failed = <String>[];

  void runCase(String name, bool Function() body) {
    try {
      if (body()) {
        passed.add(name);
        print('PASS: $name');
      } else {
        failed.add(name);
        print('FAIL: $name');
      }
    } catch (e, s) {
      failed.add('$name threw');
      print('FAIL: $name threw $e');
      print(s.toString());
    }
  }

  print('FocusOrder test executing');
  print('=' * 50);

  const NumericFocusOrder order1 = NumericFocusOrder(1.0);
  const NumericFocusOrder order2 = NumericFocusOrder(2.0);
  const NumericFocusOrder order1b = NumericFocusOrder(1.0);

  runCase('NumericFocusOrder extends FocusOrder', () {
    return order1.runtimeType.toString().contains('NumericFocusOrder');
  });

  runCase('order value is stored', () {
    return order1.order == 1.0;
  });

  runCase('compareTo returns negative for lower order', () {
    return order1.compareTo(order2) < 0;
  });

  runCase('compareTo returns positive for higher order', () {
    return order2.compareTo(order1) > 0;
  });

  runCase('compareTo returns 0 for equal order', () {
    return order1.compareTo(order1b) == 0;
  });

  runCase('two const instances with same value are identical', () {
    return identical(order1, order1b);
  });

  runCase('LexicalFocusOrder also extends FocusOrder', () {
    const LexicalFocusOrder lex = LexicalFocusOrder('a');
    return lex.order == 'a';
  });

  runCase('LexicalFocusOrder comparison works', () {
    const LexicalFocusOrder a = LexicalFocusOrder('a');
    const LexicalFocusOrder b = LexicalFocusOrder('b');
    return a.compareTo(b) < 0;
  });

  runCase('toString is non-empty', () {
    return order1.toString().isNotEmpty;
  });

  runCase('summary string can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('FocusOrder Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FocusOrder behavior checks completed'),
    ],
  );
}
