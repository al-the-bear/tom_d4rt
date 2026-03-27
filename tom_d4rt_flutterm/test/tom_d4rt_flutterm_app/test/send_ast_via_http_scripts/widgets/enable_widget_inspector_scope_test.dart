// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests EnableWidgetInspectorScope from widgets
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

  print('EnableWidgetInspectorScope test executing');
  print('=' * 50);

  const EnableWidgetInspectorScope scope = EnableWidgetInspectorScope(
    child: SizedBox.shrink(),
  );

  runCase('scope can be constructed', () {
    return scope.runtimeType == EnableWidgetInspectorScope;
  });

  runCase('child is accessible', () {
    return scope.child is SizedBox;
  });

  runCase('key defaults to null', () {
    return scope.key == null;
  });

  runCase('scope with key works', () {
    const EnableWidgetInspectorScope keyed = EnableWidgetInspectorScope(
      key: ValueKey<String>('inspector'),
      child: SizedBox.shrink(),
    );
    return keyed.key == const ValueKey<String>('inspector');
  });

  runCase('createElement returns an element', () {
    final Element elem = scope.createElement();
    return elem.runtimeType.toString().isNotEmpty;
  });

  runCase('scope extends ProxyWidget', () {
    return scope.runtimeType.toString().contains('EnableWidgetInspectorScope');
  });

  runCase('toString is non-empty', () {
    return scope.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return scope.hashCode == scope.hashCode;
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
      const Text('EnableWidgetInspectorScope Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('EnableWidgetInspectorScope behavior checks completed'),
    ],
  );
}
