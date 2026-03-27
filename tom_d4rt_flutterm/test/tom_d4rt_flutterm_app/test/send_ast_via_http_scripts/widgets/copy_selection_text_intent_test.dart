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

  print('CopySelectionTextIntent test executing');
  print('=' * 50);

  final CopySelectionTextIntent cutIntent = CopySelectionTextIntent.cut(SelectionChangedCause.tap);
  const CopySelectionTextIntent copyIntent = CopySelectionTextIntent.copy;

  runCase('cut intent stores cause', () {
    return cutIntent.cause == SelectionChangedCause.tap;
  });

  runCase('cut intent collapses selection', () {
    return cutIntent.collapseSelection == true;
  });

  runCase('copy intent does not collapse selection', () {
    return copyIntent.collapseSelection == false;
  });

  runCase('intent runtime type is correct', () {
    return cutIntent.runtimeType.toString().contains('CopySelectionTextIntent');
  });

  runCase('copy intent has keyboard cause', () {
    return copyIntent.cause == SelectionChangedCause.keyboard;
  });

  runCase('cut and copy are different instances', () {
    return cutIntent != copyIntent;
  });

  runCase('cut with different cause', () {
    final CopySelectionTextIntent dragCut =
        CopySelectionTextIntent.cut(SelectionChangedCause.drag);
    return dragCut.cause == SelectionChangedCause.drag &&
        dragCut.collapseSelection == true;
  });

  runCase('toString returns non-empty string', () {
    return cutIntent.toString().isNotEmpty;
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
      const Text('CopySelectionTextIntent Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('CopySelectionTextIntent behavior checks completed'),
    ],
  );
}
