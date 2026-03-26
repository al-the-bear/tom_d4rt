// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/physics.dart';
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

  print('Physics class smoke test executing');
  print('=' * 50);

  runCase('Tolerance defaults are finite', () {
    const Tolerance t = Tolerance.defaultTolerance;
    return t.distance > 0 && t.velocity > 0 && t.time > 0;
  });

  runCase('SpringDescription created', () {
    final SpringDescription d = SpringDescription.withDampingRatio(
      mass: 1,
      stiffness: 100,
      ratio: 1,
    );
    return d.mass == 1 && d.stiffness == 100;
  });

  runCase('SpringSimulation position changes', () {
    final SpringDescription d = SpringDescription.withDampingRatio(
      mass: 1,
      stiffness: 50,
      ratio: 1,
    );
    final SpringSimulation sim = SpringSimulation(d, 0, 1, 0);
    return sim.x(0.2) != sim.x(0.0);
  });

  runCase('FrictionSimulation velocity decreases', () {
    final FrictionSimulation sim = FrictionSimulation(0.135, 0, 10);
    return sim.dx(0.5).abs() < sim.dx(0.0).abs();
  });

  runCase('ClampingScrollSimulation created', () {
    final ClampingScrollSimulation sim = ClampingScrollSimulation(
      position: 0,
      velocity: 100,
      tolerance: Tolerance.defaultTolerance,
    );
    return sim.x(0).isFinite;
  });

  runCase('BoundedFrictionSimulation clamps end', () {
    final BoundedFrictionSimulation sim = BoundedFrictionSimulation(0.1, 0, 30, 0, 10);
    final double end = sim.x(10);
    return end <= 10 && end >= 0;
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) {
    print('Failed cases: ${failed.join(', ')}');
  }
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('Physics Class Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('Simulations evaluated at runtime'),
    ],
  );
}
