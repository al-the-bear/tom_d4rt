// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExtendSelectionVerticallyToAdjacentLineIntent from widgets
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

  print('ExtendSelectionVerticallyToAdjacentLineIntent test executing');
  print('=' * 50);

  const ExtendSelectionVerticallyToAdjacentLineIntent intentDown =
      ExtendSelectionVerticallyToAdjacentLineIntent(
          forward: true, collapseSelection: false);
  const ExtendSelectionVerticallyToAdjacentLineIntent intentUpCollapse =
      ExtendSelectionVerticallyToAdjacentLineIntent(
          forward: false, collapseSelection: true);

  runCase('forward (down) is stored', () {
    return intentDown.forward == true;
  });

  runCase('backward (up) is stored', () {
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
        ExtendSelectionVerticallyToAdjacentLineIntent;
  });

  runCase('two const instances with same params are identical', () {
    const ExtendSelectionVerticallyToAdjacentLineIntent other =
        ExtendSelectionVerticallyToAdjacentLineIntent(
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
      const Text('ExtendSelectionVerticallyToAdjacentLineIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ExtendSelectionVerticallyToAdjacentLineIntent behavior checks completed'),
    ],
  );
}
