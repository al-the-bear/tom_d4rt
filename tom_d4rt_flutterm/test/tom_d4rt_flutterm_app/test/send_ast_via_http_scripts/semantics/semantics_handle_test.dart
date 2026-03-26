// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/semantics.dart';
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

  print('SemanticsHandle test executing');
  print('=' * 50);

  runCase('SemanticsHandle symbol exists', () {
    final Type t = SemanticsHandle;
    return t.toString().contains('SemanticsHandle');
  });

  runCase('SemanticsBinding symbol exists', () {
    final Type t = SemanticsBinding;
    return t.toString().contains('SemanticsBinding');
  });

  runCase('SemanticsOwner symbol exists', () {
    final Type t = SemanticsOwner;
    return t.toString().contains('SemanticsOwner');
  });

  runCase('SemanticsNode symbol exists', () {
    final Type t = SemanticsNode;
    return t.toString().contains('SemanticsNode');
  });

  runCase('SemanticsUpdateBuilder symbol exists', () {
    final Type t = SemanticsUpdateBuilder;
    return t.toString().contains('SemanticsUpdateBuilder');
  });

  runCase('SemanticsAction enum populated', () => SemanticsAction.values.isNotEmpty);
  runCase('SemanticsFlag enum populated', () => SemanticsFlag.values.isNotEmpty);

  runCase('summary string formed', () {
    final String s = 'handle:${passed.length + failed.length}';
    return s.startsWith('handle:');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('SemanticsHandle Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Check: SemanticsHandle type resolved'),
      const Text('Check: SemanticsOwner type resolved'),
      const Text('Check: SemanticsAction/Flag enums resolved'),
      const Text('Check: SemanticsUpdateBuilder symbol resolved'),
      const Text('Semantics handle type and related API checks completed'),
    ],
  );
}
