// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DismissUpdateDetails from widgets
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

  print('DismissUpdateDetails test executing');
  print('=' * 50);

  final DismissUpdateDetails details = DismissUpdateDetails();

  runCase('default direction is horizontal', () {
    return details.direction == DismissDirection.horizontal;
  });

  runCase('default reached is false', () {
    return details.reached == false;
  });

  runCase('default previousReached is false', () {
    return details.previousReached == false;
  });

  runCase('default progress is 0.0', () {
    return details.progress == 0.0;
  });

  runCase('custom direction is stored', () {
    final DismissUpdateDetails d = DismissUpdateDetails(
      direction: DismissDirection.vertical,
    );
    return d.direction == DismissDirection.vertical;
  });

  runCase('reached can be set to true', () {
    final DismissUpdateDetails d = DismissUpdateDetails(reached: true);
    return d.reached == true;
  });

  runCase('previousReached can be set to true', () {
    final DismissUpdateDetails d = DismissUpdateDetails(previousReached: true);
    return d.previousReached == true;
  });

  runCase('progress can be set', () {
    final DismissUpdateDetails d = DismissUpdateDetails(progress: 0.75);
    return d.progress == 0.75;
  });

  runCase('runtime type is correct', () {
    return details.runtimeType == DismissUpdateDetails;
  });

  runCase('full custom construction works', () {
    final DismissUpdateDetails d = DismissUpdateDetails(
      direction: DismissDirection.endToStart,
      reached: true,
      previousReached: false,
      progress: 0.5,
    );
    return d.direction == DismissDirection.endToStart &&
        d.reached == true &&
        d.previousReached == false &&
        d.progress == 0.5;
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
      const Text('DismissUpdateDetails Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DismissUpdateDetails behavior checks completed'),
    ],
  );
}
