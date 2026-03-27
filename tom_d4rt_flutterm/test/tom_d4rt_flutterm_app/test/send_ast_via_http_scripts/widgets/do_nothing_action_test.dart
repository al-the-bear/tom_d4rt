// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DoNothingAction from widgets
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

  print('DoNothingAction test executing');
  print('=' * 50);

  final DoNothingAction action = DoNothingAction();

  runCase('action can be created with default consumesKey', () {
    return action.runtimeType == DoNothingAction;
  });

  runCase('consumesKey defaults to true', () {
    const DoNothingIntent intent = DoNothingIntent();
    return action.consumesKey(intent) == true;
  });

  runCase('consumesKey false when specified', () {
    final DoNothingAction noConsume = DoNothingAction(consumesKey: false);
    const DoNothingIntent intent = DoNothingIntent();
    return noConsume.consumesKey(intent) == false;
  });

  runCase('invoke does nothing (no exception)', () {
    const DoNothingIntent intent = DoNothingIntent();
    action.invoke(intent);
    return true;
  });

  runCase('toString is non-empty', () {
    return action.toString().isNotEmpty;
  });

  runCase('two instances are independent', () {
    final DoNothingAction a2 = DoNothingAction();
    return !identical(action, a2);
  });

  runCase('hashCode is consistent', () {
    return action.hashCode == action.hashCode;
  });

  runCase('isActionEnabled is true', () {
    return action.isActionEnabled == true;
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
      const Text('DoNothingAction Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DoNothingAction behavior checks completed'),
    ],
  );
}
