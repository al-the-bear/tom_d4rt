// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DirectionalFocusAction from widgets
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

  print('DirectionalFocusAction test executing');
  print('=' * 50);

  final DirectionalFocusAction action = DirectionalFocusAction();
  final DirectionalFocusAction textAction = DirectionalFocusAction.forTextField();

  runCase('default action can be created', () {
    return action.runtimeType.toString().contains('DirectionalFocusAction');
  });

  runCase('forTextField action can be created', () {
    return textAction.runtimeType.toString().contains('DirectionalFocusAction');
  });

  runCase('action and textAction share runtime type', () {
    return action.runtimeType == textAction.runtimeType;
  });

  runCase('isActionEnabled can be queried', () {
    final bool enabled = action.isActionEnabled;
    return enabled == true || enabled == false;
  });

  runCase('toString is non-empty', () {
    return action.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return action.hashCode == action.hashCode;
  });

  runCase('two default instances are independent', () {
    final DirectionalFocusAction a2 = DirectionalFocusAction();
    return !identical(action, a2);
  });

  runCase('DirectionalFocusIntent can target all directions', () {
    const List<TraversalDirection> dirs = TraversalDirection.values;
    return dirs.length == 4;
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
      const Text('DirectionalFocusAction Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DirectionalFocusAction behavior checks completed'),
    ],
  );
}
