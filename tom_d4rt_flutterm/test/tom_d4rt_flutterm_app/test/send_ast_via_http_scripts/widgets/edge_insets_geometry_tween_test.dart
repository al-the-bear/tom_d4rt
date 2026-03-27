// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests EdgeInsetsGeometryTween from widgets
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

  print('EdgeInsetsGeometryTween test executing');
  print('=' * 50);

  final EdgeInsetsGeometryTween tween = EdgeInsetsGeometryTween(
    begin: const EdgeInsets.all(8.0),
    end: const EdgeInsets.all(24.0),
  );

  runCase('begin is stored', () {
    return tween.begin == const EdgeInsets.all(8.0);
  });

  runCase('end is stored', () {
    return tween.end == const EdgeInsets.all(24.0);
  });

  runCase('lerp at 0.0 returns begin', () {
    final EdgeInsetsGeometry result = tween.lerp(0.0);
    return result == const EdgeInsets.all(8.0);
  });

  runCase('lerp at 1.0 returns end', () {
    final EdgeInsetsGeometry result = tween.lerp(1.0);
    return result == const EdgeInsets.all(24.0);
  });

  runCase('lerp at 0.5 returns midpoint', () {
    final EdgeInsetsGeometry result = tween.lerp(0.5);
    return result == const EdgeInsets.all(16.0);
  });

  runCase('transform calls lerp', () {
    final EdgeInsetsGeometry result = tween.transform(0.5);
    return result == const EdgeInsets.all(16.0);
  });

  runCase('runtime type is correct', () {
    return tween.runtimeType == EdgeInsetsGeometryTween;
  });

  runCase('toString is non-empty', () {
    return tween.toString().isNotEmpty;
  });

  runCase('directional begin/end works', () {
    final EdgeInsetsGeometryTween dirTween = EdgeInsetsGeometryTween(
      begin: const EdgeInsetsDirectional.only(start: 10.0),
      end: const EdgeInsetsDirectional.only(start: 30.0),
    );
    return dirTween.begin != null && dirTween.end != null;
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
      const Text('EdgeInsetsGeometryTween Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('EdgeInsetsGeometryTween behavior checks completed'),
    ],
  );
}
