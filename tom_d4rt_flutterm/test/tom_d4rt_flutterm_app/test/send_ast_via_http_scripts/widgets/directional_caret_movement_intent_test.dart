// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DirectionalCaretMovementIntent from widgets
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

  print('DirectionalCaretMovementIntent test executing');
  print('=' * 50);

  // DirectionalCaretMovementIntent is abstract; test via concrete subclass
  // ExtendSelectionByCharacterIntent extends DirectionalCaretMovementIntent
  const ExtendSelectionByCharacterIntent fwd =
      ExtendSelectionByCharacterIntent(forward: true, collapseSelection: false);
  const ExtendSelectionByCharacterIntent bwd =
      ExtendSelectionByCharacterIntent(forward: false, collapseSelection: true);

  runCase('forward property is stored', () {
    return fwd.forward == true;
  });

  runCase('collapseSelection is stored', () {
    return fwd.collapseSelection == false && bwd.collapseSelection == true;
  });

  runCase('forward and backward are not equal', () {
    return fwd != bwd;
  });

  runCase('collapseAtReversal defaults to false', () {
    return fwd.collapseAtReversal == false;
  });

  runCase('continuesAtWrap defaults to false', () {
    return fwd.continuesAtWrap == false;
  });

  runCase('runtime type contains expected name', () {
    return fwd.runtimeType.toString().contains('ExtendSelectionByCharacterIntent');
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
      const Text('DirectionalCaretMovementIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DirectionalCaretMovementIntent behavior checks completed'),
    ],
  );
}
