// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExpansibleController from widgets
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

  print('ExpansibleController test executing');
  print('=' * 50);

  final ExpansibleController controller = ExpansibleController();

  runCase('controller can be created', () {
    return controller.runtimeType == ExpansibleController;
  });

  runCase('isExpanded defaults to false', () {
    return controller.isExpanded == false;
  });

  runCase('expand sets isExpanded to true', () {
    controller.expand();
    return controller.isExpanded == true;
  });

  runCase('collapse sets isExpanded to false', () {
    controller.collapse();
    return controller.isExpanded == false;
  });

  runCase('expand then collapse round-trips', () {
    controller.expand();
    final bool expanded = controller.isExpanded;
    controller.collapse();
    final bool collapsed = controller.isExpanded;
    return expanded == true && collapsed == false;
  });

  runCase('listener is notified on expand', () {
    bool notified = false;
    controller.addListener(() { notified = true; });
    controller.expand();
    return notified == true;
  });

  runCase('dispose works without error', () {
    final ExpansibleController c2 = ExpansibleController();
    c2.dispose();
    return true;
  });

  runCase('two controllers are independent', () {
    final ExpansibleController c2 = ExpansibleController();
    controller.expand();
    final bool result = c2.isExpanded == false;
    c2.dispose();
    controller.collapse();
    return result;
  });

  runCase('toString is non-empty', () {
    return controller.toString().isNotEmpty;
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
      const Text('ExpansibleController Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ExpansibleController behavior checks completed'),
    ],
  );
}
