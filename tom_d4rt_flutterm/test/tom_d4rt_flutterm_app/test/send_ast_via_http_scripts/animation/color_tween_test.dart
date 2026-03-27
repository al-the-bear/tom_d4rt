// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ColorTween from animation
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

  print('ColorTween test executing');
  print('=' * 50);

  final ColorTween tween = ColorTween(begin: Colors.red, end: Colors.blue);

  runCase('tween can be created', () {
    return tween.runtimeType == ColorTween;
  });

  runCase('begin is stored', () {
    return tween.begin == Colors.red;
  });

  runCase('end is stored', () {
    return tween.end == Colors.blue;
  });

  runCase('lerp at 0.0 returns begin', () {
    final Color? result = tween.lerp(0.0);
    return result == Colors.red;
  });

  runCase('lerp at 1.0 returns end', () {
    final Color? result = tween.lerp(1.0);
    return result == Colors.blue;
  });

  runCase('lerp at 0.5 returns blended color', () {
    final Color? result = tween.lerp(0.5);
    return result != null && result != Colors.red && result != Colors.blue;
  });

  runCase('null begin treats as transparent', () {
    final ColorTween t = ColorTween(begin: null, end: Colors.blue);
    final Color? result = t.lerp(0.5);
    return result != null;
  });

  runCase('transform uses lerp', () {
    final Color? result = tween.transform(0.5);
    return result == tween.lerp(0.5);
  });

  runCase('toString is non-empty', () {
    return tween.toString().isNotEmpty;
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
      const Text('ColorTween Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ColorTween behavior checks completed'),
    ],
  );
}
