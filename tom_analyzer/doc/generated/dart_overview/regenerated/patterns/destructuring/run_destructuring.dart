/// Demonstrates Dart destructuring with patterns (Dart 3.0+)
///
/// Features covered:
/// - Variable declarations with patterns
/// - Assignment with patterns
/// - For-in with patterns
/// - Function parameters (conceptual)
library;

void main() {
  print('=== Destructuring ===');
  print('');

  // Record destructuring
  print('--- Record Destructuring ---');
  var point = (10, 20);
  var (x, y) = point;
  print('point: $point -> x=$x, y=$y');

  var person = (name: 'Alice', age: 30);
  var (:name, :age) = person;
  print('person: name=$name, age=$age');

  // List destructuring
  print('');
  print('--- List Destructuring ---');
  var numbers = [1, 2, 3, 4, 5];
  var [first, second, ...rest] = numbers;
  print('numbers: $numbers');
  print('first: $first, second: $second, rest: $rest');

  var [a, _, c, ...] = numbers;
  print('a: $a, c: $c (skipped second, ignored rest)');

  // Map destructuring
  print('');
  print('--- Map Destructuring ---');
  var json = {'name': 'Bob', 'age': 25, 'city': 'NYC'};
  var {'name': userName, 'age': userAge} = json;
  print('json: $json');
  print('userName: $userName, userAge: $userAge');

  // Nested destructuring
  print('');
  print('--- Nested Destructuring ---');
  var nested = ((1, 2), (3, 4));
  var ((x1, y1), (x2, y2)) = nested;
  print('nested: $nested');
  print('Points: ($x1, $y1) and ($x2, $y2)');

  // Complex nested pattern with explicit types
  var namedPoint = (x: 10, y: 20);
  var colorList = [255, 128, 64];
  var (x: px, y: py) = namedPoint;
  var [r, g, b] = colorList;
  print('Point: ($px, $py), RGB: ($r, $g, $b)');

  // Assignment with destructuring
  print('');
  print('--- Assignment with Destructuring ---');
  var m = 1;
  var n = 2;
  print('Before swap: m=$m, n=$n');
  (m, n) = (n, m);
  print('After swap: m=$m, n=$n');

  // For-in with patterns
  print('');
  print('--- For-In with Patterns ---');
  var pairs = [
    (1, 'one'),
    (2, 'two'),
    (3, 'three')
  ];

  print('Pairs:');
  for (var (num, word) in pairs) {
    print('  $num = $word');
  }

  // Map entries
  print('');
  print('--- Map Entries with Destructuring ---');
  var scores = {'Alice': 95, 'Bob': 87, 'Charlie': 92};

  print('Scores:');
  for (var MapEntry(:key, :value) in scores.entries) {
    print('  $key: $value');
  }

  // Object destructuring
  print('');
  print('--- Object Destructuring ---');
  var rectangle = Rectangle(100, 50);
  var Rectangle(:width, :height) = rectangle;
  print('Rectangle: width=$width, height=$height');

  // With type annotations
  print('');
  print('--- With Type Annotations ---');
  var (int xCoord, int yCoord) = (100, 200);
  print('Typed: xCoord=$xCoord, yCoord=$yCoord');

  // Destructuring function returns
  print('');
  print('--- Destructuring Function Returns ---');
  var (min, max) = findMinMax([5, 2, 8, 1, 9, 3]);
  print('Min: $min, Max: $max');

  var (quotient, remainder) = divMod(17, 5);
  print('17 / 5: quotient=$quotient, remainder=$remainder');

  // Conditional destructuring
  print('');
  print('--- Conditional Destructuring ---');
  var maybePoint = getPoint(true);
  if (maybePoint case (var px2, var py2)) {
    print('Got point: ($px2, $py2)');
  }

  // Multiple levels
  print('');
  print('--- Multiple Levels ---');
  var tree = Node(
    'root',
    left: Node('left', left: Node('left-left'), right: Node('left-right')),
    right: Node('right'),
  );

  if (tree
      case Node(
        value: var root,
        left: Node(value: var left, left: Node(value: var leftLeft))
      )) {
    print('Tree path: $root -> $left -> $leftLeft');
  }

  // Extracting from list of records
  print('');
  print('--- Extracting from Records ---');
  var users = [
    (name: 'Alice', age: 30, active: true),
    (name: 'Bob', age: 25, active: false),
    (name: 'Charlie', age: 35, active: true),
  ];

  print('Active users:');
  for (var (:name, :active, age: _) in users) {
    if (active) print('  $name');
  }

  print('');
  print('=== End of Destructuring Demo ===');
}

class Rectangle {
  final int width;
  final int height;
  Rectangle(this.width, this.height);
}

(int, int) findMinMax(List<int> numbers) {
  var min = numbers.first;
  var max = numbers.first;
  for (var n in numbers) {
    if (n < min) min = n;
    if (n > max) max = n;
  }
  return (min, max);
}

(int, int) divMod(int dividend, int divisor) {
  return (dividend ~/ divisor, dividend % divisor);
}

(int, int)? getPoint(bool valid) {
  return valid ? (10, 20) : null;
}

class Node {
  final String value;
  final Node? left;
  final Node? right;
  Node(this.value, {this.left, this.right});
}
