// D4rt test script: Tests Simulation class from physics
import 'package:flutter/physics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Simulation class test executing');
  print('=' * 50);

  // Simulation abstract base class
  print('\nSimulation:');
  print('Abstract base class for physical simulations');
  print('Models position and velocity over time');

  // Abstract methods
  print('\nAbstract methods:');
  print('x(double time) - Position at time t');
  print('dx(double time) - Velocity at time t');
  print('isDone(double time) - Completion check');

  // Tolerance property
  print('\ntolerance property:');
  print('Tolerance for done determination');
  print('Tolerance.defaultTolerance used by default');

  // SpringSimulation example
  print('\nSpringSimulation example:');
  final spring = SpringSimulation(
    SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0),
    0.0, // start
    100.0, // end
    0.0, // velocity
  );
  print('is Simulation: ${spring is Simulation}');
  print('x(0.0): ${spring.x(0.0).toStringAsFixed(2)}');
  print('x(1.0): ${spring.x(1.0).toStringAsFixed(2)}');

  // FrictionSimulation example
  print('\nFrictionSimulation example:');
  final friction = FrictionSimulation(0.135, 50.0, 200.0);
  print('is Simulation: ${friction is Simulation}');
  print('x(0.0): ${friction.x(0.0).toStringAsFixed(2)}');
  print('dx(0.0): ${friction.dx(0.0).toStringAsFixed(2)}');

  // GravitySimulation example
  print('\nGravitySimulation example:');
  final gravity = GravitySimulation(9.8, 0.0, 0.0, 500.0);
  print('is Simulation: ${gravity is Simulation}');
  print('x(0.0): ${gravity.x(0.0).toStringAsFixed(2)}');
  print('x(1.0): ${gravity.x(1.0).toStringAsFixed(2)}');

  // Subclasses
  print('\nSubclasses:');
  print('- SpringSimulation');
  print('- FrictionSimulation');
  print('- GravitySimulation');
  print('- BouncingScrollSimulation');
  print('- ClampedSimulation');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Simulation (abstract)');
  print('  \u251c\u2500 SpringSimulation');
  print('  \u251c\u2500 FrictionSimulation');
  print('  \u251c\u2500 GravitySimulation');
  print('  \u251c\u2500 ClampedSimulation');
  print('  \u2514\u2500 BouncingScrollSimulation');

  // Explain purpose
  print('\nSimulation purpose:');
  print('- Base class for physics');
  print('- Models position over time');
  print('- Used by AnimationController');
  print('- Foundation for scroll physics');
  print('- x(), dx(), isDone() interface');

  print('\n' + '=' * 50);
  print('Simulation class test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Simulation Class Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Spring x(1): ${spring.x(1.0).toStringAsFixed(1)}'),
      Text('Friction x(0): ${friction.x(0.0).toStringAsFixed(1)}'),
      Text('Gravity x(1): ${gravity.x(1.0).toStringAsFixed(1)}'),
      Text('Purpose: Physics simulation'),
    ],
  );
}
