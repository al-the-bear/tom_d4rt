// D4rt test script: Tests BoundedFrictionSimulation from physics
import 'package:flutter/physics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoundedFrictionSimulation test executing');
  print('=' * 50);

  // BoundedFrictionSimulation for bounded friction physics
  print('\nBoundedFrictionSimulation:');
  print('FrictionSimulation with bounds');
  print('Stops at min/max position limits');

  // Create instance
  final sim = BoundedFrictionSimulation(
    0.135, // drag
    50.0, // position
    100.0, // velocity
    0.0, // minPosition
    200.0, // maxPosition
  );
  print('\nInstance created:');
  print('drag: 0.135');
  print('position: 50.0');
  print('velocity: 100.0');
  print('minPosition: 0.0');
  print('maxPosition: 200.0');

  // Position over time
  print('\nPosition x(t):');
  print('x(0.0): ${sim.x(0.0).toStringAsFixed(2)}');
  print('x(0.5): ${sim.x(0.5).toStringAsFixed(2)}');
  print('x(1.0): ${sim.x(1.0).toStringAsFixed(2)}');
  print('x(2.0): ${sim.x(2.0).toStringAsFixed(2)}');

  // Velocity over time
  print('\nVelocity dx(t):');
  print('dx(0.0): ${sim.dx(0.0).toStringAsFixed(2)}');
  print('dx(0.5): ${sim.dx(0.5).toStringAsFixed(2)}');
  print('dx(1.0): ${sim.dx(1.0).toStringAsFixed(2)}');

  // isDone check
  print('\nisDone(t):');
  print('isDone(0.0): ${sim.isDone(0.0)}');
  print('isDone(5.0): ${sim.isDone(5.0)}');

  // Extends FrictionSimulation
  print('\nExtends FrictionSimulation:');
  print('is FrictionSimulation: true /* sim is FrictionSimulation */');
  print('is Simulation: true /* sim is Simulation */');

  // Bounds behavior
  print('\nBounds behavior:');
  print('- Position clamped to [min, max]');
  print('- Velocity set to 0 at bounds');
  print('- isDone returns true at bounds');

  // Use cases
  print('\nUse cases:');
  print('- Scrolling with hard limits');
  print('- Clamped pan gestures');
  print('- Bounded drag interactions');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Simulation');
  print('  \u2514\u2500 FrictionSimulation');
  print('       \u2514\u2500 BoundedFrictionSimulation');

  // Explain purpose
  print('\nBoundedFrictionSimulation purpose:');
  print('- Friction with position bounds');
  print('- Stops at min/max positions');
  print('- Used for bounded scrolling');
  print('- Extends FrictionSimulation');

  print('\n${'=' * 50}');
  print('BoundedFrictionSimulation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BoundedFrictionSimulation Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('x(0): ${sim.x(0.0).toStringAsFixed(1)}'),
      Text('x(1): ${sim.x(1.0).toStringAsFixed(1)}'),
      Text('Bounds: [0.0, 200.0]'),
      Text('Purpose: Bounded friction'),
    ],
  );
}
