/// Demonstrates Dart typedefs
///
/// Features covered:
/// - Function typedefs
/// - Generic typedefs
/// - Inline function types
/// - Type aliases
/// - Practical examples

void main() {
  print('=== Typedefs ===');
  print('');

  // Basic function typedef
  print('--- Function Typedefs ---');

  IntOperation add = (a, b) => a + b;
  IntOperation multiply = (a, b) => a * b;
  IntOperation subtract = (a, b) => a - b;

  print('typedef IntOperation = int Function(int, int);');
  print('');
  print('add(5, 3): ${add(5, 3)}');
  print('multiply(5, 3): ${multiply(5, 3)}');
  print('subtract(5, 3): ${subtract(5, 3)}');

  // String operation
  print('');
  StringTransformer toUpper = (s) => s.toUpperCase();
  StringTransformer toLower = (s) => s.toLowerCase();
  StringTransformer reverse = (s) => s.split('').reversed.join();

  print('typedef StringTransformer = String Function(String);');
  print('');
  print('toUpper("hello"): ${toUpper("hello")}');
  print('toLower("HELLO"): ${toLower("HELLO")}');
  print('reverse("hello"): ${reverse("hello")}');

  // Void callbacks
  print('');
  print('--- Callback Typedefs ---');
  VoidCallback callback = () => print('Callback executed!');
  callback();

  ValueCallback<String> stringCallback = (v) => print('Received: $v');
  stringCallback('test message');

  // Generic typedefs
  print('');
  print('--- Generic Typedefs ---');

  Comparator<int> intCompare = (a, b) => a.compareTo(b);
  Comparator<String> strCompare = (a, b) => a.compareTo(b);

  print('typedef Comparator<T> = int Function(T a, T b);');
  print('');
  print('intCompare(5, 3): ${intCompare(5, 3)}');
  print('intCompare(3, 5): ${intCompare(3, 5)}');
  print('intCompare(5, 5): ${intCompare(5, 5)}');
  print('strCompare("a", "b"): ${strCompare("a", "b")}');
  print('strCompare("b", "a"): ${strCompare("b", "a")}');

  // Mapper typedef
  print('');
  Mapper<int, String> intToString = (i) => 'Number: $i';
  Mapper<String, int> stringLength = (s) => s.length;

  print('typedef Mapper<T, R> = R Function(T input);');
  print('');
  print('intToString(42): ${intToString(42)}');
  print('stringLength("hello"): ${stringLength("hello")}');

  // Predicate typedef
  print('');
  Predicate<int> isEven = (n) => n % 2 == 0;
  Predicate<int> isPositive = (n) => n > 0;
  Predicate<String> isEmpty = (s) => s.isEmpty;

  print('typedef Predicate<T> = bool Function(T value);');
  print('');
  print('isEven(4): ${isEven(4)}');
  print('isEven(5): ${isEven(5)}');
  print('isPositive(-5): ${isPositive(-5)}');
  print('isEmpty(""): ${isEmpty("")}');

  // Type aliases for complex types
  print('');
  print('--- Type Aliases ---');

  JsonMap data = {'name': 'Alice', 'age': 30};
  print('typedef JsonMap = Map<String, dynamic>;');
  print('JsonMap data = $data');

  JsonList items = ['a', 1, true, null];
  print('typedef JsonList = List<dynamic>;');
  print('JsonList items = $items');

  StringList names = ['Alice', 'Bob', 'Charlie'];
  print('typedef StringList = List<String>;');
  print('StringList names = $names');

  IntSet numbers = {1, 2, 3, 4, 5};
  print('typedef IntSet = Set<int>;');
  print('IntSet numbers = $numbers');

  // Nullable typedefs
  print('');
  print('--- Nullable Typedefs ---');
  NullableString value = 'hello';
  NullableString nullValue;

  print('typedef NullableString = String?;');
  print('value: $value');
  print('nullValue: $nullValue');

  // Function with optional params
  print('');
  print('--- Complex Function Types ---');

  ConfiguredAction configAction = ({bool verbose = false}) {
    print('Action executed, verbose: $verbose');
  };
  print('ConfiguredAction({verbose: false})');
  configAction();
  configAction(verbose: true);

  // Using typedefs with classes
  print('');
  print('--- Typedefs with Classes ---');

  var processor = DataProcessor<int, String>(
    (input) => 'Processed: $input',
  );
  print('Result: ${processor.process(42)}');

  var validator = Validator<String>(
    (input) => input.isNotEmpty,
    (input) => 'Value: $input is valid',
  );
  print('Is valid: ${validator.isValid("test")}');
  print('Message: ${validator.format("test")}');

  // Factory typedefs
  print('');
  print('--- Factory Typedefs ---');
  Factory<User> userFactory = () => User('New User', 0);
  var newUser = userFactory();
  print('Created user: ${newUser.name}, id: ${newUser.id}');

  ParameterizedFactory<User, String> namedFactory = (name) => User(name, 1);
  var alice = namedFactory('Alice');
  print('Created user: ${alice.name}, id: ${alice.id}');

  // Async typedefs
  print('');
  print('--- Async Typedefs ---');
  print('typedef AsyncCallback = Future<void> Function();');
  print('typedef AsyncValueGetter<T> = Future<T> Function();');
  print('typedef AsyncMapper<T, R> = Future<R> Function(T input);');

  // Using with higher-order functions
  print('');
  print('--- With Higher-Order Functions ---');

  var list = [1, 2, 3, 4, 5];
  print('Original: $list');

  var doubled = applyToAll(list, (x) => x * 2);
  print('Doubled: $doubled');

  var filtered = filterBy(list, isEven);
  print('Even only: $filtered');

  var combined = combineWith(list, 0, add);
  print('Sum: $combined');

  // Inline vs typedef
  print('');
  print('--- Inline vs Typedef ---');
  print('');
  print('Inline:');
  print('  void execute(int Function(int, int) operation)');
  print('');
  print('Typedef:');
  print('  typedef IntOperation = int Function(int, int);');
  print('  void execute(IntOperation operation)');
  print('');
  print('Benefits of typedef:');
  print('  - More readable');
  print('  - Reusable');
  print('  - Self-documenting');
  print('  - Easier refactoring');

  print('');
  print('=== End of Typedefs Demo ===');
}

