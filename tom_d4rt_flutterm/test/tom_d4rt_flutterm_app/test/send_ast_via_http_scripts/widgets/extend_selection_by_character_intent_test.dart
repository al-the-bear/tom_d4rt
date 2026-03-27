// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExtendSelectionByCharacterIntent from widgets
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

  print('ExtendSelectionByCharacterIntent test executing');
  print('=' * 50);

  const ExtendSelectionByCharacterIntent intentForward =
      ExtendSelectionByCharacterIntent(forward: true, collapseSelection: false);
  const ExtendSelectionByCharacterIntent intentBackward =
      ExtendSelectionByCharacterIntent(forward: false, collapseSelection: true);

  runCase('forward is stored', () {
    return intentForward.forward == true;
  });

  runCase('backward is stored', () {
    return intentBackward.forward == false;
  });

  runCase('collapseSelection false is stored', () {
    return intentForward.collapseSelection == false;
  });

  runCase('collapseSelection true is stored', () {
    return intentBackward.collapseSelection == true;
  });

  runCase('runtime type is correct', () {
    return intentForward.runtimeType == ExtendSelectionByCharacterIntent;
  });

  runCase('two const instances with same params are identical', () {
    const ExtendSelectionByCharacterIntent other =
        ExtendSelectionByCharacterIntent(forward: true, collapseSelection: false);
    return identical(intentForward, other);
  });

  runCase('toString is non-empty', () {
    return intentForward.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return intentForward.hashCode == intentForward.hashCode;
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
      const Text('ExtendSelectionByCharacterIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ExtendSelectionByCharacterIntent behavior checks completed'),
    ],
  );
}
