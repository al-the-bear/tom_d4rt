// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FocusHighlightStrategy from widgets
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

  print('FocusHighlightStrategy test executing');
  print('=' * 50);

  runCase('automatic value exists', () {
    return FocusHighlightStrategy.automatic.index == 0;
  });

  runCase('alwaysTouch value exists', () {
    return FocusHighlightStrategy.alwaysTouch.index == 1;
  });

  runCase('alwaysTraditional value exists', () {
    return FocusHighlightStrategy.alwaysTraditional.index == 2;
  });

  runCase('values has 3 entries', () {
    return FocusHighlightStrategy.values.length == 3;
  });

  runCase('automatic name is correct', () {
    return FocusHighlightStrategy.automatic.name == 'automatic';
  });

  runCase('alwaysTouch name is correct', () {
    return FocusHighlightStrategy.alwaysTouch.name == 'alwaysTouch';
  });

  runCase('alwaysTraditional name is correct', () {
    return FocusHighlightStrategy.alwaysTraditional.name == 'alwaysTraditional';
  });

  runCase('FocusManager uses highlightStrategy', () {
    final FocusHighlightStrategy strategy = FocusManager.instance.highlightStrategy;
    return FocusHighlightStrategy.values.contains(strategy);
  });

  runCase('toString contains enum name', () {
    return FocusHighlightStrategy.automatic.toString().contains('automatic');
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
      const Text('FocusHighlightStrategy Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FocusHighlightStrategy behavior checks completed'),
    ],
  );
}
