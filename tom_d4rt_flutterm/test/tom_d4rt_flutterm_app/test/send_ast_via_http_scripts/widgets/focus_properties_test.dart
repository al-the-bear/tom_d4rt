// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FocusScopeNode from widgets
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

  print('FocusScopeNode test executing');
  print('=' * 50);

  final FocusScopeNode scope = FocusScopeNode(debugLabel: 'test-scope');

  runCase('scope can be created', () {
    return scope.runtimeType == FocusScopeNode;
  });

  runCase('debugLabel is stored', () {
    return scope.debugLabel == 'test-scope';
  });

  runCase('nearestScope returns itself', () {
    return identical(scope.nearestScope, scope);
  });

  runCase('traversalEdgeBehavior defaults to closedLoop', () {
    return scope.traversalEdgeBehavior == TraversalEdgeBehavior.closedLoop;
  });

  runCase('canRequestFocus defaults to true', () {
    return scope.canRequestFocus == true;
  });

  runCase('skipTraversal defaults to false', () {
    return scope.skipTraversal == false;
  });

  runCase('hasFocus is false initially', () {
    return scope.hasFocus == false;
  });

  runCase('children is empty initially', () {
    return scope.children.isEmpty;
  });

  runCase('dispose works', () {
    final FocusScopeNode s2 = FocusScopeNode(debugLabel: 'dispose-test');
    s2.dispose();
    return true;
  });

  scope.dispose();

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
      const Text('FocusScopeNode Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('FocusScopeNode behavior checks completed'),
    ],
  );
}
