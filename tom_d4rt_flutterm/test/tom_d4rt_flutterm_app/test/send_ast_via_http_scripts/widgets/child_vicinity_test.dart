// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// Handcrafted D4rt print-only test focused on ChildVicinity semantics.
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

  print('ChildVicinity test executing');
  print('=' * 50);

  const ChildVicinity a = ChildVicinity(xIndex: 1, yIndex: 2);
  const ChildVicinity b = ChildVicinity(xIndex: 1, yIndex: 2);
  const ChildVicinity c = ChildVicinity(xIndex: 2, yIndex: 1);

  runCase('xIndex is stored', () {
    return a.xIndex == 1;
  });

  runCase('yIndex is stored', () {
    return a.yIndex == 2;
  });

  runCase('equality uses both coordinates', () {
    return a == b && a != c;
  });

  runCase('hashCode aligns with equality', () {
    return a.hashCode == b.hashCode && a.hashCode != c.hashCode;
  });

  runCase('toString references coordinates', () {
    final String s = a.toString();
    return s.contains('1') && s.contains('2');
  });

  runCase('can be used as map key', () {
    final Map<ChildVicinity, String> map = <ChildVicinity, String>{a: 'node'};
    return map[b] == 'node';
  });

  runCase('summary text can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('ChildVicinity Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ChildVicinity behavior checks completed'),
    ],
  );
}
