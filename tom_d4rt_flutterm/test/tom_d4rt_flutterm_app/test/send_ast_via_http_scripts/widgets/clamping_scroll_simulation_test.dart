// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// Handcrafted D4rt print-only test focused on ClampingScrollSimulation behavior.
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

  print('ClampingScrollSimulation test executing');
  print('=' * 50);

  final ClampingScrollSimulation sim = ClampingScrollSimulation(
    position: 100,
    velocity: 1200,
    tolerance: Tolerance.defaultTolerance,
  );

  runCase('x(0) starts at given position', () {
    return (sim.x(0) - 100).abs() < 0.0001;
  });

  runCase('position changes over time', () {
    return sim.x(0.5) != sim.x(0);
  });

  runCase('dx is finite', () {
    return sim.dx(0.2).isFinite;
  });

  runCase('isDone eventually true for large t', () {
    return sim.isDone(1000);
  });

  runCase('simulation is of expected base type', () {
    return sim.runtimeType.toString().contains('ClampingScrollSimulation');
  });

  runCase('toString includes class name', () {
    return sim.toString().contains('ClampingScrollSimulation');
  });

  runCase('summary text can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('ClampingScrollSimulation Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('ClampingScrollSimulation behavior checks completed'),
    ],
  );
}
