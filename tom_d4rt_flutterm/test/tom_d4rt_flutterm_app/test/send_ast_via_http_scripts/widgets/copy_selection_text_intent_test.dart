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

  print('CopySelectionTextIntent test executing');
  print('=' * 50);

  const CopySelectionTextIntent intent = CopySelectionTextIntent(SelectionChangedCause.tap);

  runCase('intent stores cause', () {
    return intent.cause == SelectionChangedCause.tap;
  });

  runCase('intent is an Intent', () {
    return intent is Intent;
  });

  runCase('different cause means inequality', () {
    const CopySelectionTextIntent other = CopySelectionTextIntent(SelectionChangedCause.keyboard);
    return intent != other;
  });

  runCase('same cause means equality', () {
    const CopySelectionTextIntent again = CopySelectionTextIntent(SelectionChangedCause.tap);
    return intent == again;
  });

  runCase('toString mentions intent class', () {
    return intent.toString().contains('CopySelectionTextIntent');
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
      const Text('CopySelectionTextIntent Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('CopySelectionTextIntent behavior checks completed'),
    ],
  );
}
