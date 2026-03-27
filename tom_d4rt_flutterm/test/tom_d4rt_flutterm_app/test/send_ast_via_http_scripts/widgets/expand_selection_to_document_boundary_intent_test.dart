// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ExpandSelectionToDocumentBoundaryIntent from widgets
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

  print('ExpandSelectionToDocumentBoundaryIntent test executing');
  print('=' * 50);

  const ExpandSelectionToDocumentBoundaryIntent intentForward =
      ExpandSelectionToDocumentBoundaryIntent(forward: true);
  const ExpandSelectionToDocumentBoundaryIntent intentBackward =
      ExpandSelectionToDocumentBoundaryIntent(forward: false);

  runCase('forward intent stores forward true', () {
    return intentForward.forward == true;
  });

  runCase('backward intent stores forward false', () {
    return intentBackward.forward == false;
  });

  runCase('collapseSelection is false', () {
    return intentForward.collapseSelection == false;
  });

  runCase('runtime type is correct', () {
    return intentForward.runtimeType == ExpandSelectionToDocumentBoundaryIntent;
  });

  runCase('two const forward instances are identical', () {
    const ExpandSelectionToDocumentBoundaryIntent other =
        ExpandSelectionToDocumentBoundaryIntent(forward: true);
    return identical(intentForward, other);
  });

  runCase('forward and backward are different', () {
    return intentForward.forward != intentBackward.forward;
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
      const Text('ExpandSelectionToDocumentBoundaryIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ExpandSelectionToDocumentBoundaryIntent behavior checks completed'),
    ],
  );
}
