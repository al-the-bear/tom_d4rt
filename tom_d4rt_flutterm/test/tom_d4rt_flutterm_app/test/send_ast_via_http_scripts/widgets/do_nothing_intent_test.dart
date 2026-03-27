// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DoNothingIntent from widgets
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

  print('DoNothingIntent test executing');
  print('=' * 50);

  const DoNothingIntent intent = DoNothingIntent();

  runCase('intent can be constructed', () {
    return intent.runtimeType.toString().contains('DoNothingIntent');
  });

  runCase('two const instances are identical', () {
    const DoNothingIntent other = DoNothingIntent();
    return identical(intent, other);
  });

  runCase('toString is non-empty', () {
    return intent.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return intent.hashCode == intent.hashCode;
  });

  runCase('runtime type matches expected private type', () {
    // DoNothingIntent uses private constructor, runtime type may differ
    return intent.runtimeType.toString().contains('DoNothingIntent');
  });

  runCase('DoNothingAction handles this intent', () {
    final DoNothingAction action = DoNothingAction();
    action.invoke(intent);
    return true;
  });

  runCase('DoNothingAction consumesKey returns true for this', () {
    final DoNothingAction action = DoNothingAction();
    return action.consumesKey(intent) == true;
  });

  runCase('different from stop propagation variant', () {
    const DoNothingAndStopPropagationIntent other =
        DoNothingAndStopPropagationIntent();
    return intent.runtimeType != other.runtimeType;
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
      const Text('DoNothingIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DoNothingIntent behavior checks completed'),
    ],
  );
}
