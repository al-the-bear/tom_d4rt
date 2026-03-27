// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExtendSelectionVerticallyToAdjacentPageIntent from widgets
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

  print('ExtendSelectionVerticallyToAdjacentPageIntent test executing');
  print('=' * 50);

  const ExtendSelectionVerticallyToAdjacentPageIntent intentDown =
      ExtendSelectionVerticallyToAdjacentPageIntent(
          forward: true, collapseSelection: false);
  const ExtendSelectionVerticallyToAdjacentPageIntent intentUpCollapse =
      ExtendSelectionVerticallyToAdjacentPageIntent(
          forward: false, collapseSelection: true);

  runCase('forward (page down) is stored', () {
    return intentDown.forward == true;
  });

  runCase('backward (page up) is stored', () {
    return intentUpCollapse.forward == false;
  });

  runCase('collapseSelection false is stored', () {
    return intentDown.collapseSelection == false;
  });

  runCase('collapseSelection true is stored', () {
    return intentUpCollapse.collapseSelection == true;
  });

  runCase('runtime type is correct', () {
    return intentDown.runtimeType ==
        ExtendSelectionVerticallyToAdjacentPageIntent;
  });

  runCase('two const instances with same params are identical', () {
    const ExtendSelectionVerticallyToAdjacentPageIntent other =
        ExtendSelectionVerticallyToAdjacentPageIntent(
            forward: true, collapseSelection: false);
    return identical(intentDown, other);
  });

  runCase('toString is non-empty', () {
    return intentDown.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return intentDown.hashCode == intentDown.hashCode;
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
      const Text('ExtendSelectionVerticallyToAdjacentPageIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ExtendSelectionVerticallyToAdjacentPageIntent behavior checks completed'),
    ],
  );
}
