// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FloatingHeaderSnapMode from widgets
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

  print('FloatingHeaderSnapMode test executing');
  print('=' * 50);

  runCase('overlay value exists', () {
    return FloatingHeaderSnapMode.overlay.index == 0;
  });

  runCase('scroll value exists', () {
    return FloatingHeaderSnapMode.scroll.index == 1;
  });

  runCase('values has 2 entries', () {
    return FloatingHeaderSnapMode.values.length == 2;
  });

  runCase('overlay name is correct', () {
    return FloatingHeaderSnapMode.overlay.name == 'overlay';
  });

  runCase('scroll name is correct', () {
    return FloatingHeaderSnapMode.scroll.name == 'scroll';
  });

  runCase('overlay and scroll are different', () {
    return FloatingHeaderSnapMode.overlay != FloatingHeaderSnapMode.scroll;
  });

  runCase('toString contains enum name', () {
    return FloatingHeaderSnapMode.overlay.toString().contains('overlay');
  });

  runCase('values contains overlay', () {
    return FloatingHeaderSnapMode.values.contains(FloatingHeaderSnapMode.overlay);
  });

  runCase('values contains scroll', () {
    return FloatingHeaderSnapMode.values.contains(FloatingHeaderSnapMode.scroll);
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
      const Text('FloatingHeaderSnapMode Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FloatingHeaderSnapMode behavior checks completed'),
    ],
  );
}
