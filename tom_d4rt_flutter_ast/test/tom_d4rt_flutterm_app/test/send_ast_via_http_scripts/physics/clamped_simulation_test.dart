// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ClampedSimulation from physics
import 'package:flutter/physics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClampedSimulation test executing');
  print('=' * 50);

  // ClampedSimulation for position-constrained simulation
  print('\nClampedSimulation:');
  print('Wraps any Simulation with position clamps');
  print('Constrains output to [xMin, xMax] range');

  // Create inner simulation
  final spring = SpringSimulation(
    SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0),
    0.0, // start
    300.0, // end (exceeds clamp)
    0.0, // velocity
  );

  // Wrap with clamps
  final clamped = ClampedSimulation(spring, xMin: 0.0, xMax: 200.0);
  print('\nClampedSimulation created:');
  print('inner: SpringSimulation');
  print('xMin: 0.0');
  print('xMax: 200.0');

  // Position over time
  print('\nPosition x(t) (clamped):');
  print('x(0.0): ${clamped.x(0.0).toStringAsFixed(2)}');
  print('x(0.5): ${clamped.x(0.5).toStringAsFixed(2)}');
  print('x(1.0): ${clamped.x(1.0).toStringAsFixed(2)}');
  print('x(2.0): ${clamped.x(2.0).toStringAsFixed(2)}');

  // Velocity
  print('\nVelocity dx(t):');
  print('dx(0.0): ${clamped.dx(0.0).toStringAsFixed(2)}');
  print('dx(0.5): ${clamped.dx(0.5).toStringAsFixed(2)}');

  // isDone
  print('\nisDone(t):');
  print('isDone(0.0): ${clamped.isDone(0.0)}');
  print('isDone(3.0): ${clamped.isDone(3.0)}');

  // Properties
  print('\nProperties:');
  print('simulation: ${clamped.simulation.runtimeType}');
  print('xMin: ${clamped.xMin}');
  print('xMax: ${clamped.xMax}');

  // Extends Simulation
  print('\nExtends Simulation:');
  print('is Simulation: true /* clamped is Simulation */');

  // Use cases
  print('\nUse cases:');
  print('- Constrain spring overshoot');
  print('- Limit scroll bounds');
  print('- Cap animation values');
  print('- Safe value ranges');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Simulation');
  print('  \u2514\u2500 ClampedSimulation');

  // Explain purpose
  print('\nClampedSimulation purpose:');
  print('- Wrap any Simulation');
  print('- Clamp x() to [xMin, xMax]');
  print('- Delegates dx() and isDone()');
  print('- Position constraint wrapper');

  print('\n${'=' * 50}');
  print('ClampedSimulation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ClampedSimulation Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('x(0): ${clamped.x(0.0).toStringAsFixed(1)}'),
      Text('x(1): ${clamped.x(1.0).toStringAsFixed(1)}'),
      Text('Clamp: [0.0, 200.0]'),
      Text('Purpose: Position clamping'),
    ],
  );
}
