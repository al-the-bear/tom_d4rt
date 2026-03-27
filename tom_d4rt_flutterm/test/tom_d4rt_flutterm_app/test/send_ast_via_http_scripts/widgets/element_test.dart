// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Element from widgets
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

  print('Element test executing');
  print('=' * 50);

  // Element is abstract, but context IS an Element; test via BuildContext
  final Element element = context as Element;

  runCase('context is an Element', () {
    return element.runtimeType.toString().contains('Element');
  });

  runCase('element has a widget', () {
    return element.widget.runtimeType.toString().isNotEmpty;
  });

  runCase('element depth is positive', () {
    return element.depth > 0;
  });

  runCase('element is mounted', () {
    return element.mounted == true;
  });

  runCase('element size may be available', () {
    final Size? s = element.size;
    return s == null || (s.width >= 0 && s.height >= 0);
  });

  runCase('element owner is non-null when mounted', () {
    return element.owner != null;
  });

  runCase('element debugGetCreatorChain returns non-empty', () {
    return element.debugGetCreatorChain(5).isNotEmpty;
  });

  runCase('element toStringShort is non-empty', () {
    return element.toStringShort().isNotEmpty;
  });

  runCase('element slot can be read', () {
    // slot is nullable, just verify access
    element.slot;
    return true;
  });

  runCase('element hashCode is consistent', () {
    return element.hashCode == element.hashCode;
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
      const Text('Element Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Element behavior checks completed'),
    ],
  );
}
