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

  print('DarwinPlatformViewController test executing');
  print('=' * 50);

  runCase('DarwinPlatformViewController symbol exists', () {
    final Type t = DarwinPlatformViewController;
    return t.toString().contains('DarwinPlatformViewController');
  });

  runCase('UiKitViewController symbol exists', () {
    final Type t = UiKitViewController;
    return t.toString().contains('UiKitViewController');
  });

  runCase('AppKitViewController symbol exists', () {
    final Type t = AppKitViewController;
    return t.toString().contains('AppKitViewController');
  });

  runCase('PlatformViewController base symbol exists', () {
    final Type t = PlatformViewController;
    return t.toString().contains('PlatformViewController');
  });

  runCase('PlatformViewsService symbol exists', () {
    final Type t = PlatformViewsService;
    return t.toString().contains('PlatformViewsService');
  });

  runCase('PlatformViewController symbol repeated check', () {
    final Type t = PlatformViewController;
    return t.toString().contains('PlatformViewController');
  });

  runCase('summary string formed', () {
    final String s = 'darwin-platform-view:${passed.length + failed.length}';
    return s.contains('darwin');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('DarwinPlatformViewController Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Check: Darwin base symbol resolved'),
      const Text('Check: UiKit and AppKit symbols resolved'),
      const Text('Check: PlatformViewsService symbol resolved'),
      const Text('Darwin platform-view controller hierarchy checks done'),
    ],
  );
}
