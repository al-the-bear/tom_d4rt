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

  print('CrossFadeState test executing');
  print('=' * 50);

  runCase('enum has two states', () {
    return CrossFadeState.values.length == 2;
  });

  runCase('contains showFirst and showSecond', () {
    return CrossFadeState.values.contains(CrossFadeState.showFirst) &&
        CrossFadeState.values.contains(CrossFadeState.showSecond);
  });

  runCase('ordering is stable', () {
    return CrossFadeState.showFirst.index == 0 &&
        CrossFadeState.showSecond.index == 1;
  });

  runCase('name values are stable', () {
    return CrossFadeState.showFirst.name == 'showFirst' &&
        CrossFadeState.showSecond.name == 'showSecond';
  });

  runCase('toString includes enum names', () {
    return CrossFadeState.showSecond.toString().contains('showSecond');
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
      const Text('CrossFadeState Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('CrossFadeState behavior checks completed'),
    ],
  );
}
