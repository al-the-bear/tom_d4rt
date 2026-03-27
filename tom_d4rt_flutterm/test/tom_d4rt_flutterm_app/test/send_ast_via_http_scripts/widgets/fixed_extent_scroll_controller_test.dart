// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FixedExtentScrollController from widgets
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

  print('FixedExtentScrollController test executing');
  print('=' * 50);

  final FixedExtentScrollController controller = FixedExtentScrollController();

  runCase('controller can be created', () {
    return controller.runtimeType == FixedExtentScrollController;
  });

  runCase('initialItem defaults to 0', () {
    return controller.initialItem == 0;
  });

  runCase('custom initialItem is stored', () {
    final FixedExtentScrollController c = FixedExtentScrollController(initialItem: 5);
    final bool result = c.initialItem == 5;
    c.dispose();
    return result;
  });

  runCase('hasClients is false initially', () {
    return controller.hasClients == false;
  });

  runCase('selectedItem throws when no clients', () {
    try {
      controller.selectedItem;
      return false;
    } on AssertionError {
      return true;
    } catch (_) {
      return true;
    }
  });

  runCase('toString is non-empty', () {
    return controller.toString().isNotEmpty;
  });

  runCase('dispose works without error', () {
    final FixedExtentScrollController c2 = FixedExtentScrollController();
    c2.dispose();
    return true;
  });

  runCase('two controllers are independent', () {
    final FixedExtentScrollController c2 = FixedExtentScrollController(initialItem: 3);
    final bool result = c2.initialItem != controller.initialItem;
    c2.dispose();
    return result;
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
      const Text('FixedExtentScrollController Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FixedExtentScrollController behavior checks completed'),
    ],
  );
}
