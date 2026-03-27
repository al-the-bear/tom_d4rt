// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FixedExtentScrollPhysics from widgets
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

  print('FixedExtentScrollPhysics test executing');
  print('=' * 50);

  const FixedExtentScrollPhysics physics = FixedExtentScrollPhysics();

  runCase('physics can be created', () {
    return physics.runtimeType == FixedExtentScrollPhysics;
  });

  runCase('parent defaults to null', () {
    return physics.parent == null;
  });

  runCase('physics with parent stores parent', () {
    const FixedExtentScrollPhysics withParent = FixedExtentScrollPhysics(
      parent: BouncingScrollPhysics(),
    );
    return withParent.parent != null;
  });

  runCase('applyTo returns FixedExtentScrollPhysics', () {
    final ScrollPhysics result = physics.applyTo(const ClampingScrollPhysics());
    return result.runtimeType == FixedExtentScrollPhysics;
  });

  runCase('applyTo with null returns FixedExtentScrollPhysics', () {
    final ScrollPhysics result = physics.applyTo(null);
    return result.runtimeType == FixedExtentScrollPhysics;
  });

  runCase('toString is non-empty', () {
    return physics.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return physics.hashCode == physics.hashCode;
  });

  runCase('two const instances are identical', () {
    const FixedExtentScrollPhysics other = FixedExtentScrollPhysics();
    return identical(physics, other);
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
      const Text('FixedExtentScrollPhysics Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FixedExtentScrollPhysics behavior checks completed'),
    ],
  );
}
