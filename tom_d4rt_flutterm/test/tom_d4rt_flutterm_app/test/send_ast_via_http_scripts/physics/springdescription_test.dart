// D4rt test script: Tests SpringDescription, BoundedFrictionSimulation from physics
import 'package:flutter/physics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SpringDescription test executing');

  // ========== SPRINGDESCRIPTION ==========
  print('--- SpringDescription Tests ---');

  // Test SpringDescription with mass, stiffness, damping
  final spring1 = SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0);
  print('SpringDescription created');
  print('  mass: ${spring1.mass}');
  print('  stiffness: ${spring1.stiffness}');
  print('  damping: ${spring1.damping}');

  // Test with different parameters
  final spring2 = SpringDescription(mass: 2.0, stiffness: 200.0, damping: 20.0);
  print('SpringDescription(2, 200, 20) created');
  print('  mass: ${spring2.mass}');
  print('  stiffness: ${spring2.stiffness}');
  print('  damping: ${spring2.damping}');

  // Test SpringDescription.withDampingRatio
  final springDamped = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 1.0,
  );
  print('SpringDescription.withDampingRatio(ratio=1.0) created');
  print('  mass: ${springDamped.mass}');
  print('  stiffness: ${springDamped.stiffness}');
  print('  damping: ${springDamped.damping}');

  // Under-damped spring
  final springUnder = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 0.5,
  );
  print('Under-damped spring (ratio=0.5)');
  print('  damping: ${springUnder.damping}');

  // Over-damped spring
  final springOver = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 2.0,
  );
  print('Over-damped spring (ratio=2.0)');
  print('  damping: ${springOver.damping}');

  // Test toString
  print('SpringDescription toString: $spring1');

  // ========== BOUNDEDFRICTIONSIMULATION ==========
  print('--- BoundedFrictionSimulation Tests ---');

  // BoundedFrictionSimulation combines friction with position bounds
  final boundedFriction = BoundedFrictionSimulation(
    0.3, // drag coefficient
    100.0, // initial position
    200.0, // initial velocity
    0.0, // min position
    500.0, // max position
  );
  print('BoundedFrictionSimulation created');

  // Test position at various times
  final pos0 = boundedFriction.x(0.0);
  print('Position at t=0: $pos0');

  final pos1 = boundedFriction.x(0.5);
  print('Position at t=0.5: $pos1');

  final pos2 = boundedFriction.x(1.0);
  print('Position at t=1.0: $pos2');

  final pos3 = boundedFriction.x(5.0);
  print('Position at t=5.0: $pos3');

  // Test velocity at various times
  final vel0 = boundedFriction.dx(0.0);
  print('Velocity at t=0: $vel0');

  final vel1 = boundedFriction.dx(0.5);
  print('Velocity at t=0.5: $vel1');

  final vel2 = boundedFriction.dx(1.0);
  print('Velocity at t=1.0: $vel2');

  // Test isDone
  print('isDone at t=0: ${boundedFriction.isDone(0.0)}');
  print('isDone at t=100: ${boundedFriction.isDone(100.0)}');

  // Test FrictionSimulation (parent class)
  final friction = FrictionSimulation(0.3, 100.0, 200.0);
  print('FrictionSimulation created');
  print('FrictionSimulation x(0): ${friction.x(0.0)}');
  print('FrictionSimulation x(1): ${friction.x(1.0)}');

  print('All SpringDescription tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Physics Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Spring: mass=${spring1.mass}, stiffness=${spring1.stiffness}',
            ),
            Text('Spring damping: ${spring1.damping}'),
            SizedBox(height: 8.0),
            Text('BoundedFriction pos@0: $pos0'),
            Text('BoundedFriction pos@1: $pos2'),
            Text('BoundedFriction vel@0: $vel0'),
          ],
        ),
      ),
    ),
  );
}
