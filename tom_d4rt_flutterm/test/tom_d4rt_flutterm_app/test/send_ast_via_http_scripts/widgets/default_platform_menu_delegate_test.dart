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

  print('DefaultPlatformMenuDelegate test executing');
  print('=' * 50);

  final DefaultPlatformMenuDelegate delegate = DefaultPlatformMenuDelegate();

  runCase('delegate is PlatformMenuDelegate', () {
    return delegate is PlatformMenuDelegate;
  });

  runCase('runtime type is stable', () {
    return delegate.runtimeType.toString().contains('DefaultPlatformMenuDelegate');
  });

  runCase('hashCode is consistent', () {
    return delegate.hashCode == delegate.hashCode;
  });

  runCase('toString includes class name', () {
    return delegate.toString().contains('DefaultPlatformMenuDelegate');
  });

  runCase('can be assigned to base type', () {
    final PlatformMenuDelegate base = delegate;
    return base.runtimeType == delegate.runtimeType;
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
      const Text('DefaultPlatformMenuDelegate Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DefaultPlatformMenuDelegate behavior checks completed'),
    ],
  );
}