// Basic function typedefs
typedef IntOperation = int Function(int a, int b);
typedef StringTransformer = String Function(String input);

// Callback typedefs
typedef VoidCallback = void Function();
typedef ValueCallback<T> = void Function(T value);

// Generic typedefs
typedef Comparator<T> = int Function(T a, T b);
typedef Mapper<T, R> = R Function(T input);
typedef Predicate<T> = bool Function(T value);

// Type aliases for collections
typedef JsonMap = Map<String, dynamic>;
typedef JsonList = List<dynamic>;
typedef StringList = List<String>;
typedef IntSet = Set<int>;

// Nullable type alias
typedef NullableString = String?;

// Complex function typedef
typedef ConfiguredAction = void Function({bool verbose});

// Factory typedefs
typedef Factory<T> = T Function();
typedef ParameterizedFactory<T, P> = T Function(P parameter);

// Async typedefs (for reference)
typedef AsyncCallback = Future<void> Function();
typedef AsyncValueGetter<T> = Future<T> Function();
typedef AsyncMapper<T, R> = Future<R> Function(T input);

// Generic class using typedef
class DataProcessor<I, O> {
  final Mapper<I, O> _mapper;

  DataProcessor(this._mapper);

  O process(I input) => _mapper(input);
}

// Class using multiple typedefs
class Validator<T> {
  final Predicate<T> isValid;
  final Mapper<T, String> format;

  Validator(this.isValid, this.format);
}

// Simple user class for factory example
class User {
  final String name;
  final int id;

  User(this.name, this.id);
}

// Higher-order functions using typedefs
List<R> applyToAll<T, R>(List<T> items, Mapper<T, R> mapper) {
  return items.map(mapper).toList();
}

List<T> filterBy<T>(List<T> items, Predicate<T> predicate) {
  return items.where(predicate).toList();
}

R combineWith<T, R>(List<T> items, R initial, R Function(R, T) combiner) {
  return items.fold(initial, combiner);
}
