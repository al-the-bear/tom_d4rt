// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RefreshIndicatorStatus from material
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

  print('RefreshIndicatorStatus test executing');
  print('=' * 50);

  // RefreshIndicatorStatus enum: drag, armed, snap, refresh, done, canceled
  runCase('RefreshIndicatorStatus.values has 6 entries', () {
    return RefreshIndicatorStatus.values.length == 6;
  });

  runCase('drag value exists', () {
    final value = RefreshIndicatorStatus.drag;
    print('  drag: index=${value.index}, name=${value.name}');
    return value.index == 0 && value.name == 'drag';
  });

  runCase('armed value exists', () {
    final value = RefreshIndicatorStatus.armed;
    print('  armed: index=${value.index}, name=${value.name}');
    return value.index == 1;
  });

  runCase('snap value exists', () {
    final value = RefreshIndicatorStatus.snap;
    print('  snap: index=${value.index}, name=${value.name}');
    return value.index == 2;
  });

  runCase('refresh value exists', () {
    final value = RefreshIndicatorStatus.refresh;
    print('  refresh: index=${value.index}, name=${value.name}');
    return value.index == 3;
  });

  runCase('done value exists', () {
    final value = RefreshIndicatorStatus.done;
    print('  done: index=${value.index}, name=${value.name}');
    return value.index == 4;
  });

  runCase('canceled value exists', () {
    final value = RefreshIndicatorStatus.canceled;
    print('  canceled: index=${value.index}, name=${value.name}');
    return value.index == 5;
  });

  runCase('drag is first value', () {
    return RefreshIndicatorStatus.values.first == RefreshIndicatorStatus.drag;
  });

  runCase('canceled is last value', () {
    return RefreshIndicatorStatus.values.last == RefreshIndicatorStatus.canceled;
  });

  runCase('enum values are comparable', () {
    return RefreshIndicatorStatus.drag != RefreshIndicatorStatus.refresh;
  });

  runCase('summary string can be formed', () {
    final summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('RefreshIndicatorStatus Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
