/// Demonstrates Dart constructors in detail
///
/// Features covered:
/// - Default constructor
/// - Parameterized constructor
/// - Named constructors
/// - Initializer lists
/// - Redirecting constructors
/// - Const constructors
/// - Factory constructors
library;

void main() {
  print('=== Constructors ===');
  print('');

  // Default constructor (auto-generated if none defined)
  print('--- Default Constructor ---');
  var point1 = SimplePoint();
  print('SimplePoint: (${point1.x}, ${point1.y})');

  // Parameterized constructor
  print('');
  print('--- Parameterized Constructor ---');
  var point2 = Point(3, 4);
  print('Point(3, 4): (${point2.x}, ${point2.y})');

  // Named constructor
  print('');
  print('--- Named Constructors ---');
  var origin = Point.origin();
  var fromJson = Point.fromJson({'x': 5, 'y': 6});
  print('Point.origin(): (${origin.x}, ${origin.y})');
  print('Point.fromJson: (${fromJson.x}, ${fromJson.y})');

  // Initializer list
  print('');
  print('--- Initializer List ---');
  var rect = RectangleArea(4, 3);
  print('Rectangle 4x3, area: ${rect.area}');

  // Initializer list with assertions
  var positive = PositiveNumber(42);
  print('PositiveNumber: ${positive.value}');

  // Redirecting constructor
  print('');
  print('--- Redirecting Constructor ---');
  var vec1 = Vector.zero();
  var vec2 = Vector.unit();
  print('Vector.zero(): ${vec1.x}, ${vec1.y}');
  print('Vector.unit(): ${vec2.x}, ${vec2.y}');

  // Const constructor
  print('');
  print('--- Const Constructor ---');
  const color1 = Color(255, 0, 0);
  const color2 = Color(255, 0, 0);
  const color3 = Color.red;

  print('color1: ${color1.r}, ${color1.g}, ${color1.b}');
  print('identical(color1, color2): ${identical(color1, color2)}');
  print('identical(color1, Color.red): ${identical(color1, color3)}');

  // Factory constructor
  print('');
  print('--- Factory Constructor ---');
  var logger1 = Logger('App');
  var logger2 = Logger('App');
  var logger3 = Logger('Database');

  print('logger1 name: ${logger1.name}');
  print('identical(logger1, logger2): ${identical(logger1, logger2)}');
  print('identical(logger1, logger3): ${identical(logger1, logger3)}');

  // Factory with subclass selection
  print('');
  print('--- Factory with Subclass ---');
  Shape circle = Shape.create('circle', 5);
  Shape square = Shape.create('square', 4);
  print('Circle area: ${circle.area}');
  print('Square area: ${square.area}');

  // Private constructor pattern
  print('');
  print('--- Private Constructor (Singleton) ---');
  var db1 = Database.instance;
  var db2 = Database.instance;
  print('db1.name: ${db1.name}');
  print('identical(db1, db2): ${identical(db1, db2)}');

  // Super constructor
  print('');
  print('--- Super Constructor ---');
  var employee = Employee('Alice', 30, 'Engineering');
  print('Employee: ${employee.name}, ${employee.age}, ${employee.department}');

  // Initializing formal parameters with super
  var manager = Manager('Bob', 45, 'Sales', 10);
  print('Manager: ${manager.name}, team size: ${manager.teamSize}');

  print('');
  print('=== End of Constructors Demo ===');
}

// Default constructor (implicit)
class SimplePoint {
  int x = 0;
  int y = 0;
}

// Parameterized constructor with initializing formals
class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  // Named constructors
  Point.origin()
      : x = 0,
        y = 0;

  Point.fromJson(Map<String, dynamic> json)
      : x = json['x'] as int,
        y = json['y'] as int;
}

// Initializer list
class RectangleArea {
  final int width;
  final int height;
  final int area;

  RectangleArea(this.width, this.height) : area = width * height;
}

// Initializer list with assertions
class PositiveNumber {
  final int value;

  PositiveNumber(this.value) : assert(value > 0, 'Value must be positive');
}

// Redirecting constructor
class Vector {
  final double x;
  final double y;

  Vector(this.x, this.y);

  // Redirecting to main constructor
  Vector.zero() : this(0, 0);
  Vector.unit() : this(1, 1);
}

// Const constructor
class Color {
  final int r;
  final int g;
  final int b;

  const Color(this.r, this.g, this.b);

  static const Color red = Color(255, 0, 0);
  static const Color green = Color(0, 255, 0);
  static const Color blue = Color(0, 0, 255);
}

// Factory constructor - singleton pattern
class Logger {
  final String name;
  static final Map<String, Logger> _cache = {};

  // Private constructor
  Logger._internal(this.name);

  // Factory returns cached or new instance
  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }
}

// Factory constructor - subclass selection
abstract class Shape {
  double get area;

  factory Shape.create(String type, double dimension) {
    switch (type) {
      case 'circle':
        return CircleShape(dimension);
      case 'square':
        return SquareShape(dimension);
      default:
        throw ArgumentError('Unknown shape: $type');
    }
  }
}

class CircleShape implements Shape {
  final double radius;
  CircleShape(this.radius);

  @override
  double get area => 3.14159 * radius * radius;
}

class SquareShape implements Shape {
  final double side;
  SquareShape(this.side);

  @override
  double get area => side * side;
}

// Private constructor with static instance (singleton)
class Database {
  final String name = 'MainDB';

  Database._internal();

  static final Database instance = Database._internal();
}

// Super constructor
class PersonBase {
  final String name;
  final int age;

  PersonBase(this.name, this.age);
}

class Employee extends PersonBase {
  final String department;

  Employee(super.name, super.age, this.department);
}

// Super parameters (Dart 2.17+)
class Manager extends PersonBase {
  final int teamSize;

  Manager(super.name, super.age, String department, this.teamSize);
}
