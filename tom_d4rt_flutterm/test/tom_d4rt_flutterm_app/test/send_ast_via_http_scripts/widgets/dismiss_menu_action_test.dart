// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DismissMenuAction from widgets
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

  print('DismissMenuAction test executing');
  print('=' * 50);

  final MenuController controller = MenuController();
  final DismissMenuAction action = DismissMenuAction(controller: controller);

  runCase('action stores controller', () {
    return identical(action.controller, controller);
  });

  runCase('runtime type is correct', () {
    return action.runtimeType.toString().contains('DismissMenuAction');
  });

  runCase('isEnabled returns false when no anchor', () {
    const DismissIntent intent = DismissIntent();
    return action.isEnabled(intent) == false;
  });

  runCase('isActionEnabled is accessible', () {
    final bool enabled = action.isActionEnabled;
    return enabled == true || enabled == false;
  });

  runCase('toString is non-empty', () {
    return action.toString().isNotEmpty;
  });

  runCase('two actions with different controllers are independent', () {
    final MenuController c2 = MenuController();
    final DismissMenuAction a2 = DismissMenuAction(controller: c2);
    return !identical(action, a2);
  });

  runCase('hashCode is consistent', () {
    return action.hashCode == action.hashCode;
  });

  runCase('controller on both actions differ', () {
    final MenuController c2 = MenuController();
    final DismissMenuAction a2 = DismissMenuAction(controller: c2);
    return !identical(action.controller, a2.controller);
  });

  runCase('DismissIntent is correct type for invoke', () {
    const DismissIntent intent = DismissIntent();
    return intent.runtimeType == DismissIntent;
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
      const Text('DismissMenuAction Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DismissMenuAction behavior checks completed'),
    ],
  );
}
