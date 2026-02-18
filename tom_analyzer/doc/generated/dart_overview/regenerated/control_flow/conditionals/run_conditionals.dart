/// Demonstrates Dart conditional statements
///
/// Features covered:
/// - if statement
/// - if-else
/// - if-else if-else chain
/// - if-case (pattern matching)
library;

// Helper functions to prevent compile-time optimization
bool getBool(bool b) => b;
String? getString(String? s) => s;

void main() {
  print('=== Conditional Statements ===');
  print('');

  // Basic if
  print('--- Basic if ---');
  int score = 85;
  if (score >= 60) {
    print('Score $score: Passed!');
  }

  score = 45;
  if (score >= 60) {
    print('Score $score: Passed!');
  }
  print('(No output for score 45 - condition not met)');

  // if-else
  print('');
  print('--- if-else ---');
  int age = 20;
  if (age >= 18) {
    print('Age $age: Adult');
  } else {
    print('Age $age: Minor');
  }

  age = 15;
  if (age >= 18) {
    print('Age $age: Adult');
  } else {
    print('Age $age: Minor');
  }

  // if-else if-else chain
  print('');
  print('--- if-else if-else chain ---');
  void printGrade(int score) {
    if (score >= 90) {
      print('Score $score: Grade A');
    } else if (score >= 80) {
      print('Score $score: Grade B');
    } else if (score >= 70) {
      print('Score $score: Grade C');
    } else if (score >= 60) {
      print('Score $score: Grade D');
    } else {
      print('Score $score: Grade F');
    }
  }

  printGrade(95);
  printGrade(82);
  printGrade(73);
  printGrade(65);
  printGrade(42);

  // Nested if
  print('');
  print('--- Nested if ---');
  bool isLoggedIn = getBool(true);
  bool isAdmin = getBool(true);
  bool hasPermission = getBool(false);

  if (isLoggedIn) {
    print('User is logged in');
    if (isAdmin) {
      print('User is admin - full access');
    } else if (hasPermission) {
      print('User has specific permission');
    } else {
      print('User has limited access');
    }
  } else {
    print('Please log in');
  }

  // Conditional expression in if
  print('');
  print('--- Complex Conditions ---');
  int temperature = 25;
  bool isRaining = false;

  if (temperature > 20 && temperature < 30 && !isRaining) {
    print('Perfect weather for a walk!');
  }

  if (temperature < 0 || temperature > 40) {
    print('Extreme temperature!');
  } else {
    print('Temperature is moderate');
  }

  // if with null check
  print('');
  print('--- if with Null Check ---');
  String? name = getString('Alice');
  if (name != null && name.isNotEmpty) {
    print('Hello, $name!');
  }

  name = getString(null);
  if (name != null && name.isNotEmpty) {
    print('Hello, $name!');
  } else {
    print('Hello, Guest!');
  }

  // if-case (Dart 3 pattern matching)
  print('');
  print('--- if-case (Pattern Matching) ---');

  // Type checking with pattern
  Object value = 'Hello';
  if (value case String s) {
    print('String value: ${s.toUpperCase()}');
  }

  // Destructuring with pattern
  var point = (3, 4);
  if (point case (int x, int y)) {
    print('Point coordinates: x=$x, y=$y');
  }

  // Map pattern
  var json = {'name': 'Bob', 'age': 30};
  if (json case {'name': String n, 'age': int a}) {
    print('Person: $n, age $a');
  }

  // Pattern with when clause
  var number = 42;
  if (number case int n when n > 0) {
    print('Positive number: $n');
  }

  // Object pattern
  var person = Person('Charlie', 25);
  if (person case Person(name: var n, age: var a) when a >= 18) {
    print('Adult: $n');
  }

  print('');
  print('=== End of Conditional Statements Demo ===');
}

class Person {
  final String name;
  final int age;
  Person(this.name, this.age);
}
