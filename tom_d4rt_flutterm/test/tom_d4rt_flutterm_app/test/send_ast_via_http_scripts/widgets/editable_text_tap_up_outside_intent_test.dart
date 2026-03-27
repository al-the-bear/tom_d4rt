// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests EditableTextTapUpOutsideIntent from widgets
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

  print('EditableTextTapUpOutsideIntent test executing');
  print('=' * 50);

  final FocusNode focusNode = FocusNode();
  final PointerUpEvent pointerEvent = const PointerUpEvent(
    position: Offset(150.0, 250.0),
  );

  final EditableTextTapUpOutsideIntent intent = EditableTextTapUpOutsideIntent(
    focusNode: focusNode,
    pointerUpEvent: pointerEvent,
  );

  runCase('focusNode is stored', () {
    return identical(intent.focusNode, focusNode);
  });

  runCase('pointerUpEvent is stored', () {
    return identical(intent.pointerUpEvent, pointerEvent);
  });

  runCase('runtime type is correct', () {
    return intent.runtimeType == EditableTextTapUpOutsideIntent;
  });

  runCase('toString is non-empty', () {
    return intent.toString().isNotEmpty;
  });

  runCase('hashCode is consistent', () {
    return intent.hashCode == intent.hashCode;
  });

  runCase('different from TapOutside variant', () {
    final EditableTextTapOutsideIntent tapOutside = EditableTextTapOutsideIntent(
      focusNode: focusNode,
      pointerDownEvent: const PointerDownEvent(),
    );
    return intent.runtimeType != tapOutside.runtimeType;
  });

  runCase('pointer event position is accessible', () {
    return intent.pointerUpEvent.position == const Offset(150.0, 250.0);
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
      const Text('EditableTextTapUpOutsideIntent Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('EditableTextTapUpOutsideIntent behavior checks completed'),
    ],
  );
}
