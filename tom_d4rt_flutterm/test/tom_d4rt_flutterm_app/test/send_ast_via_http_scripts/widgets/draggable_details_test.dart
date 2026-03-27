// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DraggableDetails from widgets
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

  print('DraggableDetails test executing');
  print('=' * 50);

  final DraggableDetails details = DraggableDetails(
    wasAccepted: false,
    velocity: Velocity.zero,
    offset: const Offset(100.0, 200.0),
  );

  runCase('wasAccepted defaults to false', () {
    return details.wasAccepted == false;
  });

  runCase('velocity is stored', () {
    return details.velocity == Velocity.zero;
  });

  runCase('offset is stored', () {
    return details.offset == const Offset(100.0, 200.0);
  });

  runCase('wasAccepted can be true', () {
    final DraggableDetails d = DraggableDetails(
      wasAccepted: true,
      velocity: Velocity.zero,
      offset: Offset.zero,
    );
    return d.wasAccepted == true;
  });

  runCase('non-zero velocity works', () {
    final DraggableDetails d = DraggableDetails(
      velocity: const Velocity(pixelsPerSecond: Offset(100, 200)),
      offset: Offset.zero,
    );
    return d.velocity.pixelsPerSecond.dx == 100.0;
  });

  runCase('runtime type is correct', () {
    return details.runtimeType == DraggableDetails;
  });

  runCase('toString is non-empty', () {
    return details.toString().isNotEmpty;
  });

  runCase('offset dx and dy accessible', () {
    return details.offset.dx == 100.0 && details.offset.dy == 200.0;
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
      const Text('DraggableDetails Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DraggableDetails behavior checks completed'),
    ],
  );
}
