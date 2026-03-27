// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DragBoundaryDelegate from widgets
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

  print('DragBoundaryDelegate test executing');
  print('=' * 50);

  // DragBoundaryDelegate<T> is abstract; test via DragBoundary.forRectOf
  // which returns a DragBoundaryDelegate<Rect>

  runCase('DragBoundary.forRectOf returns a delegate without ancestor', () {
    // When no DragBoundary ancestor, returns a free-movement delegate
    final DragBoundaryDelegate<Rect> delegate =
        DragBoundary.forRectOf(context);
    return delegate.runtimeType.toString().isNotEmpty;
  });

  runCase('free delegate isWithinBoundary is true for any rect', () {
    final DragBoundaryDelegate<Rect> delegate =
        DragBoundary.forRectOf(context);
    return delegate.isWithinBoundary(const Rect.fromLTWH(0, 0, 100, 100));
  });

  runCase('free delegate nearestPosition returns same rect', () {
    final DragBoundaryDelegate<Rect> delegate =
        DragBoundary.forRectOf(context);
    const Rect r = Rect.fromLTWH(50, 50, 200, 200);
    return delegate.nearestPositionWithinBoundary(r) == r;
  });

  runCase('forRectMaybeOf returns null without ancestor', () {
    final DragBoundaryDelegate<Rect>? maybe =
        DragBoundary.forRectMaybeOf(context);
    return maybe == null;
  });

  runCase('delegate type name is non-empty', () {
    final DragBoundaryDelegate<Rect> delegate =
        DragBoundary.forRectOf(context);
    return delegate.toString().isNotEmpty;
  });

  runCase('delegate handles large rect', () {
    final DragBoundaryDelegate<Rect> delegate =
        DragBoundary.forRectOf(context);
    const Rect large = Rect.fromLTWH(-1000, -1000, 5000, 5000);
    return delegate.isWithinBoundary(large);
  });

  runCase('delegate handles zero-size rect', () {
    final DragBoundaryDelegate<Rect> delegate =
        DragBoundary.forRectOf(context);
    return delegate.isWithinBoundary(Rect.zero);
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
      const Text('DragBoundaryDelegate Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DragBoundaryDelegate behavior checks completed'),
    ],
  );
}
