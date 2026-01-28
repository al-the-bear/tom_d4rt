/// Inheritance examples for bridge generation testing.
/// 
/// This file demonstrates inheritance bridging capabilities:
/// - Abstract classes
/// - Class inheritance (extends)
/// - Interface implementation (implements)
/// - Method overriding
/// - Super calls
library;

/// Abstract base class for shapes.
abstract class Shape {
  String get name;

  /// Calculate area - must be implemented by subclasses.
  double area();

  /// Calculate perimeter - must be implemented by subclasses.
  double perimeter();

  /// Description - can be overridden.
  String describe() => '$name with area ${area().toStringAsFixed(2)}';
}

/// A circle shape.
class Circle extends Shape {
  final double radius;

  Circle(this.radius);

  @override
  String get name => 'Circle';

  @override
  double area() => 3.14159 * radius * radius;

  @override
  double perimeter() => 2 * 3.14159 * radius;

  double get diameter => radius * 2;
}

/// A rectangle shape.
class Rectangle extends Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  /// Square factory constructor.
  Rectangle.square(double side)
      : width = side,
        height = side;

  @override
  String get name => 'Rectangle';

  @override
  double area() => width * height;

  @override
  double perimeter() => 2 * (width + height);

  bool get isSquare => width == height;

  @override
  String describe() {
    final shapeType = isSquare ? 'Square' : 'Rectangle';
    return '$shapeType (${width}x$height) with area ${area().toStringAsFixed(2)}';
  }
}

/// Interface for objects that can be serialized.
abstract class Serializable {
  Map<String, dynamic> toJson();
  
  /// Static method to create from JSON - implemented by each class.
  // Note: Can't declare static abstract, but subclasses implement fromJson.
}

/// Interface for objects that can be cloned.
abstract class Cloneable<T> {
  T clone();
}

/// A point implementing multiple interfaces.
class Point implements Serializable, Cloneable<Point> {
  final double x;
  final double y;

  Point(this.x, this.y);

  Point.origin()
      : x = 0,
        y = 0;

  @override
  Map<String, dynamic> toJson() => {'x': x, 'y': y};

  @override
  Point clone() => Point(x, y);

  double distanceTo(Point other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return (dx * dx + dy * dy);
  }

  Point add(Point other) => Point(x + other.x, y + other.y);

  static Point fromJson(Map<String, dynamic> json) {
    return Point(
      (json['x'] as num).toDouble(),
      (json['y'] as num).toDouble(),
    );
  }

  @override
  String toString() => 'Point($x, $y)';
}

/// Extended rectangle with color - multi-level inheritance.
class ColoredRectangle extends Rectangle implements Serializable {
  final String color;

  ColoredRectangle(super.width, super.height, this.color);

  ColoredRectangle.red(double width, double height)
      : color = 'red',
        super(width, height);

  @override
  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
        'color': color,
      };

  @override
  String describe() => '${super.describe()} in $color';
}
