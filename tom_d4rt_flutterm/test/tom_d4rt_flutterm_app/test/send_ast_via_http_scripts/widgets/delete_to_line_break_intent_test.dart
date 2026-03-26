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

  print('DeleteToLineBreakIntent test executing');
  print('=' * 50);

  const DeleteToLineBreakIntent forward = DeleteToLineBreakIntent(forward: true);
  const DeleteToLineBreakIntent backward = DeleteToLineBreakIntent(forward: false);

  runCase('forward flag is stored', () {
    return forward.forward && !backward.forward;
  });

  runCase('intent is an Intent subtype', () {
    return forward is Intent;
  });

  runCase('different direction implies inequality', () {
    return forward != backward;
  });

  runCase('same direction implies equality', () {
    const DeleteToLineBreakIntent same = DeleteToLineBreakIntent(forward: true);
    return same == forward;
  });

  runCase('toString includes class name', () {
    return forward.toString().contains('DeleteToLineBreakIntent');
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
      const Text('DeleteToLineBreakIntent Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DeleteToLineBreakIntent behavior checks completed'),
    ],
  );
}
