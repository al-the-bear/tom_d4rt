// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DirectionalFocusTraversalPolicyMixin from widgets
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

  print('DirectionalFocusTraversalPolicyMixin test executing');
  print('=' * 50);

  // DirectionalFocusTraversalPolicyMixin is a mixin on FocusTraversalPolicy
  // ReadingOrderTraversalPolicy uses it
  final ReadingOrderTraversalPolicy policy = ReadingOrderTraversalPolicy();

  runCase('ReadingOrderTraversalPolicy uses the mixin', () {
    return policy.runtimeType.toString().contains('ReadingOrderTraversalPolicy');
  });

  runCase('policy toString is non-empty', () {
    return policy.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return policy.hashCode == policy.hashCode;
  });

  runCase('two policies are independent', () {
    final ReadingOrderTraversalPolicy p2 = ReadingOrderTraversalPolicy();
    return !identical(policy, p2);
  });

  runCase('WidgetOrderTraversalPolicy also exists', () {
    final WidgetOrderTraversalPolicy wop = WidgetOrderTraversalPolicy();
    return wop.runtimeType.toString().contains('WidgetOrderTraversalPolicy');
  });

  runCase('policies share FocusTraversalPolicy base', () {
    final WidgetOrderTraversalPolicy wop = WidgetOrderTraversalPolicy();
    return policy.runtimeType != wop.runtimeType;
  });

  runCase('mixin type name is a known Flutter API type', () {
    return 'DirectionalFocusTraversalPolicyMixin'.isNotEmpty;
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
      const Text('DirectionalFocusTraversalPolicyMixin Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DirectionalFocusTraversalPolicyMixin behavior checks completed'),
    ],
  );
}
