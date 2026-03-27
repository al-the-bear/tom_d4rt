// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RangeValues from material
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

  print('RangeValues test executing');
  print('=' * 50);

  // RangeValues - pair of start and end double values
  runCase('RangeValues can be constructed', () {
    final values = RangeValues(0.2, 0.8);
    print('  Created: $values');
    return values.start == 0.2 && values.end == 0.8;
  });

  runCase('start property is accessible', () {
    final values = RangeValues(0.0, 1.0);
    print('  start: ${values.start}');
    return values.start == 0.0;
  });

  runCase('end property is accessible', () {
    final values = RangeValues(0.0, 1.0);
    print('  end: ${values.end}');
    return values.end == 1.0;
  });

  runCase('equality works for same values', () {
    final v1 = RangeValues(0.3, 0.7);
    final v2 = RangeValues(0.3, 0.7);
    return v1 == v2;
  });

  runCase('inequality for different start', () {
    final v1 = RangeValues(0.3, 0.7);
    final v2 = RangeValues(0.4, 0.7);
    return v1 != v2;
  });

  runCase('inequality for different end', () {
    final v1 = RangeValues(0.3, 0.7);
    final v2 = RangeValues(0.3, 0.8);
    return v1 != v2;
  });

  runCase('hashCode is consistent', () {
    final v1 = RangeValues(0.5, 0.9);
    final v2 = RangeValues(0.5, 0.9);
    return v1.hashCode == v2.hashCode;
  });

  runCase('toString shows both values', () {
    final values = RangeValues(0.25, 0.75);
    final str = values.toString();
    print('  toString: $str');
    return str.contains('0.25') && str.contains('0.75');
  });

  runCase('zero values work', () {
    final values = RangeValues(0.0, 0.0);
    return values.start == 0.0 && values.end == 0.0;
  });

  runCase('full range values work', () {
    final values = RangeValues(0.0, 1.0);
    return values.start == 0.0 && values.end == 1.0;
  });

  runCase('negative values are supported', () {
    final values = RangeValues(-0.5, 0.5);
    return values.start == -0.5 && values.end == 0.5;
  });

  runCase('runtimeType is RangeValues', () {
    final values = RangeValues(0.1, 0.9);
    print('  runtimeType: ${values.runtimeType}');
    return values.runtimeType.toString().contains('RangeValues');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('RangeValues Test'),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      if (failed.isNotEmpty) Text('Failures: ${failed.join(', ')}'),
    ],
  );
}
