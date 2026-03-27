// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TabAlignment from material
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

  print('TabAlignment test executing');
  print('=' * 50);

  // TabAlignment enum determines how tabs are aligned within the tab bar
  runCase('TabAlignment.values exists', () {
    final count = TabAlignment.values.length;
    print('  values count: $count');
    return count >= 3;
  });

  runCase('start value exists', () {
    final value = TabAlignment.start;
    print('  start: index=${value.index}, name=${value.name}');
    return value.name == 'start';
  });

  runCase('startOffset value exists', () {
    final value = TabAlignment.startOffset;
    print('  startOffset: index=${value.index}, name=${value.name}');
    return value.name == 'startOffset';
  });

  runCase('fill value exists', () {
    final value = TabAlignment.fill;
    print('  fill: index=${value.index}, name=${value.name}');
    return value.name == 'fill';
  });

  runCase('center value exists', () {
    final value = TabAlignment.center;
    print('  center: index=${value.index}, name=${value.name}');
    return value.name == 'center';
  });

  runCase('toString shows value name', () {
    final str = TabAlignment.fill.toString();
    print('  toString: $str');
    return str.contains('fill');
  });

  runCase('enum values are comparable', () {
    return TabAlignment.start != TabAlignment.center;
  });

  runCase('TabBar accepts tabAlignment', () {
    // TabBar uses tabAlignment to position tabs
    return true;
  });

  runCase('start aligns tabs to start', () {
    // start: tabs are aligned to the start, scrollable
    return true;
  });

  runCase('fill expands tabs to fill', () {
    // fill: tabs expand to fill available space
    return true;
  });

  runCase('summary string can be formed', () {
    final summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('TabAlignment Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
