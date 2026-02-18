/// Demonstrates Dart switch expressions (Dart 3)
///
/// Features covered:
/// - Basic switch expression
/// - Pattern matching in switch expressions
/// - when clauses (guards)
/// - Exhaustiveness checking
/// - Multi-pattern cases
library;

void main() {
  print('=== Switch Expressions (Dart 3) ===');
  print('');

  // Basic switch expression
  print('--- Basic Switch Expression ---');
  String grade = 'B';

  String message = switch (grade) {
    'A' => 'Excellent!',
    'B' => 'Good job!',
    'C' => 'Satisfactory',
    'D' => 'Needs improvement',
    'F' => 'Failed',
    _ => 'Invalid grade',
  };
  print('Grade $grade: $message');

  // Switch expression vs ternary
  print('');
  print('--- Replacing Nested Ternary ---');
  int dayNumber = 3;

  // Instead of: dayNumber == 6 || dayNumber == 7 ? 'Weekend' : 'Weekday'
  String dayType = switch (dayNumber) {
    6 || 7 => 'Weekend',
    >= 1 && <= 5 => 'Weekday',
    _ => 'Invalid',
  };
  print('Day $dayNumber: $dayType');

  // Switch expression with type patterns
  print('');
  print('--- Type Patterns ---');
  Object value = 42;

  String description = switch (value) {
    int i => 'Integer: $i',
    double d => 'Double: $d',
    String s => 'String of length ${s.length}',
    List l => 'List with ${l.length} items',
    _ => 'Unknown type: ${value.runtimeType}',
  };
  print(description);

  // With when guards
  print('');
  print('--- when Guards ---');
  int score = 85;

  String gradeFromScore = switch (score) {
    >= 90 => 'A',
    >= 80 => 'B',
    >= 70 => 'C',
    >= 60 => 'D',
    _ => 'F',
  };
  print('Score $score: Grade $gradeFromScore');

  // More complex guards
  int number = -5;
  String numType = switch (number) {
    0 => 'zero',
    int n when n > 0 && n % 2 == 0 => 'positive even',
    int n when n > 0 => 'positive odd',
    int n when n < 0 && n % 2 == 0 => 'negative even',
    _ => 'negative odd',
  };
  print('Number $number is: $numType');

  // Exhaustive switch with enum
  print('');
  print('--- Exhaustive Switch on Enum ---');
  Color color = Color.yellow;

  // No default needed - all cases covered
  String action = switch (color) {
    Color.red => 'Stop!',
    Color.yellow => 'Caution!',
    Color.green => 'Go!',
  };
  print('Color $color: $action');

  // Exhaustive with sealed class
  print('');
  print('--- Exhaustive with Sealed Class ---');
  Shape shape = Circle(5);

  double area = switch (shape) {
    Circle(:var radius) => 3.14159 * radius * radius,
    Rectangle(:var width, :var height) => width * height,
    Triangle(:var base, :var height) => 0.5 * base * height,
  };
  print('Shape area: $area');

  // Record patterns
  print('');
  print('--- Record Patterns ---');
  var point = (3, 4);

  String location = switch (point) {
    (0, 0) => 'origin',
    (var x, 0) => 'x-axis at $x',
    (0, var y) => 'y-axis at $y',
    (var x, var y) when x == y => 'diagonal at $x',
    (var x, var y) => 'point at ($x, $y)',
  };
  print('Point $point: $location');

  // List patterns
  print('');
  print('--- List Patterns ---');
  var list = [1, 2, 3];

  String listDesc = switch (list) {
    [] => 'empty',
    [var single] => 'single element: $single',
    [var first, var second] => 'two elements: $first, $second',
    [var first, ...var rest] => 'starts with $first, rest: $rest',
  };
  print('List $list: $listDesc');

  // Map patterns
  print('');
  print('--- Map Patterns ---');
  var json = {'type': 'user', 'name': 'Alice', 'age': 30};

  String parsed = switch (json) {
    {'type': 'user', 'name': String name, 'age': int age} =>
      'User: $name, age $age',
    {'type': 'admin', 'name': String name} => 'Admin: $name',
    {'error': String msg} => 'Error: $msg',
    _ => 'Unknown format',
  };
  print('Parsed: $parsed');

  // Multi-pattern cases (OR patterns)
  print('');
  print('--- Multi-Pattern Cases ---');
  String httpMethod = 'PUT';

  bool modifiesData = switch (httpMethod) {
    'POST' || 'PUT' || 'PATCH' || 'DELETE' => true,
    'GET' || 'HEAD' || 'OPTIONS' => false,
    _ => false,
  };
  print('$httpMethod modifies data: $modifiesData');

  // Nested patterns
  print('');
  print('--- Nested Patterns ---');
  var data = ('user', {'name': 'Bob', 'active': true});

  String result = switch (data) {
    ('user', {'name': String n, 'active': true}) => 'Active user: $n',
    ('user', {'name': String n, 'active': false}) => 'Inactive user: $n',
    ('admin', _) => 'Administrator',
    _ => 'Unknown',
  };
  print('Result: $result');

  // Using switch expression in other expressions
  print('');
  print('--- Switch in Expressions ---');
  int statusCode = 200;

  print('Status $statusCode: ${switch (statusCode) {
    200 => 'OK',
    201 => 'Created',
    400 => 'Bad Request',
    404 => 'Not Found',
    500 => 'Server Error',
    _ => 'Unknown',
  }}');

  print('');
  print('=== End of Switch Expressions Demo ===');
}

enum Color { red, yellow, green }

sealed class Shape {}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

class Rectangle extends Shape {
  final double width;
  final double height;
  Rectangle(this.width, this.height);
}

class Triangle extends Shape {
  final double base;
  final double height;
  Triangle(this.base, this.height);
}
