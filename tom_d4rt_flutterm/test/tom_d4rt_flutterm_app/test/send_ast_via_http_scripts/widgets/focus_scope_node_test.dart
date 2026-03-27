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

  final FocusScopeNode scope = FocusScopeNode(debugLabel: 'scope-node');

  runCase('scope extends FocusNode', () {
    return scope.runtimeType.toString().contains('FocusScopeNode');
  });

  runCase('debugLabel is set', () {
    return scope.debugLabel == 'scope-node';
  });

  runCase('traversalEdgeBehavior can be changed', () {
    scope.traversalEdgeBehavior = TraversalEdgeBehavior.leaveFlutterView;
    return scope.traversalEdgeBehavior == TraversalEdgeBehavior.leaveFlutterView;
  });

  runCase('directionalTraversalEdgeBehavior defaults to stop', () {
    final FocusScopeNode s2 = FocusScopeNode();
    final bool result = s2.directionalTraversalEdgeBehavior == TraversalEdgeBehavior.stop;
    s2.dispose();
    return result;
  });

  runCase('descendantsAreFocusable is true by default', () {
    return scope.descendantsAreFocusable == true;
  });

  runCase('two scopes are independent', () {
    final FocusScopeNode s2 = FocusScopeNode(debugLabel: 'other');
    final bool result = !identical(scope, s2);
    s2.dispose();
    return result;
  });

  runCase('hasPrimaryFocus is false initially', () {
    return scope.hasPrimaryFocus == false;
  });

  runCase('toString is non-empty', () {
    return scope.toString().isNotEmpty;
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
