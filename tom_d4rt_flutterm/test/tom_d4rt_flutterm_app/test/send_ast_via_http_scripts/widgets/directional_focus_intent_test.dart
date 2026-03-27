// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DirectionalFocusIntent from widgets
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

  print('DirectionalFocusIntent test executing');
  print('=' * 50);

  const DirectionalFocusIntent down =
      DirectionalFocusIntent(TraversalDirection.down);
  const DirectionalFocusIntent up =
      DirectionalFocusIntent(TraversalDirection.up, ignoreTextFields: false);

  runCase('direction is stored', () {
    return down.direction == TraversalDirection.down;
  });

  runCase('ignoreTextFields defaults to true', () {
    return down.ignoreTextFields == true;
  });

  runCase('ignoreTextFields can be set to false', () {
    return up.ignoreTextFields == false;
  });

  runCase('different directions are not equal', () {
    return down != up;
  });

  runCase('left direction works', () {
    const DirectionalFocusIntent left =
        DirectionalFocusIntent(TraversalDirection.left);
    return left.direction == TraversalDirection.left;
  });

  runCase('right direction works', () {
    const DirectionalFocusIntent right =
        DirectionalFocusIntent(TraversalDirection.right);
    return right.direction == TraversalDirection.right;
  });

  runCase('runtime type is correct', () {
    return down.runtimeType.toString().contains('DirectionalFocusIntent');
  });

  runCase('toString is non-empty', () {
    return down.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return down.hashCode == down.hashCode;
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
      const Text('DirectionalFocusIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DirectionalFocusIntent behavior checks completed'),
    ],
  );
}
