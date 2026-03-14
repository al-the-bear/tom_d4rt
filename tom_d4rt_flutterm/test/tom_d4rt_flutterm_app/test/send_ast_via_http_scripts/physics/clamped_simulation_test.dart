// D4rt test script: Tests ClampedSimulation from physics
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClampedSimulation test executing');
  final results = <String>[];

  // Test 1: Create inner simulation (GravitySimulation)
  final innerSim = GravitySimulation(9.8, 0.0, 100.0, 0.0);
  results.add('Test 1: Created inner GravitySimulation');
  print('Created inner GravitySimulation for clamping');

  // Test 2: Create ClampedSimulation with position bounds
  final clamped1 = ClampedSimulation(innerSim, xMin: 0.0, xMax: 50.0);
  results.add('Test 2: ClampedSimulation with xMin=0, xMax=50');
  print('Created ClampedSimulation with position bounds');

  // Test 3: Position at time 0
  final posAtZero = clamped1.x(0.0);
  results.add('Position at t=0: $posAtZero');
  print('Clamped position at t=0: $posAtZero');
  assert(posAtZero >= 0.0, 'Position should be at or above minimum');

  // Test 4: Position clamped to maximum
  final posAtFive = clamped1.x(5.0);
  results.add('Position at t=5 (clamped): $posAtFive');
  print('Clamped position at t=5: $posAtFive');
  assert(posAtFive <= 50.0, 'Position should be clamped to xMax=50');

  // Test 5: Velocity at time 0
  final velAtZero = clamped1.dx(0.0);
  results.add('Velocity at t=0: $velAtZero');
  print('Clamped velocity at t=0: $velAtZero');

  // Test 6: Create with velocity bounds
  final clamped2 = ClampedSimulation(innerSim, dxMin: 0.0, dxMax: 20.0);
  results.add('Test 6: ClampedSimulation with dxMin=0, dxMax=20');
  print('Created ClampedSimulation with velocity bounds');

  // Test 7: Velocity clamped to maximum
  final velClamped = clamped2.dx(10.0);
  results.add('Velocity at t=10 (clamped): $velClamped');
  print('Clamped velocity at t=10: $velClamped');
  assert(velClamped <= 20.0, 'Velocity should be clamped to dxMax=20');

  // Test 8: Velocity clamped to minimum (non-negative)
  final velMin = clamped2.dx(0.0);
  results.add('Velocity at t=0 (min check): $velMin');
  print('Velocity minimum check: $velMin');
  assert(velMin >= 0.0, 'Velocity should be at or above dxMin=0');

  // Test 9: Create with all bounds
  final clamped3 = ClampedSimulation(innerSim, 
    xMin: 0.0, xMax: 30.0, dxMin: -5.0, dxMax: 15.0);
  results.add('Test 9: ClampedSimulation with all bounds');
  print('Created ClampedSimulation with all bounds');

  // Test 10: isDone check
  final doneAtZero = clamped3.isDone(0.0);
  results.add('isDone at t=0: $doneAtZero');
  print('Clamped isDone at t=0: $doneAtZero');

  // Test 11: isDone at later time
  final doneAtFive = clamped3.isDone(5.0);
  results.add('isDone at t=5: $doneAtFive');
  print('Clamped isDone at t=5: $doneAtFive');

  // Test 12: Position with all bounds at small time
  final posSmall = clamped3.x(0.5);
  results.add('Position at t=0.5 (all bounds): $posSmall');
  print('Position with all bounds: $posSmall');

  // Test 13: Create with negative velocity simulation
  final negInner = GravitySimulation(-5.0, 50.0, 0.0, 0.0);
  final clampedNeg = ClampedSimulation(negInner, xMin: 10.0);
  results.add('Test 13: ClampedSimulation with xMin=10 (negative accel)');
  print('Created ClampedSimulation with minimum position bound');

  // Test 14: Minimum position bound enforced
  final posMinClamped = clampedNeg.x(10.0);
  results.add('Position at t=10 (min clamped): $posMinClamped');
  print('Position clamped to minimum: $posMinClamped');
  assert(posMinClamped >= 10.0, 'Position should be clamped to xMin=10');

  // Test 15: No bounds specified (defaults)
  final clampedDefault = ClampedSimulation(innerSim);
  results.add('Test 15: ClampedSimulation with no bounds');
  print('Created ClampedSimulation with default bounds');

  // Test 16: Default behavior follows inner simulation
  final defaultPos = clampedDefault.x(1.0);
  final innerPos = innerSim.x(1.0);
  results.add('Default clamped pos: $defaultPos, inner: $innerPos');
  print('Comparing default clamped vs inner simulation');

  // Test 17: Velocity bounds with negative dxMin
  final clampedNegDx = ClampedSimulation(negInner, dxMin: -10.0, dxMax: 0.0);
  results.add('Test 17: ClampedSimulation with dxMin=-10, dxMax=0');

  // Test 18: Negative velocity clamped
  final negVelClamped = clampedNegDx.dx(1.0);
  results.add('Negative velocity clamped: $negVelClamped');
  print('Clamped negative velocity: $negVelClamped');
  assert(negVelClamped >= -10.0, 'Velocity should be >= dxMin');
  assert(negVelClamped <= 0.0, 'Velocity should be <= dxMax');

  // Test 19: Position at large time (should saturate)
  final posLarge = clamped1.x(100.0);
  results.add('Position at t=100: $posLarge');
  print('Position at large time: $posLarge');
  assert(posLarge <= 50.0, 'Position should remain clamped');

  // Test 20: Multiple time queries consistency
  final pos1 = clamped3.x(2.0);
  final pos2 = clamped3.x(2.0);
  results.add('Position consistency: $pos1 == $pos2');
  print('Position query consistency check');

  print('ClampedSimulation test completed - ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('ClampedSimulation Tests (${results.length} tests)',
           style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      ...results.map((r) => Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Text(r, style: TextStyle(fontSize: 12)),
      )),
    ],
  );
}
