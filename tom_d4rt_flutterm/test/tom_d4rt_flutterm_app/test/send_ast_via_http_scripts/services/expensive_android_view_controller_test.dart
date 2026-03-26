// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/services.dart';
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

  print('ExpensiveAndroidViewController test executing');
  print('=' * 50);

  runCase('ExpensiveAndroidViewController symbol exists', () {
    final Type t = ExpensiveAndroidViewController;
    return t.toString().contains('ExpensiveAndroidViewController');
  });

  runCase('AndroidViewController base symbol exists', () {
    final Type t = AndroidViewController;
    return t.toString().contains('AndroidViewController');
  });

  runCase('SurfaceAndroidViewController symbol exists', () {
    final Type t = SurfaceAndroidViewController;
    return t.toString().contains('SurfaceAndroidViewController');
  });

  runCase('TextureAndroidViewController symbol exists', () {
    final Type t = TextureAndroidViewController;
    return t.toString().contains('TextureAndroidViewController');
  });

  runCase('AndroidMotionEvent symbol exists', () {
    final Type t = AndroidMotionEvent;
    return t.toString().contains('AndroidMotionEvent');
  });

  runCase('AndroidPointerProperties constructor works', () {
    const AndroidPointerProperties p = AndroidPointerProperties(id: 7, toolType: 0);
    return p.id == 7;
  });

  runCase('AndroidPointerCoords constructor works', () {
    const AndroidPointerCoords c = AndroidPointerCoords(orientation: 0, pressure: 1, size: 1, toolMajor: 1, toolMinor: 1, touchMajor: 1, touchMinor: 1, x: 6, y: 9);
    return c.x == 6 && c.y == 9;
  });

  runCase('summary string formed', () {
    final String s = 'expensive-controller:${passed.length + failed.length}';
    return s.contains('controller');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('ExpensiveAndroidViewController Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Android controller hierarchy and pointer primitives checked'),
    ],
  );
}
