// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeLabels from material
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

  print('RangeLabels test executing');
  print('=' * 50);

  // RangeLabels - pair of start and end label strings
  runCase('RangeLabels can be constructed', () {
    final labels = RangeLabels('Start', 'End');
    print('  Created: $labels');
    return labels.start == 'Start' && labels.end == 'End';
  });

  runCase('start property is accessible', () {
    final labels = RangeLabels('Min', 'Max');
    print('  start: ${labels.start}');
    return labels.start == 'Min';
  });

  runCase('end property is accessible', () {
    final labels = RangeLabels('Min', 'Max');
    print('  end: ${labels.end}');
    return labels.end == 'Max';
  });

  runCase('equality works for same values', () {
    final labels1 = RangeLabels('A', 'B');
    final labels2 = RangeLabels('A', 'B');
    return labels1 == labels2;
  });

  runCase('inequality for different values', () {
    final labels1 = RangeLabels('A', 'B');
    final labels2 = RangeLabels('A', 'C');
    return labels1 != labels2;
  });

  runCase('hashCode is consistent', () {
    final labels1 = RangeLabels('X', 'Y');
    final labels2 = RangeLabels('X', 'Y');
    return labels1.hashCode == labels2.hashCode;
  });

  runCase('toString shows both labels', () {
    final labels = RangeLabels('Low', 'High');
    final str = labels.toString();
    print('  toString: $str');
    return str.contains('Low') && str.contains('High');
  });

  runCase('empty strings are valid', () {
    final labels = RangeLabels('', '');
    return labels.start == '' && labels.end == '';
  });

  runCase('numeric labels work', () {
    final labels = RangeLabels('0', '100');
    return labels.start == '0' && labels.end == '100';
  });

  runCase('runtimeType is RangeLabels', () {
    final labels = RangeLabels('a', 'b');
    print('  runtimeType: ${labels.runtimeType}');
    return labels.runtimeType.toString().contains('RangeLabels');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('RangeLabels Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
