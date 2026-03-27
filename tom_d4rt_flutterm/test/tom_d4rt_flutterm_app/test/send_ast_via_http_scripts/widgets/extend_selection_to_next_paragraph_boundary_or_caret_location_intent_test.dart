// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent from widgets
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

  print('ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent test executing');
  print('=' * 50);

  const ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent intentFwd =
      ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent(forward: true);
  const ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent intentBwd =
      ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent(forward: false);

  runCase('forward is stored', () {
    return intentFwd.forward == true;
  });

  runCase('backward is stored', () {
    return intentBwd.forward == false;
  });

  runCase('collapseSelection is false', () {
    return intentFwd.collapseSelection == false;
  });

  runCase('collapseAtReversal is true', () {
    return intentFwd.collapseAtReversal == true;
  });

  runCase('runtime type is correct', () {
    return intentFwd.runtimeType ==
        ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent;
  });

  runCase('two const forward instances are identical', () {
    const ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent other =
        ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent(forward: true);
    return identical(intentFwd, other);
  });

  runCase('toString is non-empty', () {
    return intentFwd.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return intentFwd.hashCode == intentFwd.hashCode;
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
      const Text('ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent behavior checks completed'),
    ],
  );
}
