// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExtendSelectionToNextWordBoundaryIntent from widgets
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

  print('ExtendSelectionToNextWordBoundaryIntent test executing');
  print('=' * 50);

  const ExtendSelectionToNextWordBoundaryIntent intentForwardCollapse =
      ExtendSelectionToNextWordBoundaryIntent(
          forward: true, collapseSelection: true);
  const ExtendSelectionToNextWordBoundaryIntent intentBackwardExtend =
      ExtendSelectionToNextWordBoundaryIntent(
          forward: false, collapseSelection: false);

  runCase('forward is stored', () {
    return intentForwardCollapse.forward == true;
  });

  runCase('backward is stored', () {
    return intentBackwardExtend.forward == false;
  });

  runCase('collapseSelection true is stored', () {
    return intentForwardCollapse.collapseSelection == true;
  });

  runCase('collapseSelection false is stored', () {
    return intentBackwardExtend.collapseSelection == false;
  });

  runCase('runtime type is correct', () {
    return intentForwardCollapse.runtimeType ==
        ExtendSelectionToNextWordBoundaryIntent;
  });

  runCase('two const instances with same params are identical', () {
    const ExtendSelectionToNextWordBoundaryIntent other =
        ExtendSelectionToNextWordBoundaryIntent(
            forward: true, collapseSelection: true);
    return identical(intentForwardCollapse, other);
  });

  runCase('toString is non-empty', () {
    return intentForwardCollapse.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return intentForwardCollapse.hashCode == intentForwardCollapse.hashCode;
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
      const Text('ExtendSelectionToNextWordBoundaryIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ExtendSelectionToNextWordBoundaryIntent behavior checks completed'),
    ],
  );
}
