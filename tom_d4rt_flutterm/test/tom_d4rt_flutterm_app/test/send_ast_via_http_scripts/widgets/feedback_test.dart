// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Feedback from widgets
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

  print('Feedback test executing');
  print('=' * 50);

  // Feedback is abstract final; test via static methods

  runCase('Feedback.forTap returns a Future', () {
    final Future<void> result = Feedback.forTap(context);
    return result.runtimeType.toString().contains('Future');
  });

  runCase('Feedback.wrapForTap returns null for null callback', () {
    return Feedback.wrapForTap(null, context) == null;
  });

  runCase('Feedback.wrapForTap returns non-null for non-null callback', () {
    final GestureTapCallback? wrapped = Feedback.wrapForTap(() {}, context);
    return wrapped != null;
  });

  runCase('wrapForTap wraps callback and preserves it', () {
    bool called = false;
    final GestureTapCallback? wrapped = Feedback.wrapForTap(() {
      called = true;
    }, context);
    wrapped!();
    return called == true;
  });

  runCase('Feedback.forLongPress returns a Future', () {
    final Future<void> result = Feedback.forLongPress(context);
    return result.runtimeType.toString().contains('Future');
  });

  runCase('Feedback.wrapForLongPress returns null for null callback', () {
    return Feedback.wrapForLongPress(null, context) == null;
  });

  runCase('Feedback.wrapForLongPress returns non-null for valid callback', () {
    final GestureLongPressCallback? wrapped = Feedback.wrapForLongPress(() {}, context);
    return wrapped != null;
  });

  runCase('wrapForLongPress wraps callback correctly', () {
    bool called = false;
    final GestureLongPressCallback? wrapped = Feedback.wrapForLongPress(() {
      called = true;
    }, context);
    wrapped!();
    return called == true;
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
      const Text('Feedback Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Feedback behavior checks completed'),
    ],
  );
}
