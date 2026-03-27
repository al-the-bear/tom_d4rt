// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DirectionalTextEditingIntent from widgets
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

  print('DirectionalTextEditingIntent test executing');
  print('=' * 50);

  // DirectionalTextEditingIntent is abstract; test via concrete subclass
  const DeleteToNextWordBoundaryIntent fwd =
      DeleteToNextWordBoundaryIntent(forward: true);
  const DeleteToNextWordBoundaryIntent bwd =
      DeleteToNextWordBoundaryIntent(forward: false);

  runCase('forward flag is accessible on subclass', () {
    return fwd.forward == true;
  });

  runCase('backward flag is accessible on subclass', () {
    return bwd.forward == false;
  });

  runCase('forward and backward differ', () {
    return fwd != bwd;
  });

  runCase('same direction produces equal intents', () {
    const DeleteToNextWordBoundaryIntent same =
        DeleteToNextWordBoundaryIntent(forward: true);
    return same == fwd;
  });

  runCase('DeleteToLineBreakIntent is also a subclass', () {
    const DeleteToLineBreakIntent dlb = DeleteToLineBreakIntent(forward: true);
    return dlb.forward == true;
  });

  runCase('different subclasses are not equal', () {
    const DeleteToLineBreakIntent dlb = DeleteToLineBreakIntent(forward: true);
    // ignore: unrelated_type_equality_checks
    return fwd.runtimeType != dlb.runtimeType;
  });

  runCase('runtime type of fwd is correct', () {
    return fwd.runtimeType.toString().contains('DeleteToNextWordBoundaryIntent');
  });

  runCase('toString is non-empty', () {
    return fwd.toString().isNotEmpty;
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
      const Text('DirectionalTextEditingIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DirectionalTextEditingIntent behavior checks completed'),
    ],
  );
}
