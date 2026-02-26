/// Demonstrates Dart pattern matching with switch (Dart 3.0+)
///
/// Features covered:
/// - Switch expressions
/// - Switch statements with patterns
/// - Exhaustiveness checking
/// - Guards (when clause)
/// - Complex pattern matching

void main() {
  print('=== Switch Patterns ===');
  print('');

  // Basic switch expression
  print('--- Basic Switch Expression ---');
  var day = 3;
  var dayName = switch (day) {
    1 => 'Monday',
    2 => 'Tuesday',
    3 => 'Wednesday',
    4 => 'Thursday',
    5 => 'Friday',
    6 => 'Saturday',
    7 => 'Sunday',
    _ => 'Invalid'
  };
  print('Day $day is $dayName');

  // Type checking patterns
  print('');
  print('--- Type Checking Patterns ---');
  Object value = [1, 2, 3];
  var description = switch (value) {
    int n => 'Integer: $n',
    String s => 'String: $s',
    List<int> l => 'Int list with ${l.length} elements',
    List l => 'List with ${l.length} elements',
    _ => 'Unknown type'
  };
  print('value: $description');

  // Record patterns in switch
  print('');
  print('--- Record Patterns in Switch ---');
  var result = (status: 'success', code: 200, data: 'Hello');
  var response = switch (result) {
    (status: 'success', code: 200, data: var d) => 'OK: $d',
    (status: 'success', code: var c, data: var d) => 'Success ($c): $d',
    (status: 'error', code: var c, data: _) => 'Error: $c',
    _ => 'Unknown'
  };
  print('Response: $response');

  // Guards (when clause)
  print('');
  print('--- Guards (when clause) ---');
  var numbers = [1, 2, 3, 4, 5];
  for (var n in numbers) {
    var category = switch (n) {
      var x when x.isEven => '$x is even',
      var x when x == 1 => '$x is one',
      var x when x % 3 == 0 => '$x is divisible by 3',
      _ => '$n is odd'
    };
    print(category);
  }

  // List patterns in switch
  print('');
  print('--- List Patterns in Switch ---');
  var lists = [
    <int>[],
    [1],
    [1, 2],
    [1, 2, 3],
    [1, 2, 3, 4, 5]
  ];

  for (var list in lists) {
    var desc = switch (list) {
      [] => 'Empty list',
      [var x] => 'Single element: $x',
      [var x, var y] => 'Two elements: $x, $y',
      [var first, ..., var last] => 'First: $first, Last: $last',
    };
    print('$list -> $desc');
  }

  // Object patterns in switch
  print('');
  print('--- Object Patterns in Switch ---');
  var shapes = <Shape>[
    Circle(5),
    Rectangle(4, 3),
    Triangle(3, 4, 5),
  ];

  for (var shape in shapes) {
    var desc = switch (shape) {
      Circle(radius: var r) => 'Circle with radius $r, area ${3.14 * r * r}',
      Rectangle(width: var w, height: var h) => 'Rectangle ${w}x$h, area ${w * h}',
      Triangle(a: var a, b: var b, c: var c) => 'Triangle with sides $a, $b, $c',
    };
    print(desc);
  }

  // Exhaustiveness with sealed classes
  print('');
  print('--- Exhaustiveness with Sealed Classes ---');
  var results = <Result>[
    Success(42),
    Error('Something went wrong'),
    Loading(),
  ];

  for (var result in results) {
    // Compiler ensures all cases are covered
    var output = switch (result) {
      Success(value: var v) => 'Success: $v',
      Error(message: var m) => 'Error: $m',
      Loading() => 'Loading...',
    };
    print(output);
  }

  // Complex nested patterns
  print('');
  print('--- Complex Nested Patterns ---');
  var data = {
    'user': {
      'name': 'Alice',
      'settings': {'theme': 'dark', 'notifications': true}
    }
  };

  var theme = switch (data) {
    {'user': {'settings': {'theme': var t}}} => t,
    _ => 'default'
  };
  print('Theme: $theme');

  // Switch statement with patterns
  print('');
  print('--- Switch Statement with Patterns ---');
  Object input = 'hello';

  switch (input) {
    case int n when n < 0:
      print('Negative number: $n');
    case int n:
      print('Positive number: $n');
    case String s when s.isEmpty:
      print('Empty string');
    case String s:
      print('String: $s (length: ${s.length})');
    case List l when l.isEmpty:
      print('Empty list');
    case List l:
      print('List with ${l.length} elements');
    default:
      print('Unknown type');
  }

  // If-case with patterns
  print('');
  print('--- If-Case with Patterns ---');
  var json = {'type': 'user', 'name': 'Bob', 'age': 25};

  if (json case {'type': 'user', 'name': String name, 'age': int age}) {
    print('User: $name, Age: $age');
  }

  // Pattern with logical operators
  print('');
  print('--- Logical Pattern Operators ---');
  var httpCodes = [200, 201, 404, 500, 503];

  for (var code in httpCodes) {
    var status = switch (code) {
      200 || 201 => 'Success',
      >= 400 && < 500 => 'Client Error',
      >= 500 => 'Server Error',
      _ => 'Unknown'
    };
    print('HTTP $code: $status');
  }

  print('');
  print('=== End of Switch Patterns Demo ===');
}

// Shape hierarchy
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
  final double a;
  final double b;
  final double c;
  Triangle(this.a, this.b, this.c);
}

// Result hierarchy
sealed class Result {}

class Success extends Result {
  final int value;
  Success(this.value);
}

class Error extends Result {
  final String message;
  Error(this.message);
}

class Loading extends Result {}
