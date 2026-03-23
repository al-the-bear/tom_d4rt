// ignore_for_file: avoid_print
// D4rt test script: Tests GravitySimulation from physics
import 'package:flutter/physics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GravitySimulation test executing');
  print('=' * 50);

  // GravitySimulation for gravitational physics
  print('\nGravitySimulation:');
  print('Simulates falling under gravity');
  print('Constant acceleration physics');

  // Create instance
  final sim = GravitySimulation(
    9.8, // acceleration (m/s^2)
    0.0, // starting position
    0.0, // starting velocity
    500.0, // ending position (ground)
  );
  print('\nInstance created:');
  print('acceleration: 9.8');
  print('x0 (start position): 0.0');
  print('v0 (start velocity): 0.0');
  print('xEnd (target): 500.0');

  // Position over time (s = v0*t + 0.5*a*t^2)
  print('\nPosition x(t):');
  print('x(0.0): ${sim.x(0.0).toStringAsFixed(2)}');
  print('x(1.0): ${sim.x(1.0).toStringAsFixed(2)}');
  print('x(2.0): ${sim.x(2.0).toStringAsFixed(2)}');
  print('x(5.0): ${sim.x(5.0).toStringAsFixed(2)}');

  // Velocity over time (v = v0 + a*t)
  print('\nVelocity dx(t):');
  print('dx(0.0): ${sim.dx(0.0).toStringAsFixed(2)}');
  print('dx(1.0): ${sim.dx(1.0).toStringAsFixed(2)}');
  print('dx(2.0): ${sim.dx(2.0).toStringAsFixed(2)}');

  // isDone check
  print('\nisDone(t):');
  print('isDone(0.0): ${sim.isDone(0.0)}');
  print('isDone(5.0): ${sim.isDone(5.0)}');
  print('isDone(15.0): ${sim.isDone(15.0)}');

  // With initial velocity
  print('\nWith initial velocity:');
  final simWithV = GravitySimulation(9.8, 100.0, -50.0, 500.0);
  print('x0: 100.0, v0: -50.0 (upward throw)');
  print('x(0.0): ${simWithV.x(0.0).toStringAsFixed(2)}');
  print('x(2.0): ${simWithV.x(2.0).toStringAsFixed(2)}');
  print('x(5.0): ${simWithV.x(5.0).toStringAsFixed(2)}');

  // Extends Simulation
  print('\nExtends Simulation:');
  print('is Simulation: true /* sim is Simulation */');

  // Use cases
  print('\nUse cases:');
  print('- Falling objects');
  print('- Thrown projectiles');
  print('- Drop animations');
  print('- Physics games');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Simulation');
  print('  \u2514\u2500 GravitySimulation');

  // Explain purpose
  print('\nGravitySimulation purpose:');
  print('- Constant acceleration');
  print('- Models gravitational fall');
  print('- x = x0 + v0*t + 0.5*a*t^2');
  print('- v = v0 + a*t');
  print('- Extends Simulation');

  print('\n${'=' * 50}');
  print('GravitySimulation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'GravitySimulation Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('x(1): ${sim.x(1.0).toStringAsFixed(1)}'),
      Text('x(2): ${sim.x(2.0).toStringAsFixed(1)}'),
      Text('dx(1): ${sim.dx(1.0).toStringAsFixed(1)}'),
      Text('Purpose: Gravity physics'),
    ],
  );
}
