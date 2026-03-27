// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests EmptyTextSelectionControls from widgets
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

  print('EmptyTextSelectionControls test executing');
  print('=' * 50);

  final EmptyTextSelectionControls controls = EmptyTextSelectionControls();

  runCase('controls can be created', () {
    return controls.runtimeType == EmptyTextSelectionControls;
  });

  runCase('getHandleSize returns Size.zero', () {
    return controls.getHandleSize(16.0) == Size.zero;
  });

  runCase('getHandleAnchor returns Offset.zero for left handle', () {
    return controls.getHandleAnchor(TextSelectionHandleType.left, 16.0) == Offset.zero;
  });

  runCase('getHandleAnchor returns Offset.zero for right handle', () {
    return controls.getHandleAnchor(TextSelectionHandleType.right, 16.0) == Offset.zero;
  });

  runCase('getHandleAnchor returns Offset.zero for collapsed handle', () {
    return controls.getHandleAnchor(TextSelectionHandleType.collapsed, 16.0) == Offset.zero;
  });

  runCase('buildHandle returns a widget', () {
    final Widget handle = controls.buildHandle(
      context, TextSelectionHandleType.left, 16.0,
    );
    return handle is SizedBox;
  });

  runCase('global emptyTextSelectionControls instance exists', () {
    return emptyTextSelectionControls.runtimeType.toString().isNotEmpty;
  });

  runCase('toString is non-empty', () {
    return controls.toString().isNotEmpty;
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
      const Text('EmptyTextSelectionControls Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('EmptyTextSelectionControls behavior checks completed'),
    ],
  );
}
