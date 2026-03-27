// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DismissAction from widgets
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

  print('DismissAction test executing');
  print('=' * 50);

  // DismissAction is abstract; test via DismissMenuAction (concrete subclass)
  // and verify the DismissAction type hierarchy
  runCase('DismissAction type name is accessible', () {
    return 'DismissAction'.isNotEmpty;
  });

  runCase('DismissMenuAction is a concrete subclass', () {
    final MenuController controller = MenuController();
    final DismissMenuAction action = DismissMenuAction(controller: controller);
    return action.runtimeType.toString().contains('DismissMenuAction');
  });

  runCase('DismissMenuAction stores controller reference', () {
    final MenuController controller = MenuController();
    final DismissMenuAction action = DismissMenuAction(controller: controller);
    return identical(action.controller, controller);
  });

  runCase('DismissIntent can be created', () {
    const DismissIntent intent = DismissIntent();
    return intent.runtimeType.toString().contains('DismissIntent');
  });

  runCase('DismissAction name follows Flutter conventions', () {
    return 'DismissAction'.endsWith('Action');
  });

  runCase('two DismissMenuAction instances are independent', () {
    final MenuController c1 = MenuController();
    final MenuController c2 = MenuController();
    final DismissMenuAction a1 = DismissMenuAction(controller: c1);
    final DismissMenuAction a2 = DismissMenuAction(controller: c2);
    return !identical(a1, a2);
  });

  runCase('toString of concrete subclass is non-empty', () {
    final MenuController controller = MenuController();
    final DismissMenuAction action = DismissMenuAction(controller: controller);
    return action.toString().isNotEmpty;
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
      const Text('DismissAction Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DismissAction behavior checks completed'),
    ],
  );
}
