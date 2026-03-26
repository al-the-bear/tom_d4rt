// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
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

  print('ConnectionState test executing');
  print('=' * 50);

  runCase('enum contains all expected states', () {
    return ConnectionState.values.length == 4 &&
        ConnectionState.values.contains(ConnectionState.none) &&
        ConnectionState.values.contains(ConnectionState.waiting) &&
        ConnectionState.values.contains(ConnectionState.active) &&
        ConnectionState.values.contains(ConnectionState.done);
  });

  runCase('ordering none->waiting->active->done', () {
    return ConnectionState.none.index == 0 &&
        ConnectionState.waiting.index == 1 &&
        ConnectionState.active.index == 2 &&
        ConnectionState.done.index == 3;
  });

  runCase('name values are stable', () {
    return ConnectionState.done.name == 'done' &&
        ConnectionState.waiting.name == 'waiting';
  });

  runCase('toString includes enum labels', () {
    return ConnectionState.active.toString().contains('active');
  });

  runCase('can be used in switch expression', () {
    final String label = switch (ConnectionState.done) {
      ConnectionState.none => 'n',
      ConnectionState.waiting => 'w',
      ConnectionState.active => 'a',
      ConnectionState.done => 'd',
    };
    return label == 'd';
  });

  runCase('summary string can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.contains('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('ConnectionState Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ConnectionState behavior checks completed'),
    ],
  );
}
