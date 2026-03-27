// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FocusHighlightMode from widgets
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

  print('FocusHighlightMode test executing');
  print('=' * 50);

  runCase('touch value exists', () {
    return FocusHighlightMode.touch.index == 0;
  });

  runCase('traditional value exists', () {
    return FocusHighlightMode.traditional.index == 1;
  });

  runCase('values has 2 entries', () {
    return FocusHighlightMode.values.length == 2;
  });

  runCase('touch name is correct', () {
    return FocusHighlightMode.touch.name == 'touch';
  });

  runCase('traditional name is correct', () {
    return FocusHighlightMode.traditional.name == 'traditional';
  });

  runCase('touch and traditional are different', () {
    return FocusHighlightMode.touch != FocusHighlightMode.traditional;
  });

  runCase('toString contains enum name', () {
    return FocusHighlightMode.touch.toString().contains('touch');
  });

  runCase('values contains both entries', () {
    return FocusHighlightMode.values.contains(FocusHighlightMode.touch) &&
        FocusHighlightMode.values.contains(FocusHighlightMode.traditional);
  });

  runCase('FocusManager has highlightMode getter', () {
    final FocusHighlightMode mode = FocusManager.instance.highlightMode;
    return mode == FocusHighlightMode.touch ||
        mode == FocusHighlightMode.traditional;
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
      const Text('FocusHighlightMode Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FocusHighlightMode behavior checks completed'),
    ],
  );
}
