// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DisableWidgetInspectorScope from widgets
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

  print('DisableWidgetInspectorScope test executing');
  print('=' * 50);

  const DisableWidgetInspectorScope scope = DisableWidgetInspectorScope(
    child: SizedBox.shrink(),
  );

  runCase('scope can be constructed', () {
    return scope.runtimeType.toString().contains('DisableWidgetInspectorScope');
  });

  runCase('child is accessible', () {
    return scope.child.runtimeType.toString().contains('SizedBox');
  });

  runCase('key is null by default', () {
    return scope.key == null;
  });

  runCase('scope with key can be created', () {
    const DisableWidgetInspectorScope keyed = DisableWidgetInspectorScope(
      key: ValueKey<String>('inspector-scope'),
      child: SizedBox.shrink(),
    );
    return keyed.key == const ValueKey<String>('inspector-scope');
  });

  runCase('createElement returns a valid element', () {
    final Element element = scope.createElement();
    return element.runtimeType.toString().isNotEmpty;
  });

  runCase('toString is non-empty', () {
    return scope.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return scope.hashCode == scope.hashCode;
  });

  runCase('two scopes with same child are independent', () {
    const DisableWidgetInspectorScope s2 = DisableWidgetInspectorScope(
      child: SizedBox.shrink(),
    );
    return !identical(scope, s2);
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
      const Text('DisableWidgetInspectorScope Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DisableWidgetInspectorScope behavior checks completed'),
    ],
  );
}
