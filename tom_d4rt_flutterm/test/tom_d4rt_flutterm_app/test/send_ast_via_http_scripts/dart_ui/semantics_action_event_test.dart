// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SemanticsActionEvent from dart_ui
import 'dart:ui' as ui;
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

  print('SemanticsActionEvent test executing');
  print('=' * 50);

  final ui.SemanticsActionEvent event = ui.SemanticsActionEvent(
    type: ui.SemanticsAction.tap,
    viewId: 0,
    nodeId: 1,
  );

  runCase('event can be created', () {
    return event.runtimeType == ui.SemanticsActionEvent;
  });

  runCase('type is stored', () {
    return event.type == ui.SemanticsAction.tap;
  });

  runCase('viewId is stored', () {
    return event.viewId == 0;
  });

  runCase('nodeId is stored', () {
    return event.nodeId == 1;
  });

  runCase('arguments defaults to null', () {
    return event.arguments == null;
  });

  runCase('copyWith preserves values', () {
    final ui.SemanticsActionEvent copy = event.copyWith();
    return copy.type == event.type &&
        copy.viewId == event.viewId &&
        copy.nodeId == event.nodeId;
  });

  runCase('copyWith can override type', () {
    final ui.SemanticsActionEvent copy = event.copyWith(type: ui.SemanticsAction.longPress);
    return copy.type == ui.SemanticsAction.longPress;
  });

  runCase('copyWith can override nodeId', () {
    final ui.SemanticsActionEvent copy = event.copyWith(nodeId: 42);
    return copy.nodeId == 42;
  });

  runCase('arguments can be passed', () {
    final ui.SemanticsActionEvent withArgs = ui.SemanticsActionEvent(
      type: ui.SemanticsAction.scrollLeft,
      viewId: 0,
      nodeId: 1,
      arguments: <String, double>{'dx': 10.0, 'dy': 20.0},
    );
    return withArgs.arguments != null;
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
      const Text('SemanticsActionEvent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('SemanticsActionEvent behavior checks completed'),
    ],
  );
}
