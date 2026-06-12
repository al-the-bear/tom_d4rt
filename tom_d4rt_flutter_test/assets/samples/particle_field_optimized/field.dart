// Pure model for the particle-field sandbox (optimized variant).
//
// Identical model to the `particle_field` sample — the optimization in
// this variant is purely in *how the UI is driven* (see
// `field_controller.dart` / `home.dart`), not in the physics. Keeping the
// model byte-for-byte means the two samples step identically; only the
// per-frame interpreter churn differs.
//
// World is a fixed 600x400 box. A `Field` owns its particle list, the
// current force `mode`, and the world-space attractor point. `stepField`
// returns a brand-new Field; nothing is mutated in place. Coordinate
// system: (0,0) is the top-left, +x right, +y down.
import 'dart:math' as math;

import 'package:flutter/foundation.dart';

const double kWorldW = 600.0;
const double kWorldH = 400.0;

/// Number of particles in the field at boot / after reset.
const int kParticleCount = 20;

/// Step quantum used by `btn-step`.
const double kStepDt = 0.05;

/// Attractive / repulsive acceleration magnitude in px/s^2.
const double kForce = 600.0;

/// Per-step velocity multiplier (trims 2 % of kinetic energy per step).
const double kDamping = 0.98;

/// Velocity cap in px/s. Without this the system blows up under long repels.
const double kMaxVelocity = 300.0;

/// Coefficient of restitution on wall bounces.
const double kBounceLoss = 0.7;

/// Particle radius (px). Used by the painter.
const double kParticleRadius = 4.0;

/// Seed for the spawn RNG so the field is reproducible across boots.
const int kParticleSeed = 4242;

/// Palette index modulus used by the painter.
const int kPaletteSize = 6;

enum FieldMode {
  attract,
  repel,
  orbit;

  String get label {
    switch (this) {
      case FieldMode.attract:
        return 'Attract';
      case FieldMode.repel:
        return 'Repel';
      case FieldMode.orbit:
        return 'Orbit';
    }
  }
}

@immutable
class Particle {
  final int id;
  final double x;
  final double y;
  final double vx;
  final double vy;
  final int colorIndex;

  const Particle({
    required this.id,
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.colorIndex,
  });

  Particle copyWith({double? x, double? y, double? vx, double? vy}) {
    return Particle(
      id: id,
      x: x ?? this.x,
      y: y ?? this.y,
      vx: vx ?? this.vx,
      vy: vy ?? this.vy,
      colorIndex: colorIndex,
    );
  }

  @override
  bool operator ==(Object other) => other is Particle && other.id == id;

  @override
  int get hashCode => id;

  @override
  String toString() =>
      'P#$id(x=${x.toStringAsFixed(1)},y=${y.toStringAsFixed(1)},'
      'vx=${vx.toStringAsFixed(1)},vy=${vy.toStringAsFixed(1)})';
}

@immutable
class Field {
  final List<Particle> particles;
  final FieldMode mode;
  final double attractorX;
  final double attractorY;

  const Field({
    required this.particles,
    required this.mode,
    required this.attractorX,
    required this.attractorY,
  });

  Field copyWith({
    List<Particle>? particles,
    FieldMode? mode,
    double? attractorX,
    double? attractorY,
  }) {
    return Field(
      particles: particles ?? this.particles,
      mode: mode ?? this.mode,
      attractorX: attractorX ?? this.attractorX,
      attractorY: attractorY ?? this.attractorY,
    );
  }
}

/// Seed a fresh field with [n] particles distributed uniformly in
/// the world rectangle, all starting at rest.
Field seedField(math.Random rng, int n) {
  final particles = <Particle>[];
  for (var i = 0; i < n; i++) {
    particles.add(Particle(
      id: i,
      x: rng.nextDouble() * kWorldW,
      y: rng.nextDouble() * kWorldH,
      vx: 0.0,
      vy: 0.0,
      colorIndex: i % kPaletteSize,
    ));
  }
  return Field(
    particles: particles,
    mode: FieldMode.attract,
    attractorX: kWorldW / 2.0,
    attractorY: kWorldH / 2.0,
  );
}

/// Mean (x, y) of [particles]. Returns (0, 0) for an empty list.
List<double> centroid(List<Particle> particles) {
  if (particles.isEmpty) return <double>[0.0, 0.0];
  var sx = 0.0;
  var sy = 0.0;
  for (final p in particles) {
    sx += p.x;
    sy += p.y;
  }
  final n = particles.length.toDouble();
  return <double>[sx / n, sy / n];
}

/// Mean distance from each particle in [particles] to (ax, ay).
double meanRadius(List<Particle> particles, double ax, double ay) {
  if (particles.isEmpty) return 0.0;
  var total = 0.0;
  for (final p in particles) {
    final dx = p.x - ax;
    final dy = p.y - ay;
    total += math.sqrt(dx * dx + dy * dy);
  }
  return total / particles.length;
}

/// Advance [field] by [dt] seconds. Returns a brand-new Field.
Field stepField(Field field, double dt) {
  final next = <Particle>[];
  for (final p in field.particles) {
    final dxToAttr = field.attractorX - p.x;
    final dyToAttr = field.attractorY - p.y;
    final dist =
        math.max(1.0, math.sqrt(dxToAttr * dxToAttr + dyToAttr * dyToAttr));
    final nxToAttr = dxToAttr / dist;
    final nyToAttr = dyToAttr / dist;

    double ax;
    double ay;
    switch (field.mode) {
      case FieldMode.attract:
        ax = nxToAttr * kForce;
        ay = nyToAttr * kForce;
        break;
      case FieldMode.repel:
        ax = -nxToAttr * kForce;
        ay = -nyToAttr * kForce;
        break;
      case FieldMode.orbit:
        // 90 deg rotation of the unit vector to attractor.
        ax = -nyToAttr * kForce;
        ay = nxToAttr * kForce;
        break;
    }

    var vx = (p.vx + ax * dt) * kDamping;
    var vy = (p.vy + ay * dt) * kDamping;

    // Velocity magnitude cap.
    final speed = math.sqrt(vx * vx + vy * vy);
    if (speed > kMaxVelocity) {
      final s = kMaxVelocity / speed;
      vx *= s;
      vy *= s;
    }

    var x = p.x + vx * dt;
    var y = p.y + vy * dt;

    // Wall bounces.
    if (x < 0.0) {
      x = 0.0;
      vx = -vx * kBounceLoss;
    }
    if (x > kWorldW) {
      x = kWorldW;
      vx = -vx * kBounceLoss;
    }
    if (y < 0.0) {
      y = 0.0;
      vy = -vy * kBounceLoss;
    }
    if (y > kWorldH) {
      y = kWorldH;
      vy = -vy * kBounceLoss;
    }

    next.add(p.copyWith(x: x, y: y, vx: vx, vy: vy));
  }
  return field.copyWith(particles: next);
}
