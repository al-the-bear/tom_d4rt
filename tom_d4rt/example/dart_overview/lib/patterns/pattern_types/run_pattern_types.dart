/// Demonstrates Dart pattern types (Dart 3.0+)
///
/// Features covered:
/// - Constant patterns
/// - Variable patterns
/// - Identifier patterns
/// - Parenthesized patterns
/// - List patterns
/// - Map patterns
/// - Record patterns
/// - Object patterns
/// - Wildcard patterns
/// - Logical patterns (and, or)
/// - Cast patterns
/// - Null-check and null-assert patterns

void main() {
  print('=== Pattern Types ===');
  print('');

  // Constant patterns
  print('--- Constant Patterns ---');
  var value = 42;
  if (value case 42) {
    print('value is 42');
  }

  var status = 'success';
  var message = switch (status) {
    'success' => 'Operation completed',
    'error' => 'Operation failed',
    'pending' => 'Operation in progress',
    _ => 'Unknown status'
  };
  print('status message: $message');

  // Variable patterns
  print('');
  print('--- Variable Patterns ---');
  var point = (10, 20);
  if (point case (var x, var y)) {
    print('Point: x=$x, y=$y');
  }

  var list = [1, 2, 3];
  if (list case [var first, var second, var third]) {
    print('List: first=$first, second=$second, third=$third');
  }

  // Identifier patterns (shorthand for named fields)
  print('');
  print('--- Identifier Patterns ---');
  var record = (name: 'Alice', age: 30);
  if (record case (:var name, :var age)) {
    print('Person: name=$name, age=$age');
  }

  // List patterns
  print('');
  print('--- List Patterns ---');
  var numbers = [1, 2, 3, 4, 5];

  if (numbers case [var a, var b, ...var rest]) {
    print('First: $a, Second: $b, Rest: $rest');
  }

  if (numbers case [_, _, var third, ...]) {
    print('Third element: $third');
  }

  var empty = <int>[];
  if (empty case []) {
    print('List is empty');
  }

  // Map patterns
  print('');
  print('--- Map Patterns ---');
  var json = {'name': 'Bob', 'age': 25, 'city': 'NYC'};

  if (json case {'name': var name, 'age': var age}) {
    print('JSON: name=$name, age=$age');
  }

  var nested = {
    'user': {'id': 123, 'name': 'Charlie'}
  };
  if (nested case {'user': {'id': var id, 'name': var name}}) {
    print('Nested: id=$id, name=$name');
  }

  // Record patterns
  print('');
  print('--- Record Patterns ---');
  var coord = (x: 100, y: 200);
  var (x: px, y: py) = coord;
  print('Coordinates: px=$px, py=$py');

  var mixed = ('hello', count: 5);
  var (text, count: c) = mixed;
  print('Mixed: text=$text, count=$c');

  // Object patterns
  print('');
  print('--- Object Patterns ---');
  var person = Person('Alice', 30);

  if (person case Person(name: var n, age: var a)) {
    print('Person: name=$n, age=$a');
  }

  var people = [Person('Bob', 25), Person('Charlie', 35), Person('Alice', 30)];
  for (var p in people) {
    switch (p) {
      case Person(name: var n, age: var a) when a >= 30:
        print('$n is 30 or older');
      case Person(name: var n):
        print('$n is under 30');
    }
  }

  // Wildcard patterns
  print('');
  print('--- Wildcard Patterns ---');
  var tuple = (1, 'hello', true, 3.14);
  var (_, second, _, _) = tuple;
  print('Second element: $second');

  if (numbers case [_, _, _, ...]) {
    print('List has at least 3 elements');
  }

  // Logical-or patterns
  print('');
  print('--- Logical-Or Patterns ---');
  var testValue = 3;
  if (testValue case 1 || 2 || 3) {
    print('$testValue is 1, 2, or 3');
  }

  var weekday = 'Saturday';
  var isWeekend = switch (weekday) {
    'Saturday' || 'Sunday' => true,
    _ => false
  };
  print('$weekday is weekend: $isWeekend');

  // Logical-and patterns
  print('');
  print('--- Logical-And Patterns ---');
  var number = 15;
  if (number case > 10 && < 20) {
    print('$number is between 10 and 20');
  }

  // Cast patterns
  print('');
  print('--- Cast Patterns ---');
  Object obj = [1, 2, 3];
  if (obj case var items as List<int>) {
    print('Cast to List<int>: $items');
  }

  // Null-check patterns
  print('');
  print('--- Null-Check Patterns ---');
  String? nullable = getNullableString('hello');
  if (nullable case var s?) {
    print('Non-null value: $s');
  }

  String? nullValue = getNullableString(null);
  if (nullValue case var s?) {
    print('Should not print: $s');
  } else {
    print('Value was null');
  }

  // Null-assert patterns (use with caution)
  print('');
  print('--- Null-Assert Patterns ---');
  var nonNullValue = nullable ?? 'default';
  var (nonNull,) = (nonNullValue,);
  print('Value: $nonNull');

  // Relational patterns
  print('');
  print('--- Relational Patterns ---');
  var score = 85;
  var grade = switch (score) {
    >= 90 => 'A',
    >= 80 => 'B',
    >= 70 => 'C',
    >= 60 => 'D',
    _ => 'F'
  };
  print('Score $score = Grade $grade');

  print('');
  print('=== End of Pattern Types Demo ===');
}

class Person {
  final String name;
  final int age;
  Person(this.name, this.age);
}

// Helper function to return nullable string
String? getNullableString(String? s) => s;
