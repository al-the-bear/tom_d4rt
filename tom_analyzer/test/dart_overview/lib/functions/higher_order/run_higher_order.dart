/// Demonstrates Dart higher-order functions and function types
///
/// Features covered:
/// - Functions as first-class objects
/// - Higher-order functions
/// - Function types
/// - Tear-offs
library;

void main() {
  print('=== Higher-Order Functions and Function Types ===');
  print('');

  // Functions as first-class objects
  print('--- Functions as First-Class Objects ---');

  // Assign function to variable
  int Function(int, int) operation = add;
  print('operation(5, 3) with add: ${operation(5, 3)}');

  operation = multiply;
  print('operation(5, 3) with multiply: ${operation(5, 3)}');

  // Store functions in collections
  var operations = <String, int Function(int, int)>{
    'add': add,
    'subtract': subtract,
    'multiply': multiply,
    'divide': intDivide,
  };

  print('');
  print('Executing operations from map:');
  operations.forEach((name, op) {
    print('  $name(10, 2) = ${op(10, 2)}');
  });

  // Higher-order functions
  print('');
  print('--- Higher-Order Functions ---');

  // Function that takes a function
  var numbers = [1, 2, 3, 4, 5];

  var result = applyToAll(numbers, (n) => n * 2);
  print('applyToAll([1,2,3,4,5], n*2): $result');

  result = applyToAll(numbers, square);
  print('applyToAll([1,2,3,4,5], square): $result');

  // Function that returns a function
  print('');
  print('--- Function Returning Function ---');
  var greetEnglish = makeGreeter('Hello');
  var greetSpanish = makeGreeter('Hola');
  print(greetEnglish('Alice'));
  print(greetSpanish('Alice'));

  // Parameterized function factory
  var multiplyBy2 = makeMultiplier(2);
  var multiplyBy10 = makeMultiplier(10);
  print('multiplyBy2(5) = ${multiplyBy2(5)}');
  print('multiplyBy10(5) = ${multiplyBy10(5)}');

  // Function types
  print('');
  print('--- Function Types ---');

  // Using typedef for clarity
  Calculator calc = add;
  print('calc(7, 3) = ${calc(7, 3)}');

  bool isPositive(Object? n) => n is num && n > 0;
  print('isPositive(5) = ${isPositive(5)}');
  print('isPositive(-3) = ${isPositive(-3)}');

  Object? getLength(Object? s) => s is String ? s.length : null;
  print('getLength("Hello") = ${getLength('Hello')}');

  // Tear-offs
  print('');
  print('--- Tear-offs ---');

  // Method tear-off
  var numbers2 = [1, 2, 3, 4, 5];

  // Instead of: numbers.forEach((n) => print(n))
  numbers2.forEach(print); // print is a tear-off
  print('');

  // Static method tear-off
  var words = ['hello', 'world'];
  var parsed = words.map(int.tryParse).toList();
  print('Parsing ["hello", "world"] as int: $parsed');

  // Instance method tear-off
  var helper = StringHelper();
  var items = ['  hello  ', '  world  '];
  var trimmed = items.map(helper.process).toList();
  print('Trimmed and uppercased: $trimmed');

  // Constructor tear-off
  print('');
  print('--- Constructor Tear-offs ---');
  var names = ['Alice', 'Bob', 'Charlie'];
  var people = names.map(Person.new).toList();
  print('Created people: $people');

  // Named constructor tear-off
  var configs = [
    {'name': 'Config1'},
    {'name': 'Config2'},
  ];
  var settings = configs.map(Settings.fromMap).toList();
  print('Created settings: $settings');

  // Combining higher-order functions
  print('');
  print('--- Combining Functions ---');
  var data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  var result2 = data
      .where((n) => n % 2 == 0) // Keep even
      .map((n) => n * n) // Square
      .where((n) => n > 10) // Keep > 10
      .toList();
  print('Even squares > 10: $result2');

  // Custom higher-order function
  print('');
  print('--- Custom Pipeline ---');
  var pipeline = compose([
    (int n) => n * 2,
    (int n) => n + 10,
    (int n) => n * n,
  ]);
  print('Pipeline (5): ${pipeline(5)}');
  // (5 * 2) = 10, (10 + 10) = 20, (20 * 20) = 400

  print('');
  print('=== End of Higher-Order Functions Demo ===');
}

// Basic functions
int add(int a, int b) => a + b;
int subtract(int a, int b) => a - b;
int multiply(int a, int b) => a * b;
int intDivide(int a, int b) => a ~/ b;
int square(int n) => n * n;

// Higher-order function: takes a function
List<int> applyToAll(List<int> numbers, int Function(int) f) {
  return numbers.map(f).toList();
}

// Higher-order function: returns a function
String Function(String) makeGreeter(String greeting) {
  return (String name) => '$greeting, $name!';
}

int Function(int) makeMultiplier(int factor) {
  return (int n) => n * factor;
}

// Function type aliases
typedef Calculator = int Function(int, int);
typedef Predicate<T> = bool Function(T);
typedef Transformer<I, O> = O Function(I);

// Helper class for tear-off example
class StringHelper {
  String process(String s) => s.trim().toUpperCase();
}

// Classes for constructor tear-off example
class Person {
  final String name;
  Person(this.name);

  @override
  String toString() => 'Person($name)';
}

class Settings {
  final String name;
  Settings(this.name);

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(map['name'] as String);
  }

  @override
  String toString() => 'Settings($name)';
}

// Function composition
int Function(int) compose(List<int Function(int)> functions) {
  return (int value) {
    var result = value;
    for (var f in functions) {
      result = f(result);
    }
    return result;
  };
}
