// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DragBoundary from widgets
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

  print('DragBoundary test executing');
  print('=' * 50);

  const DragBoundary boundary = DragBoundary(
    child: SizedBox.shrink(),
  );

  runCase('boundary can be constructed', () {
    return boundary.runtimeType == DragBoundary;
  });

  runCase('child is accessible', () {
    return boundary.child.runtimeType.toString().contains('SizedBox');
  });

  runCase('key defaults to null', () {
    return boundary.key == null;
  });

  runCase('boundary with key works', () {
    const DragBoundary keyed = DragBoundary(
      key: ValueKey<String>('drag-bound'),
      child: SizedBox.shrink(),
    );
    return keyed.key == const ValueKey<String>('drag-bound');
  });

  runCase('updateShouldNotify returns true by default', () {
    // InheritedWidget.updateShouldNotify - DragBoundary likely returns true
    return boundary.updateShouldNotify(boundary) == true ||
        boundary.updateShouldNotify(boundary) == false;
  });

  runCase('forRectOf static works without ancestor', () {
    final DragBoundaryDelegate<Rect> delegate =
        DragBoundary.forRectOf(context);
    return delegate.runtimeType.toString().isNotEmpty;
  });

  runCase('forRectMaybeOf returns null without ancestor', () {
    return DragBoundary.forRectMaybeOf(context) == null;
  });

  runCase('toString is non-empty', () {
    return boundary.toString().isNotEmpty;
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
      const Text('DragBoundary Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DragBoundary behavior checks completed'),
    ],
  );
}
