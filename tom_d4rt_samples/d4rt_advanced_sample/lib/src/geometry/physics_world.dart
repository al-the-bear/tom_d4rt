/// A tiny physics service — the "stateful native object" the focus example
/// drives from a script.
///
/// Demonstrates the generator bridging a mutable service class with methods
/// that take and return other bridged types (`Vector2`), plus a method that
/// returns a list of bridged objects.
library;

import 'vector2.dart';

/// A point mass with a position and velocity.
class Body {
  Vector2 position;
  Vector2 velocity;
  final double mass;

  Body(this.position, this.velocity, this.mass);

  @override
  String toString() =>
      'Body(pos=$position, vel=$velocity, m=${mass.toStringAsFixed(1)})';
}

/// A minimal 2D physics world: gravity + Euler integration.
class PhysicsWorld {
  /// Constant downward acceleration applied to every body each step.
  Vector2 gravity;

  final List<Body> _bodies = [];

  PhysicsWorld({this.gravity = const Vector2(0, -9.81)});

  /// The number of bodies currently in the world.
  int get bodyCount => _bodies.length;

  /// Add a body and return it (so scripts can keep a reference).
  Body addBody(Vector2 position, Vector2 velocity, {double mass = 1.0}) {
    final body = Body(position, velocity, mass);
    _bodies.add(body);
    return body;
  }

  /// Advance the simulation by [dt] seconds using simple Euler integration.
  void step(double dt) {
    for (final body in _bodies) {
      body.velocity = body.velocity + gravity * dt;
      body.position = body.position + body.velocity * dt;
    }
  }

  /// Snapshot of all bodies (returns bridged `Body` objects).
  List<Body> get bodies => List.unmodifiable(_bodies);
}
