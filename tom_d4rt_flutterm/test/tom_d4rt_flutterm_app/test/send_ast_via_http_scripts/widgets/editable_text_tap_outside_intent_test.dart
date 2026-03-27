// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests EditableTextTapOutsideIntent from widgets
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

  print('EditableTextTapOutsideIntent test executing');
  print('=' * 50);

  final FocusNode focusNode = FocusNode();
  final PointerDownEvent pointerEvent = const PointerDownEvent(
    position: Offset(100.0, 200.0),
  );

  final EditableTextTapOutsideIntent intent = EditableTextTapOutsideIntent(
    focusNode: focusNode,
    pointerDownEvent: pointerEvent,
  );

  runCase('focusNode is stored', () {
    return identical(intent.focusNode, focusNode);
  });

  runCase('pointerDownEvent is stored', () {
    return identical(intent.pointerDownEvent, pointerEvent);
  });

  runCase('runtime type is correct', () {
    return intent.runtimeType == EditableTextTapOutsideIntent;
  });

  runCase('toString is non-empty', () {
    return intent.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return intent.hashCode == intent.hashCode;
  });

  runCase('different instances with different nodes are independent', () {
    final FocusNode node2 = FocusNode();
    final EditableTextTapOutsideIntent i2 = EditableTextTapOutsideIntent(
      focusNode: node2,
      pointerDownEvent: pointerEvent,
    );
    final bool result = !identical(intent, i2);
    node2.dispose();
    return result;
  });

  runCase('pointer event position is accessible', () {
    return intent.pointerDownEvent.position == const Offset(100.0, 200.0);
  });

  // Clean up
  focusNode.dispose();

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
      const Text('EditableTextTapOutsideIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('EditableTextTapOutsideIntent behavior checks completed'),
    ],
  );
}
