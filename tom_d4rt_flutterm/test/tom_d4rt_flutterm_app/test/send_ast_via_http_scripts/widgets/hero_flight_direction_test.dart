// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests HeroFlightDirection from widgets
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

  print('HeroFlightDirection test executing');
  print('=' * 50);

  runCase('push value exists', () {
    return HeroFlightDirection.push.index == 0;
  });

  runCase('pop value exists', () {
    return HeroFlightDirection.pop.index == 1;
  });

  runCase('values has 2 entries', () {
    return HeroFlightDirection.values.length == 2;
  });

  runCase('push name is correct', () {
    return HeroFlightDirection.push.name == 'push';
  });

  runCase('pop name is correct', () {
    return HeroFlightDirection.pop.name == 'pop';
  });

  runCase('push and pop are different', () {
    return HeroFlightDirection.push != HeroFlightDirection.pop;
  });

  runCase('toString contains enum name', () {
    return HeroFlightDirection.push.toString().contains('push');
  });

  runCase('values contains both entries', () {
    return HeroFlightDirection.values.contains(HeroFlightDirection.push) &&
        HeroFlightDirection.values.contains(HeroFlightDirection.pop);
  });

  runCase('can be used in switch', () {
    String result = '';
    switch (HeroFlightDirection.push) {
      case HeroFlightDirection.push:
        result = 'pushing';
      case HeroFlightDirection.pop:
        result = 'popping';
    }
    return result == 'pushing';
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
      const Text('HeroFlightDirection Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('HeroFlightDirection behavior checks completed'),
    ],
  );
}
