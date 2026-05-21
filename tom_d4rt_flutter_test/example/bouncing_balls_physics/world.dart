// Pure physics model + step function for bouncing_balls_physics.
//
// We model the world as a fixed-size rectangle whose dimensions
// (`kWorldW`, `kWorldH`) are independent of the on-screen widget
// size — the painter scales the world to its canvas via a
// FittedBox-style transform. That separation is what makes the
// step deterministic: the same script run on a desktop and a
// phone produces identical ball trajectories given the same dt.
//
// A `Ball` is immutable; every step returns a brand-new
// `World` with fresh `Ball` instances. Two balls compare equal
// iff they share an `id`, so a `Set<Ball>` can hold the live
// roster without aliasing — but the simulation itself uses a
// plain `List<Ball>` because order matters (it's the spawn
// order, also the paint order).
//
// Coordinate system: (0,0) is the top-left, +x right, +y down.
// Gravity is positive (pulls balls *down*).
import 'package:flutter/foundation.dart';

/// World width in physical units (px-equivalent).
const double kWorldW = 400.0;

/// World height in physical units.
const double kWorldH = 300.0;

/// Default fixed step size used by the `btn-step` button.
/// Tests advance the world via `btn-step` so this is the time
/// quantum every assertion is measured against.
const double kStepDt = 0.05;

/// Default gravity in px/s² — earth-ish.
const double kDefaultGravity = 800.0;

/// Default coefficient of restitution. 1.0 = perfectly elastic,
/// 0.0 = balls glue to the wall. 0.85 has visible bounce loss.
const double kDefaultElasticity = 0.85;

/// Minimum velocity below which we damp to zero, to stop the
/// "jittering at rest" that perfectly elastic floors would do.
const double kRestThreshold = 5.0;

/// Default ball radius.
const double kBallRadius = 12.0;

/// Seed used by the spawn RNG so test runs are reproducible.
const int kBallSeed = 1337;

/// Palette index used by the painter — kept here so tests can
/// reason about spawn colour without importing Flutter types.
const int kPaletteSize = 6;

@immutable
class Ball {
  final int id;
  final double x;
  final double y;
  final double vx;
  final double vy;
  final double radius;
  final int colorIndex;

  const Ball({
    required this.id,
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.colorIndex,
  });

  Ball copyWith({
    double? x,
    double? y,
    double? vx,
    double? vy,
  }) {
    return Ball(
      id: id,
      x: x ?? this.x,
      y: y ?? this.y,
      vx: vx ?? this.vx,
      vy: vy ?? this.vy,
      radius: radius,
      colorIndex: colorIndex,
    );
  }

  @override
  bool operator ==(Object other) => other is Ball && other.id == id;

  @override
  int get hashCode => id;

  @override
  String toString() =>
      'Ball#$id(x=${x.toStringAsFixed(1)},y=${y.toStringAsFixed(1)},'
      'vx=${vx.toStringAsFixed(1)},vy=${vy.toStringAsFixed(1)})';
}

@immutable
class World {
  final List<Ball> balls;
  final double gravity;
  final double elasticity;

  const World({
    required this.balls,
    required this.gravity,
    required this.elasticity,
  });

  World copyWith({
    List<Ball>? balls,
    double? gravity,
    double? elasticity,
  }) {
    return World(
      balls: balls ?? this.balls,
      gravity: gravity ?? this.gravity,
      elasticity: elasticity ?? this.elasticity,
    );
  }

  /// Convenience: highest ball (smallest y). Used by the trail
  /// printer to give tests an observable scalar without dumping
  /// every ball.
  double get topY {
    if (balls.isEmpty) return kWorldH;
    var best = balls.first.y;
    for (final b in balls) {
      if (b.y < best) best = b.y;
    }
    return best;
  }
}

/// Advance [world] by [dt] seconds. Returns a brand-new World.
///
/// Algorithm per ball:
///   1. integrate velocity:  vy' = vy + g * dt
///   2. integrate position:  x'  = x + vx * dt, y' = y + vy' * dt
///   3. resolve walls:       if outside, clamp inside and reflect
///                           velocity scaled by elasticity. If the
///                           reflected speed is below the rest
///                           threshold, snap to 0 (so balls actually
///                           come to rest on the floor).
World stepWorld(World world, double dt) {
  final next = <Ball>[];
  for (final b in world.balls) {
    var vx = b.vx;
    var vy = b.vy + world.gravity * dt;
    var x = b.x + vx * dt;
    var y = b.y + vy * dt;

    // Left wall.
    if (x - b.radius < 0.0) {
      x = b.radius;
      vx = -vx * world.elasticity;
      if (vx.abs() < kRestThreshold) vx = 0.0;
    }
    // Right wall.
    if (x + b.radius > kWorldW) {
      x = kWorldW - b.radius;
      vx = -vx * world.elasticity;
      if (vx.abs() < kRestThreshold) vx = 0.0;
    }
    // Ceiling.
    if (y - b.radius < 0.0) {
      y = b.radius;
      vy = -vy * world.elasticity;
      if (vy.abs() < kRestThreshold) vy = 0.0;
    }
    // Floor.
    if (y + b.radius > kWorldH) {
      y = kWorldH - b.radius;
      vy = -vy * world.elasticity;
      if (vy.abs() < kRestThreshold) vy = 0.0;
    }
    next.add(b.copyWith(x: x, y: y, vx: vx, vy: vy));
  }
  return world.copyWith(balls: next);
}

/// Construct a "spawn ball" with deterministic starting parameters
/// given an [id] and an RNG. Spawns near the top, with a small
/// horizontal kick.
Ball spawnBall(int id, double rand0to1Horizontal, double rand0to1Velocity) {
  // Horizontal anchor: 25%-75% of world width.
  final x = kWorldW * (0.25 + 0.5 * rand0to1Horizontal);
  // Spawn slightly below the ceiling so the ball isn't immediately
  // clamped on its first step.
  final y = kBallRadius * 2.0;
  // Small horizontal velocity in [-80, +80] px/s.
  final vx = (rand0to1Velocity - 0.5) * 160.0;
  // Zero vertical velocity — gravity does the rest.
  const vy = 0.0;
  final colorIndex = id % kPaletteSize;
  return Ball(
    id: id,
    x: x,
    y: y,
    vx: vx,
    vy: vy,
    radius: kBallRadius,
    colorIndex: colorIndex,
  );
}
