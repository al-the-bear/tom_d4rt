/// Shape hierarchy bridged into D4rt scripts.
///
/// Shows the generator handling an abstract base class plus concrete
/// subclasses: scripts can construct `Circle`/`Rect`, call their methods, and
/// treat them polymorphically as `Shape`.
library;

import 'dart:math' as math;

import 'vector2.dart';

/// A positioned 2D shape.
abstract class Shape {
  /// The shape's centre position.
  final Vector2 center;

  const Shape(this.center);

  /// The shape's area.
  double get area;

  /// Whether [point] lies inside the shape.
  bool contains(Vector2 point);

  /// A human-readable label, e.g. `Circle(r=2.0)`.
  String describe();
}

/// A circle defined by a centre and radius.
class Circle extends Shape {
  final double radius;

  const Circle(super.center, this.radius);

  @override
  double get area => math.pi * radius * radius;

  @override
  bool contains(Vector2 point) => (point - center).magnitude <= radius;

  @override
  String describe() => 'Circle(r=${radius.toStringAsFixed(1)})';
}

/// An axis-aligned rectangle defined by a centre, width and height.
class Rect extends Shape {
  final double width;
  final double height;

  const Rect(super.center, this.width, this.height);

  @override
  double get area => width * height;

  @override
  bool contains(Vector2 point) =>
      (point.x - center.x).abs() <= width / 2 &&
      (point.y - center.y).abs() <= height / 2;

  @override
  String describe() =>
      'Rect(${width.toStringAsFixed(1)}x${height.toStringAsFixed(1)})';
}
