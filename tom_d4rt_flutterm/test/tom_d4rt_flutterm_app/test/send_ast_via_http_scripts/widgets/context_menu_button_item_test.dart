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

  print('ContextMenuButtonItem test executing');
  print('=' * 50);

  bool invoked = false;
  final ContextMenuButtonItem item = ContextMenuButtonItem(
    label: 'Copy',
    onPressed: () {
      invoked = true;
    },
    type: ContextMenuButtonType.copy,
  );

  runCase('label is stored', () {
    return item.label == 'Copy';
  });

  runCase('type is stored', () {
    return item.type == ContextMenuButtonType.copy;
  });

  runCase('onPressed callback is callable', () {
    item.onPressed();
    return invoked;
  });

  runCase('copyWith can change label', () {
    final ContextMenuButtonItem changed = item.copyWith(label: 'Cut');
    return changed.label == 'Cut' && changed.type == item.type;
  });

  runCase('copyWith can change type', () {
    final ContextMenuButtonItem changed = item.copyWith(type: ContextMenuButtonType.cut);
    return changed.type == ContextMenuButtonType.cut;
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
      const Text('ContextMenuButtonItem Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ContextMenuButtonItem behavior checks completed'),
    ],
  );
}
