// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SpringDescription, Tolerance, and physics simulation classes
import 'package:flutter/widgets.dart';
import 'package:flutter/physics.dart';

dynamic build(BuildContext context) {
  print('Physics test executing');

  // ========== SPRINGDESCRIPTION ==========
  print('--- SpringDescription Tests ---');

  // Default SpringDescription
  final spring1 = SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0);
  print('SpringDescription(mass=1, stiffness=100, damping=10):');
  print('  mass: ${spring1.mass}');
  print('  stiffness: ${spring1.stiffness}');
  print('  damping: ${spring1.damping}');

  // SpringDescription.withDampingRatio
  final spring2 = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 1.0, // critically damped
  );
  print('SpringDescription.withDampingRatio(ratio=1.0):');
  print('  mass: ${spring2.mass}');
  print('  stiffness: ${spring2.stiffness}');
  print('  damping: ${spring2.damping}');

  // Underdamped spring (ratio < 1)
  final underdamped = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 0.5,
  );
  print('Underdamped (ratio=0.5):');
  print('  damping: ${underdamped.damping}');

  // Overdamped spring (ratio > 1)
  final overdamped = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 2.0,
  );
  print('Overdamped (ratio=2.0):');
  print('  damping: ${overdamped.damping}');

  // Different mass values
  final heavySpring = SpringDescription(
    mass: 5.0,
    stiffness: 100.0,
    damping: 10.0,
  );
  print('Heavy spring (mass=5): ${heavySpring.mass}');

  final lightSpring = SpringDescription(
    mass: 0.5,
    stiffness: 100.0,
    damping: 10.0,
  );
  print('Light spring (mass=0.5): ${lightSpring.mass}');

  // Different stiffness values
  final stiffSpring = SpringDescription(
    mass: 1.0,
    stiffness: 500.0,
    damping: 10.0,
  );
  print('Stiff spring (stiffness=500): ${stiffSpring.stiffness}');

  final softSpring = SpringDescription(
    mass: 1.0,
    stiffness: 20.0,
    damping: 10.0,
  );
  print('Soft spring (stiffness=20): ${softSpring.stiffness}');

  // ========== TOLERANCE ==========
  print('--- Tolerance Tests ---');

  // Default Tolerance
  const defaultTolerance = Tolerance();
  print('Default Tolerance:');
  print('  distance: ${defaultTolerance.distance}');
  print('  time: ${defaultTolerance.time}');
  print('  velocity: ${defaultTolerance.velocity}');

  // Custom Tolerance
  const customTolerance = Tolerance(
    distance: 0.001,
    time: 0.001,
    velocity: 0.001,
  );
  print('Custom Tolerance (all 0.001):');
  print('  distance: ${customTolerance.distance}');
  print('  time: ${customTolerance.time}');
  print('  velocity: ${customTolerance.velocity}');

  // Tolerance.defaultTolerance
  print('Tolerance.defaultTolerance: ${Tolerance.defaultTolerance}');

  // ========== SPRINGSIMULATION ==========
  print('--- SpringSimulation Tests ---');

  final springSimulation = SpringSimulation(
    spring1,
    0.0, // start position
    1.0, // end position
    0.0, // initial velocity
  );
  print('SpringSimulation created');
  print('  type: ${springSimulation.type}');

  // Simulate at different times
  print('Position at t=0: ${springSimulation.x(0.0).toStringAsFixed(4)}');
  print('Position at t=0.1: ${springSimulation.x(0.1).toStringAsFixed(4)}');
  print('Position at t=0.5: ${springSimulation.x(0.5).toStringAsFixed(4)}');
  print('Position at t=1.0: ${springSimulation.x(1.0).toStringAsFixed(4)}');
  print('Position at t=2.0: ${springSimulation.x(2.0).toStringAsFixed(4)}');

  // Velocity at different times
  print('Velocity at t=0: ${springSimulation.dx(0.0).toStringAsFixed(4)}');
  print('Velocity at t=0.5: ${springSimulation.dx(0.5).toStringAsFixed(4)}');
  print('Velocity at t=1.0: ${springSimulation.dx(1.0).toStringAsFixed(4)}');

  // Is done?
  print('isDone at t=0.5: ${springSimulation.isDone(0.5)}');
  print('isDone at t=5.0: ${springSimulation.isDone(5.0)}');

  // SpringType
  print('SpringType.criticallyDamped: ${SpringType.criticallyDamped}');
  print('SpringType.underDamped: ${SpringType.underDamped}');
  print('SpringType.overDamped: ${SpringType.overDamped}');

  // ========== SCROLLSPRINGSIMULATION ==========
  print('--- ScrollSpringSimulation Tests ---');

  final scrollSpring = ScrollSpringSimulation(
    spring1,
    0.0, // position
    100.0, // end (target)
    0.0, // velocity
  );
  print('ScrollSpringSimulation created');
  print('Position at 0.5s: ${scrollSpring.x(0.5).toStringAsFixed(2)}');

  // ========== FRICTIONSIMULATION ==========
  print('--- FrictionSimulation Tests ---');

  final frictionSim = FrictionSimulation(
    0.135, // drag coefficient
    0.0, // position
    100.0, // velocity
  );
  print('FrictionSimulation created');
  print('Position at t=0: ${frictionSim.x(0.0).toStringAsFixed(2)}');
  print('Position at t=0.5: ${frictionSim.x(0.5).toStringAsFixed(2)}');
  print('Position at t=1.0: ${frictionSim.x(1.0).toStringAsFixed(2)}');
  print('Velocity at t=0: ${frictionSim.dx(0.0).toStringAsFixed(2)}');
  print('Velocity at t=1.0: ${frictionSim.dx(1.0).toStringAsFixed(2)}');
  print('finalX: ${frictionSim.finalX.toStringAsFixed(2)}');
  print('timeAtX(500): ${frictionSim.timeAtX(500.0).toStringAsFixed(2)}s');

  // ========== BOUNCING SCROLL SIMULATION ==========
  print('--- BouncingScrollSimulation Tests ---');

  final bouncingSim = BouncingScrollSimulation(
    position: 0.0,
    velocity: 1000.0,
    leadingExtent: 0.0,
    trailingExtent: 500.0,
    spring: spring1,
  );
  print('BouncingScrollSimulation created');
  print('Position at t=0: ${bouncingSim.x(0.0).toStringAsFixed(2)}');
  print('Position at t=0.2: ${bouncingSim.x(0.2).toStringAsFixed(2)}');

  // ========== CLAMPING SCROLL SIMULATION ==========
  print('--- ClampingScrollSimulation Tests ---');

  final clampingSim = ClampingScrollSimulation(position: 0.0, velocity: 1000.0);
  print('ClampingScrollSimulation created');
  print('Position at t=0: ${clampingSim.x(0.0).toStringAsFixed(2)}');
  print('Position at t=0.2: ${clampingSim.x(0.2).toStringAsFixed(2)}');

  // ========== GRAVITYSIMULATION ==========
  print('--- GravitySimulation Tests ---');

  final gravitySim = GravitySimulation(
    9.81, // acceleration (m/s^2)
    0.0, // start distance
    100.0, // end distance
    0.0, // initial velocity
  );
  print('GravitySimulation (g=9.81)');
  print('Position at t=0: ${gravitySim.x(0.0).toStringAsFixed(2)}');
  print('Position at t=1: ${gravitySim.x(1.0).toStringAsFixed(2)}');
  print('Position at t=2: ${gravitySim.x(2.0).toStringAsFixed(2)}');
  print('Velocity at t=1: ${gravitySim.dx(1.0).toStringAsFixed(2)}');

  print('Physics test completed');

  // Return visual demonstration
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Physics Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'SpringDescription:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Parameters:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    '• mass - oscillator mass',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• stiffness - spring constant (k)',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• damping - friction coefficient',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text('SpringType:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(right: 4.0),
                    color: Color(0xFF2196F3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Underdamped',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                        Text(
                          'ratio < 1',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                        Text(
                          'Oscillates',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    color: Color(0xFF4CAF50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Critical',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                        Text(
                          'ratio = 1',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                        Text(
                          'Fastest',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(left: 4.0),
                    color: Color(0xFFFF9800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overdamped',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.0,
                          ),
                        ),
                        Text(
                          'ratio > 1',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                        Text(
                          'Sluggish',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Tolerance:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• distance - position tolerance',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• time - time tolerance',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• velocity - velocity tolerance',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    'Used by isDone() to determine completion',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Simulation Types:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _simulationRow(
                  'SpringSimulation',
                  'Spring physics',
                  Color(0xFF2196F3),
                ),
                SizedBox(height: 4.0),
                _simulationRow(
                  'ScrollSpringSimulation',
                  'Scroll bounce-back',
                  Color(0xFF4CAF50),
                ),
                SizedBox(height: 4.0),
                _simulationRow(
                  'FrictionSimulation',
                  'Deceleration',
                  Color(0xFFFF9800),
                ),
                SizedBox(height: 4.0),
                _simulationRow(
                  'BouncingScrollSimulation',
                  'iOS-style scroll',
                  Color(0xFF9C27B0),
                ),
                SizedBox(height: 4.0),
                _simulationRow(
                  'ClampingScrollSimulation',
                  'Android-style scroll',
                  Color(0xFFE53935),
                ),
                SizedBox(height: 4.0),
                _simulationRow(
                  'GravitySimulation',
                  'Constant acceleration',
                  Color(0xFF607D8B),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Simulation API:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'x(time) → position at time',
                    style: TextStyle(fontSize: 12.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    'dx(time) → velocity at time',
                    style: TextStyle(fontSize: 12.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    'isDone(time) → simulation complete?',
                    style: TextStyle(fontSize: 12.0, fontFamily: 'monospace'),
                  ),
                  Text(
                    'tolerance → completion threshold',
                    style: TextStyle(fontSize: 12.0, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'Spring Formula:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFFFF9C4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'F = -kx - cv',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text('k = stiffness', style: TextStyle(fontSize: 11.0)),
                  Text('c = damping', style: TextStyle(fontSize: 11.0)),
                  Text('x = displacement', style: TextStyle(fontSize: 11.0)),
                  Text('v = velocity', style: TextStyle(fontSize: 11.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _simulationRow(String name, String description, Color color) {
  return Row(
    children: [
      Container(width: 12.0, height: 12.0, color: color),
      SizedBox(width: 8.0),
      Text(name, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
      SizedBox(width: 8.0),
      Text('- $description', style: TextStyle(fontSize: 12.0)),
    ],
  );
}
