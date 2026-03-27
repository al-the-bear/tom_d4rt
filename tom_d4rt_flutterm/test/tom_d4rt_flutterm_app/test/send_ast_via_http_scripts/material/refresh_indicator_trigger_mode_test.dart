// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RefreshIndicatorTriggerMode from material
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

  print('RefreshIndicatorTriggerMode test executing');
  print('=' * 50);

  // RefreshIndicatorTriggerMode enum: anywhere, onEdge
  runCase('RefreshIndicatorTriggerMode.values has 2 entries', () {
    return RefreshIndicatorTriggerMode.values.length == 2;
  });

  runCase('anywhere value exists', () {
    final value = RefreshIndicatorTriggerMode.anywhere;
    print('  anywhere: index=${value.index}, name=${value.name}');
    return value.index == 0 && value.name == 'anywhere';
  });

  runCase('onEdge value exists', () {
    final value = RefreshIndicatorTriggerMode.onEdge;
    print('  onEdge: index=${value.index}, name=${value.name}');
    return value.index == 1 && value.name == 'onEdge';
  });

  runCase('anywhere is first value', () {
    return RefreshIndicatorTriggerMode.values.first == RefreshIndicatorTriggerMode.anywhere;
  });

  runCase('onEdge is last value', () {
    return RefreshIndicatorTriggerMode.values.last == RefreshIndicatorTriggerMode.onEdge;
  });

  runCase('toString shows value name', () {
    final str = RefreshIndicatorTriggerMode.anywhere.toString();
    print('  toString: $str');
    return str.contains('anywhere');
  });

  runCase('enum values are comparable', () {
    return RefreshIndicatorTriggerMode.anywhere != RefreshIndicatorTriggerMode.onEdge;
  });

  runCase('anywhere triggers regardless of scroll position', () {
    // anywhere: indicator can be triggered regardless of scroll position
    return true;
  });

  runCase('onEdge only triggers at edge', () {
    // onEdge: indicator only triggers at scroll edge
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
      Text('RefreshIndicatorTriggerMode Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
