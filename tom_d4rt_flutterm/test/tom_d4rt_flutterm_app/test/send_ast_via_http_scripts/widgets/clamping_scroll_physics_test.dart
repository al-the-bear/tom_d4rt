// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// Handcrafted D4rt print-only test focused on ClampingScrollPhysics behavior.
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

  print('ClampingScrollPhysics test executing');
  print('=' * 50);

  const ClampingScrollPhysics physics = ClampingScrollPhysics();
  final FixedScrollMetrics metrics = FixedScrollMetrics(
    minScrollExtent: 0,
    maxScrollExtent: 100,
    pixels: 50,
    viewportDimension: 20,
    axisDirection: AxisDirection.down,
    devicePixelRatio: 1,
  );

  runCase('instance type is correct', () {
    return physics.runtimeType.toString().contains('ClampingScrollPhysics');
  });

  runCase('applyBoundaryConditions allows in-range delta', () {
    return physics.applyBoundaryConditions(metrics, 60) == 0;
  });

  runCase('overscroll at top is clamped', () {
    final FixedScrollMetrics top = FixedScrollMetrics(
      minScrollExtent: 0,
      maxScrollExtent: 100,
      pixels: 0,
      viewportDimension: 20,
      axisDirection: AxisDirection.down,
      devicePixelRatio: 1,
    );
    return physics.applyBoundaryConditions(top, -5) < 0;
  });

  runCase('applyTo keeps physics chain', () {
    final ScrollPhysics chained = physics.applyTo(const AlwaysScrollableScrollPhysics());
    return chained.parent != null;
  });

  runCase('shouldAcceptUserOffset true for scrollable range', () {
    return physics.shouldAcceptUserOffset(metrics);
  });

  runCase('toString references class name', () {
    return physics.toString().contains('ClampingScrollPhysics');
  });

  runCase('summary text can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.contains('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('ClampingScrollPhysics Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ClampingScrollPhysics behavior checks completed'),
    ],
  );
}
