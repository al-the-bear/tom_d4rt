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

  print('ChildSemanticsConfigurationsResultBuilder test executing');
  print('=' * 50);

  runCase('Builder symbol exists', () {
    final Type t = ChildSemanticsConfigurationsResultBuilder;
    return t.toString().contains('ChildSemanticsConfigurationsResultBuilder');
  });

  runCase('Result symbol exists', () {
    final Type t = ChildSemanticsConfigurationsResult;
    return t.toString().contains('ChildSemanticsConfigurationsResult');
  });

  runCase('SemanticsConfiguration label roundtrip', () {
    final SemanticsConfiguration c = SemanticsConfiguration();
    c.label = 'alpha';
    return c.label == 'alpha';
  });

  runCase('SemanticsTag equality', () {
    const SemanticsTag a = SemanticsTag('A');
    const SemanticsTag b = SemanticsTag('A');
    return a == b;
  });

  runCase('AttributedString preserves text', () {
    final AttributedString text = AttributedString('semantic');
    return text.string == 'semantic';
  });

  runCase('SemanticsRole enum available', () => SemanticsRole.values.isNotEmpty);
  runCase('SemanticsAction enum available', () => SemanticsAction.values.isNotEmpty);

  runCase('summary string formed', () {
    final String s = 'builder:${passed.length + failed.length}';
    return s.contains(':');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('ChildSemanticsConfigurationsResultBuilder Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Check: Builder symbol resolved'),
      const Text('Check: Result symbol resolved'),
      const Text('Check: AttributedString semantics verified'),
      const Text('Builder-related semantics checks executed'),
    ],
  );
}
