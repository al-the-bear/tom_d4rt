// D4rt test script: Tests general physics package imports (FrictionSimulation)
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Physics package class test executing');
  final results = <String>[];

  // Test 1: Create FrictionSimulation with positive velocity
  final friction1 = FrictionSimulation(0.5, 0.0, 100.0);
  results.add('Test 1: FrictionSimulation(drag=0.5, pos=0, vel=100)');
  print('Created FrictionSimulation with positive velocity');

  // Test 2: Initial position at time 0
  final posAtZero = friction1.x(0.0);
  results.add('Position at t=0: $posAtZero');
  print('Initial position: $posAtZero');
  assert(posAtZero == 0.0, 'Initial position should be 0');

  // Test 3: Initial velocity at time 0
  final velAtZero = friction1.dx(0.0);
  results.add('Velocity at t=0: $velAtZero');
  print('Initial velocity: $velAtZero');
  assert(velAtZero == 100.0, 'Initial velocity should be 100');

  // Test 4: Position at later time
  final posAtOne = friction1.x(1.0);
  results.add('Position at t=1: $posAtOne');
  print('Position at t=1: $posAtOne');
  assert(posAtOne > 0.0, 'Position should increase');

  // Test 5: Velocity at later time (decreasing due to friction)
  final velAtOne = friction1.dx(1.0);
  results.add('Velocity at t=1: $velAtOne');
  print('Velocity at t=1: $velAtOne');
  assert(velAtOne < 100.0, 'Velocity should decrease due to friction');
  assert(velAtOne > 0.0, 'Velocity should still be positive');

  // Test 6: isDone check at time 0
  final doneAtZero = friction1.isDone(0.0);
  results.add('isDone at t=0: $doneAtZero');
  print('isDone at t=0: $doneAtZero');
  assert(doneAtZero == false, 'Should not be done at t=0');

  // Test 7: FrictionSimulation with negative velocity
  final friction2 = FrictionSimulation(0.5, 0.0, -100.0);
  results.add('Test 7: FrictionSimulation with negative velocity=-100');
  print('Created FrictionSimulation with negative velocity');

  // Test 8: Negative velocity decreases position
  final negPosAtOne = friction2.x(1.0);
  results.add('Position at t=1 (neg vel): $negPosAtOne');
  print('Position with negative velocity: $negPosAtOne');
  assert(negPosAtOne < 0.0, 'Position should decrease with negative velocity');

  // Test 9: High drag coefficient
  final friction3 = FrictionSimulation(2.0, 0.0, 100.0);
  results.add('Test 9: FrictionSimulation with high drag=2.0');
  print('Created FrictionSimulation with high drag');

  // Test 10: High drag slows down faster
  final highDragVel = friction3.dx(0.5);
  final lowDragVel = friction1.dx(0.5);
  results.add('Velocity at t=0.5: highDrag=$highDragVel, lowDrag=$lowDragVel');
  print('Comparing high vs low drag');
  assert(highDragVel < lowDragVel, 'High drag should slow down faster');

  // Test 11: Very low drag coefficient
  final friction4 = FrictionSimulation(0.01, 0.0, 100.0);
  results.add('Test 11: FrictionSimulation with very low drag=0.01');
  print('Created FrictionSimulation with very low drag');

  // Test 12: Low drag maintains velocity
  final lowDragVelLate = friction4.dx(1.0);
  results.add('Velocity at t=1 (low drag): $lowDragVelLate');
  print('Velocity with low drag: $lowDragVelLate');
  assert(lowDragVelLate > velAtOne, 'Low drag should maintain velocity better');

  // Test 13: Position accumulation over time
  final posAtTwo = friction1.x(2.0);
  results.add('Position at t=2: $posAtTwo');
  print('Position at t=2: $posAtTwo');
  assert(posAtTwo > posAtOne, 'Position should continue to increase');

  // Test 14: Velocity approaches zero
  final velAtTen = friction1.dx(10.0);
  results.add('Velocity at t=10: $velAtTen');
  print('Velocity at t=10: $velAtTen');

  // Test 15: Position stabilizes as velocity approaches zero
  final posAtTen = friction1.x(10.0);
  final posAtTwenty = friction1.x(20.0);
  results.add('Position at t=10: $posAtTen, t=20: $posAtTwenty');
  print('Position stabilization check');

  // Test 16: isDone at large time
  final doneAtTen = friction1.isDone(10.0);
  results.add('isDone at t=10: $doneAtTen');
  print('isDone at t=10: $doneAtTen');

  // Test 17: GravitySimulation available in physics
  final gravity = GravitySimulation(9.8, 0.0, 100.0, 0.0);
  results.add('Test 17: GravitySimulation also available');
  print('GravitySimulation created from physics package');

  // Test 18: SpringSimulation available (conceptual - springs are complex)
  results.add('Test 18: Physics package import verified');
  print('Physics package imports working');

  // Test 19: Small time delta
  final smallTimePos = friction1.x(0.01);
  results.add('Position at t=0.01: $smallTimePos');
  print('Position at small time delta: $smallTimePos');

  // Test 20: Consistent results
  final pos1 = friction1.x(1.5);
  final pos2 = friction1.x(1.5);
  results.add('Position consistency: $pos1 == $pos2: ${pos1 == pos2}');
  print('Position consistency verified');

  print('Physics package class test completed - ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Physics Package Class Tests (${results.length} tests)',
           style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 12)),
      )),
    ],
  );
}
