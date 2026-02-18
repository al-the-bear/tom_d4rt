/// Demonstrates Dart member access and operator overloading
///
/// Features covered:
/// - Member access (.)
/// - Operator overloading
library;

void main() {
  print('=== Member Access and Operator Overloading ===');
  print('');

  // Member access
  print('--- Member Access (.) ---');
  var person = Person('Alice', 30);
  print('person.name: ${person.name}');
  print('person.age: ${person.age}');
  print('person.greet(): ${person.greet()}');

  // Chained member access
  var company = Company(
    'TechCorp',
    Address('NYC', 'USA'),
  );
  print('');
  print('company.name: ${company.name}');
  print('company.address.city: ${company.address.city}');
  print('company.address.country: ${company.address.country}');

  // Static member access
  print('');
  print('--- Static Member Access ---');
  print('MathConstants.pi: ${MathConstants.pi}');
  print('MathConstants.e: ${MathConstants.e}');
  print('MathConstants.goldenRatio: ${MathConstants.goldenRatio}');

  // Operator overloading
  print('');
  print('--- Operator Overloading ---');

  // Vector addition
  var v1 = Vector(1, 2);
  var v2 = Vector(3, 4);
  var sum = v1 + v2;
  print('v1: $v1');
  print('v2: $v2');
  print('v1 + v2: $sum');

  // Vector subtraction
  var diff = v2 - v1;
  print('v2 - v1: $diff');

  // Scalar multiplication
  var scaled = v1 * 3;
  print('v1 * 3: $scaled');

  // Negation
  var neg = -v1;
  print('-v1: $neg');

  // Equality
  print('');
  print('--- Equality Operator (==) ---');
  var p1 = Point(1, 2);
  var p2 = Point(1, 2);
  var p3 = Point(3, 4);
  print('p1: $p1, p2: $p2, p3: $p3');
  print('p1 == p2: ${p1 == p2}'); // true (custom ==)
  print('p1 == p3: ${p1 == p3}'); // false

  // Index operator
  print('');
  print('--- Index Operator ([]) ---');
  var matrix = Matrix([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ]);
  print('matrix[0][0]: ${matrix[0][0]}');
  print('matrix[1][2]: ${matrix[1][2]}');

  // Index assignment
  matrix[0][0] = 100;
  print('After matrix[0][0] = 100: ${matrix[0][0]}');

  // Comparison operators
  print('');
  print('--- Comparison Operators ---');
  var box1 = Box(10);
  var box2 = Box(20);
  var box3 = Box(10);
  print('box1.size: ${box1.size}, box2.size: ${box2.size}');
  print('box1 < box2: ${box1 < box2}');
  print('box1 > box2: ${box1 > box2}');
  print('box1 <= box3: ${box1 <= box3}');
  print('box1 >= box3: ${box1 >= box3}');

  // Call operator
  print('');
  print('--- Call Operator () ---');
  var greeter = Greeter('Hello');
  print(greeter('World')); // Uses call operator
  print(greeter('Dart'));

  // Money class with multiple operators
  print('');
  print('--- Complete Example: Money Class ---');
  var price1 = Money(10, 50); // $10.50
  var price2 = Money(5, 75); // $5.75
  print('price1: $price1');
  print('price2: $price2');
  print('price1 + price2: ${price1 + price2}');
  print('price1 - price2: ${price1 - price2}');
  print('price1 * 2: ${price1 * 2}');
  print('price1 > price2: ${price1 > price2}');
  print('price1 == Money(10, 50): ${price1 == Money(10, 50)}');

  print('');
  print('=== End of Member Access and Operator Overloading Demo ===');
}

// Helper classes

class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  String greet() => 'Hello, I am $name!';
}

class Address {
  final String city;
  final String country;

  Address(this.city, this.country);
}

class Company {
  final String name;
  final Address address;

  Company(this.name, this.address);
}

class MathConstants {
  static const double pi = 3.14159265359;
  static const double e = 2.71828182846;
  static const double goldenRatio = 1.61803398875;
}

class Vector {
  final double x;
  final double y;

  Vector(this.x, this.y);

  // Addition
  Vector operator +(Vector other) => Vector(x + other.x, y + other.y);

  // Subtraction
  Vector operator -(Vector other) => Vector(x - other.x, y - other.y);

  // Scalar multiplication
  Vector operator *(num scalar) => Vector(x * scalar, y * scalar);

  // Negation
  Vector operator -() => Vector(-x, -y);

  @override
  String toString() => 'Vector($x, $y)';
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Point($x, $y)';
}

class Matrix {
  final List<List<int>> _data;

  Matrix(this._data);

  List<int> operator [](int row) => _data[row];
}

class Box implements Comparable<Box> {
  final int size;

  Box(this.size);

  bool operator <(Box other) => size < other.size;
  bool operator >(Box other) => size > other.size;
  bool operator <=(Box other) => size <= other.size;
  bool operator >=(Box other) => size >= other.size;

  @override
  int compareTo(Box other) => size.compareTo(other.size);
}

class Greeter {
  final String greeting;

  Greeter(this.greeting);

  // Call operator - allows using instance like a function
  String call(String name) => '$greeting, $name!';
}

class Money implements Comparable<Money> {
  final int dollars;
  final int cents;

  Money(this.dollars, this.cents);

  int get _totalCents => dollars * 100 + cents;

  Money operator +(Money other) {
    var total = _totalCents + other._totalCents;
    return Money(total ~/ 100, total % 100);
  }

  Money operator -(Money other) {
    var total = _totalCents - other._totalCents;
    return Money(total ~/ 100, total.abs() % 100);
  }

  Money operator *(int multiplier) {
    var total = _totalCents * multiplier;
    return Money(total ~/ 100, total % 100);
  }

  bool operator <(Money other) => _totalCents < other._totalCents;
  bool operator >(Money other) => _totalCents > other._totalCents;
  bool operator <=(Money other) => _totalCents <= other._totalCents;
  bool operator >=(Money other) => _totalCents >= other._totalCents;

  @override
  bool operator ==(Object other) =>
      other is Money && other._totalCents == _totalCents;

  @override
  int get hashCode => _totalCents.hashCode;

  @override
  int compareTo(Money other) => _totalCents.compareTo(other._totalCents);

  @override
  String toString() =>
      '\$${dollars.toString()}.${cents.toString().padLeft(2, '0')}';
}
