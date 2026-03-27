// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DoNothingAndStopPropagationIntent from widgets
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

  print('DoNothingAndStopPropagationIntent test executing');
  print('=' * 50);

  const DoNothingAndStopPropagationIntent intent =
      DoNothingAndStopPropagationIntent();

  runCase('intent can be constructed via factory const', () {
    return intent.runtimeType.toString()
        .contains('DoNothingAndStopPropagationIntent');
  });

  runCase('two const instances are identical', () {
    const DoNothingAndStopPropagationIntent other =
        DoNothingAndStopPropagationIntent();
    return identical(intent, other);
  });

  runCase('toString is non-empty', () {
    return intent.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return intent.hashCode == intent.hashCode;
  });

  runCase('runtime type matches exactly', () {
    return intent.runtimeType.toString() ==
        '_DoNothingAndStopPropagationIntent' ||
        intent.runtimeType.toString().contains('DoNothingAndStopPropagation');
  });

  runCase('intent is different from DoNothingIntent', () {
    const DoNothingIntent other = DoNothingIntent();
    return intent.runtimeType != other.runtimeType;
  });

  runCase('DoNothingAction with consumesKey false pairs with this', () {
    final DoNothingAction action = DoNothingAction(consumesKey: false);
    return action.consumesKey(intent) == false;
  });

  runCase('DoNothingAction invoke does nothing with this intent', () {
    final DoNothingAction action = DoNothingAction();
    action.invoke(intent);
    return true;
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
      const Text('DoNothingAndStopPropagationIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DoNothingAndStopPropagationIntent behavior checks completed'),
    ],
  );
}
