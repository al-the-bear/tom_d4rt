// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DiagonalDragBehavior from widgets
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

  print('DiagonalDragBehavior test executing');
  print('=' * 50);

  runCase('enum has exactly 4 values', () {
    return DiagonalDragBehavior.values.length == 4;
  });

  runCase('contains none value', () {
    return DiagonalDragBehavior.values.contains(DiagonalDragBehavior.none);
  });

  runCase('contains weightedEvent value', () {
    return DiagonalDragBehavior.values.contains(DiagonalDragBehavior.weightedEvent);
  });

  runCase('contains weightedContinuous value', () {
    return DiagonalDragBehavior.values.contains(DiagonalDragBehavior.weightedContinuous);
  });

  runCase('contains free value', () {
    return DiagonalDragBehavior.values.contains(DiagonalDragBehavior.free);
  });

  runCase('none has index 0', () {
    return DiagonalDragBehavior.none.index == 0;
  });

  runCase('free has the highest index', () {
    return DiagonalDragBehavior.free.index == DiagonalDragBehavior.values.length - 1;
  });

  runCase('name values are stable', () {
    return DiagonalDragBehavior.none.name == 'none' &&
        DiagonalDragBehavior.free.name == 'free';
  });

  runCase('toString includes enum name', () {
    return DiagonalDragBehavior.weightedEvent.toString().contains('weightedEvent');
  });

  runCase('indices are unique', () {
    final Set<int> idx = DiagonalDragBehavior.values.map((e) => e.index).toSet();
    return idx.length == DiagonalDragBehavior.values.length;
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
      const Text('DiagonalDragBehavior Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DiagonalDragBehavior behavior checks completed'),
    ],
  );
}
