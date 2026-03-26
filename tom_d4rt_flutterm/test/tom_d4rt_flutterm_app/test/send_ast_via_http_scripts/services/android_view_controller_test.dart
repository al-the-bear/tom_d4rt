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

  print('AndroidViewController test executing');
  print('=' * 50);

  runCase('AndroidViewController symbol exists', () {
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

  runCase('ExpensiveAndroidViewController symbol exists', () {
    final Type t = ExpensiveAndroidViewController;
    return t.toString().contains('ExpensiveAndroidViewController');
  });

  runCase('PlatformViewsService symbol exists', () {
    final Type t = PlatformViewsService;
    return t.toString().contains('PlatformViewsService');
  });

  runCase('AndroidPointerProperties constructor works', () {
    const AndroidPointerProperties p = AndroidPointerProperties(id: 1, toolType: 0);
    return p.id == 1;
  });

  runCase('AndroidPointerCoords constructor works', () {
    const AndroidPointerCoords c = AndroidPointerCoords(orientation: 0, pressure: 1, size: 1, toolMajor: 1, toolMinor: 1, touchMajor: 1, touchMinor: 1, x: 3, y: 4);
    return c.x == 3 && c.y == 4;
  });

  runCase('summary string formed', () {
    final String s = 'android-view:${passed.length + failed.length}';
    return s.contains('android-view');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('AndroidViewController Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Android platform-view controller symbols validated'),
    ],
  );
}
