// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeyEventType from dart_ui
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

  print('KeyEventType test executing');
  print('=' * 50);

  runCase('down value exists', () {
    return ui.KeyEventType.down.index == 0;
  });

  runCase('up value exists', () {
    return ui.KeyEventType.up.index == 1;
  });

  runCase('repeat value exists', () {
    return ui.KeyEventType.repeat.index == 2;
  });

  runCase('values has 3 entries', () {
    return ui.KeyEventType.values.length == 3;
  });

  runCase('down label is Key Down', () {
    return ui.KeyEventType.down.label == 'Key Down';
  });

  runCase('up label is Key Up', () {
    return ui.KeyEventType.up.label == 'Key Up';
  });

  runCase('repeat label is Key Repeat', () {
    return ui.KeyEventType.repeat.label == 'Key Repeat';
  });

  runCase('toString contains enum name', () {
    return ui.KeyEventType.down.toString().contains('down');
  });

  runCase('down and up are different', () {
    return ui.KeyEventType.down != ui.KeyEventType.up;
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
      const Text('KeyEventType Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('KeyEventType behavior checks completed'),
    ],
  );
}
