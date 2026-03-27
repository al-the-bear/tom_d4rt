// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DismissDirection from widgets
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

  print('DismissDirection test executing');
  print('=' * 50);

  runCase('enum has 7 values', () {
    return DismissDirection.values.length == 7;
  });

  runCase('contains vertical', () {
    return DismissDirection.values.contains(DismissDirection.vertical);
  });

  runCase('contains horizontal', () {
    return DismissDirection.values.contains(DismissDirection.horizontal);
  });

  runCase('contains endToStart', () {
    return DismissDirection.values.contains(DismissDirection.endToStart);
  });

  runCase('contains startToEnd', () {
    return DismissDirection.values.contains(DismissDirection.startToEnd);
  });

  runCase('contains up', () {
    return DismissDirection.values.contains(DismissDirection.up);
  });

  runCase('contains down', () {
    return DismissDirection.values.contains(DismissDirection.down);
  });

  runCase('contains none', () {
    return DismissDirection.values.contains(DismissDirection.none);
  });

  runCase('name values are stable', () {
    return DismissDirection.vertical.name == 'vertical' &&
        DismissDirection.none.name == 'none';
  });

  runCase('indices are unique', () {
    final Set<int> idx = DismissDirection.values.map((e) => e.index).toSet();
    return idx.length == DismissDirection.values.length;
  });

  runCase('toString includes enum name', () {
    return DismissDirection.horizontal.toString().contains('horizontal');
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
      const Text('DismissDirection Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DismissDirection behavior checks completed'),
    ],
  );
}
