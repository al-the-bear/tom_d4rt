// physics_sim — the focus example.
//
// A D4rt script that drives the *native* PhysicsWorld service. Every type used
// here (Vector2, PhysicsWorld, Body) is bridged native Dart, registered by the
// runner before this script executes. The script reads like plain Dart, but the
// objects are real compiled instances living in the host program.

import 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart';

void main(List<String> args) {
  // Construct a native PhysicsWorld with custom gravity (a bridged Vector2).
  final world = PhysicsWorld(gravity: Vector2(0, -9.81));

  // Add two projectiles — addBody returns native Body objects.
  world.addBody(Vector2(0, 0), Vector2(5, 20), mass: 1.0);
  world.addBody(Vector2(0, 0), Vector2(8, 10), mass: 2.0);

  print('Simulating ${world.bodyCount} bodies under gravity ${world.gravity}');
  print('');

  const dt = 0.1;
  for (var step = 1; step <= 5; step++) {
    world.step(dt);
    final t = (step * dt).toStringAsFixed(1);
    print('t=${t}s');
    for (var i = 0; i < world.bodies.length; i++) {
      final body = world.bodies[i];
      // Use a bridged getter (.magnitude) and operator (-) on Vector2.
      final speed = body.velocity.magnitude.toStringAsFixed(2);
      print('  body $i: pos=${body.position}  speed=$speed');
    }
  }

  var highest = world.bodies.first;
  for (final body in world.bodies) {
    if (body.position.y > highest.position.y) highest = body;
  }
  print('\nHighest body is now at y=${highest.position.y.toStringAsFixed(2)}');
}
