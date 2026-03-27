// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DeleteToNextWordBoundaryIntent from widgets
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

  print('DeleteToNextWordBoundaryIntent test executing');
  print('=' * 50);

  const DeleteToNextWordBoundaryIntent fwd =
      DeleteToNextWordBoundaryIntent(forward: true);
  const DeleteToNextWordBoundaryIntent bwd =
      DeleteToNextWordBoundaryIntent(forward: false);

  runCase('forward intent stores forward=true', () {
    return fwd.forward == true;
  });

  runCase('backward intent stores forward=false', () {
    return bwd.forward == false;
  });

  runCase('forward and backward are not equal', () {
    return fwd != bwd;
  });

  runCase('same direction produces equal intents', () {
    const DeleteToNextWordBoundaryIntent same =
        DeleteToNextWordBoundaryIntent(forward: true);
    return same == fwd;
  });

  runCase('runtime type contains class name', () {
    return fwd.runtimeType.toString().contains('DeleteToNextWordBoundaryIntent');
  });

  runCase('toString returns non-empty string', () {
    return fwd.toString().isNotEmpty;
  });

  runCase('both share the same runtime type', () {
    return fwd.runtimeType == bwd.runtimeType;
  });

  runCase('hashCode is consistent', () {
    return fwd.hashCode == fwd.hashCode;
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
      const Text('DeleteToNextWordBoundaryIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DeleteToNextWordBoundaryIntent behavior checks completed'),
    ],
  );
}
