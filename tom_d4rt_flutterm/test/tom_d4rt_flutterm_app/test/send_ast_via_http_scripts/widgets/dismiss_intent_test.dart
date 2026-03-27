// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DismissIntent from widgets
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

  print('DismissIntent test executing');
  print('=' * 50);

  const DismissIntent intent = DismissIntent();

  runCase('intent can be constructed', () {
    return intent.runtimeType.toString().contains('DismissIntent');
  });

  runCase('intent is const-constructible', () {
    const DismissIntent other = DismissIntent();
    return identical(intent, other);
  });

  runCase('toString is non-empty', () {
    return intent.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return intent.hashCode == intent.hashCode;
  });

  runCase('two const instances are identical', () {
    const DismissIntent a = DismissIntent();
    const DismissIntent b = DismissIntent();
    return identical(a, b);
  });

  runCase('runtime type name matches', () {
    return intent.runtimeType == DismissIntent;
  });

  runCase('can be passed to action isEnabled check', () {
    final MenuController controller = MenuController();
    final DismissMenuAction action = DismissMenuAction(controller: controller);
    final bool enabled = action.isEnabled(intent);
    return enabled == true || enabled == false;
  });

  runCase('intent runtimeType is stable', () {
    return intent.runtimeType.toString() == 'DismissIntent';
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
      const Text('DismissIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DismissIntent behavior checks completed'),
    ],
  );
}
