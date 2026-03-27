// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FocusTraversalOrder from widgets
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

  print('FocusTraversalOrder test executing');
  print('=' * 50);

  const FocusTraversalOrder widget = FocusTraversalOrder(
    order: NumericFocusOrder(1.0),
    child: SizedBox.shrink(),
  );

  runCase('widget can be constructed', () {
    return widget.runtimeType == FocusTraversalOrder;
  });

  runCase('order is stored', () {
    return widget.order.runtimeType == NumericFocusOrder;
  });

  runCase('child is accessible', () {
    return widget.child.runtimeType.toString().contains('SizedBox');
  });

  runCase('key defaults to null', () {
    return widget.key == null;
  });

  runCase('widget with key works', () {
    const FocusTraversalOrder keyed = FocusTraversalOrder(
      key: ValueKey<String>('order'),
      order: NumericFocusOrder(2.0),
      child: SizedBox.shrink(),
    );
    return keyed.key == const ValueKey<String>('order');
  });

  runCase('updateShouldNotify returns bool', () {
    final bool result = widget.updateShouldNotify(widget);
    return result == true || result == false;
  });

  runCase('toString is non-empty', () {
    return widget.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return widget.hashCode == widget.hashCode;
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
      const Text('FocusTraversalOrder Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FocusTraversalOrder behavior checks completed'),
    ],
  );
}
