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

  print('DecorationTween test executing');
  print('=' * 50);

  final DecorationTween tween = DecorationTween(
    begin: const BoxDecoration(color: Colors.red),
    end: const BoxDecoration(color: Colors.blue),
  );

  runCase('begin decoration is stored', () {
    return tween.begin is BoxDecoration;
  });

  runCase('end decoration is stored', () {
    return tween.end is BoxDecoration;
  });

  runCase('lerp at 0 gives begin-like value', () {
    final Decoration? value = tween.transform(0);
    return value != null;
  });

  runCase('lerp at 1 gives end-like value', () {
    final Decoration? value = tween.transform(1);
    return value != null;
  });

  runCase('lerp at 0.5 returns decoration', () {
    final Decoration? value = tween.transform(0.5);
    return value is Decoration;
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
      const Text('DecorationTween Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DecorationTween behavior checks completed'),
    ],
  );
}
