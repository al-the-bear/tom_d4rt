// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DraggableScrollableNotification from widgets
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

  print('DraggableScrollableNotification test executing');
  print('=' * 50);

  final DraggableScrollableNotification notification =
      DraggableScrollableNotification(
    extent: 0.5,
    minExtent: 0.25,
    maxExtent: 1.0,
    initialExtent: 0.5,
    context: context,
  );

  runCase('extent is stored', () {
    return notification.extent == 0.5;
  });

  runCase('minExtent is stored', () {
    return notification.minExtent == 0.25;
  });

  runCase('maxExtent is stored', () {
    return notification.maxExtent == 1.0;
  });

  runCase('initialExtent is stored', () {
    return notification.initialExtent == 0.5;
  });

  runCase('shouldCloseOnMinExtent defaults to true', () {
    return notification.shouldCloseOnMinExtent == true;
  });

  runCase('shouldCloseOnMinExtent can be false', () {
    final DraggableScrollableNotification n =
        DraggableScrollableNotification(
      extent: 0.5,
      minExtent: 0.0,
      maxExtent: 1.0,
      initialExtent: 0.5,
      context: context,
      shouldCloseOnMinExtent: false,
    );
    return n.shouldCloseOnMinExtent == false;
  });

  runCase('runtime type is correct', () {
    return notification.runtimeType == DraggableScrollableNotification;
  });

  runCase('toString is non-empty', () {
    return notification.toString().isNotEmpty;
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
      const Text('DraggableScrollableNotification Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DraggableScrollableNotification behavior checks completed'),
    ],
  );
}
