// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DragTargetDetails from widgets
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

  print('DragTargetDetails test executing');
  print('=' * 50);

  final DragTargetDetails<String> details = DragTargetDetails<String>(
    data: 'hello',
    offset: const Offset(100.0, 200.0),
  );

  runCase('data is stored correctly', () {
    return details.data == 'hello';
  });

  runCase('offset is stored correctly', () {
    return details.offset == const Offset(100.0, 200.0);
  });

  runCase('runtime type is correct', () {
    return details.runtimeType.toString().contains('DragTargetDetails');
  });

  runCase('integer data type works', () {
    final DragTargetDetails<int> intDetails = DragTargetDetails<int>(
      data: 42,
      offset: Offset.zero,
    );
    return intDetails.data == 42;
  });

  runCase('offset dx and dy are accessible', () {
    return details.offset.dx == 100.0 && details.offset.dy == 200.0;
  });

  runCase('zero offset works', () {
    final DragTargetDetails<String> d = DragTargetDetails<String>(
      data: 'test',
      offset: Offset.zero,
    );
    return d.offset == Offset.zero;
  });

  runCase('toString is non-empty', () {
    return details.toString().isNotEmpty;
  });

  runCase('negative offsets work', () {
    final DragTargetDetails<String> d = DragTargetDetails<String>(
      data: 'neg',
      offset: const Offset(-50.0, -100.0),
    );
    return d.offset.dx == -50.0 && d.offset.dy == -100.0;
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
      const Text('DragTargetDetails Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DragTargetDetails behavior checks completed'),
    ],
  );
}
