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

  print('ContextMenuButtonType test executing');
  print('=' * 50);

  runCase('enum has common edit actions', () {
    return ContextMenuButtonType.values.contains(ContextMenuButtonType.copy) &&
        ContextMenuButtonType.values.contains(ContextMenuButtonType.cut) &&
        ContextMenuButtonType.values.contains(ContextMenuButtonType.paste);
  });

  runCase('enum has at least 5 values', () {
    return ContextMenuButtonType.values.length >= 5;
  });

  runCase('name for copy is stable', () {
    return ContextMenuButtonType.copy.name == 'copy';
  });

  runCase('toString includes enum label', () {
    return ContextMenuButtonType.paste.toString().contains('paste');
  });

  runCase('indices are unique', () {
    final Set<int> idx = ContextMenuButtonType.values.map((e) => e.index).toSet();
    return idx.length == ContextMenuButtonType.values.length;
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
      const Text('ContextMenuButtonType Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ContextMenuButtonType behavior checks completed'),
    ],
  );
}
