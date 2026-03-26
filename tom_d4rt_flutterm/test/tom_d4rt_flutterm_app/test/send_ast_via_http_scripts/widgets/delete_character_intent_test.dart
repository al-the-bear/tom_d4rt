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

  print('DeleteCharacterIntent test executing');
  print('=' * 50);

  const DeleteCharacterIntent forward = DeleteCharacterIntent(forward: true);
  const DeleteCharacterIntent backward = DeleteCharacterIntent(forward: false);

  runCase('forward flag is stored', () {
    return forward.forward && !backward.forward;
  });

  runCase('intents are Intent subtypes', () {
    return forward is Intent && backward is Intent;
  });

  runCase('different direction implies inequality', () {
    return forward != backward;
  });

  runCase('same direction implies equality', () {
    const DeleteCharacterIntent same = DeleteCharacterIntent(forward: true);
    return same == forward;
  });

  runCase('toString mentions class', () {
    return forward.toString().contains('DeleteCharacterIntent');
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
      const Text('DeleteCharacterIntent Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DeleteCharacterIntent behavior checks completed'),
    ],
  );
}
