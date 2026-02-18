/// Demonstrates Dart type operators
///
/// Features covered:
/// - Type test (is)
/// - Negated type test (is!)
/// - Type cast (as)
library;

void main() {
  print('=== Type Operators ===');
  print('');

  // Type test (is)
  print('--- Type Test (is) ---');

  Object value = 'Hello';
  print('value = $value');
  print('value is String: ${value is String}'); // true
  print('value is int: ${value is int}'); // false
  // Note: Every value is an Object in Dart

  // Type promotion after is check
  if (value is String) {
    // value is promoted to String here
    print('Length: ${value.length}'); // Can access String methods
    print('Uppercase: ${value.toUpperCase()}');
  }

  // Testing various types
  print('');
  print('--- Testing Various Types ---');

  void checkType(Object obj) {
    print('Checking: $obj');
    if (obj is int) {
      print('  -> int, doubled: ${obj * 2}');
    } else if (obj is double) {
      print('  -> double, halved: ${obj / 2}');
    } else if (obj is String) {
      print('  -> String, length: ${obj.length}');
    } else if (obj is List) {
      print('  -> List, isEmpty: ${obj.isEmpty}');
    } else if (obj is Map) {
      print('  -> Map, keys: ${obj.keys.toList()}');
    } else {
      print('  -> Unknown type: ${obj.runtimeType}');
    }
  }

  checkType(42);
  checkType(3.14);
  checkType('Dart');
  checkType([1, 2, 3]);
  checkType({'a': 1, 'b': 2});
  checkType(DateTime.now());

  // Negated type test (is!)
  print('');
  print('--- Negated Type Test (is!) ---');

  Object item = 123;
  print('item = $item');
  print('item is! String: ${item is! String}'); // true
  print('item is! int: ${item is! int}'); // false

  // Using is! in conditions
  void processIfNotNull(Object? obj) {
    if (obj is! String) {
      print('Not a string: $obj');
      return;
    }
    // obj is promoted to String here
    print('Processing string: ${obj.toUpperCase()}');
  }

  processIfNotNull(42);
  processIfNotNull('hello');
  processIfNotNull(null);

  // Type cast (as)
  print('');
  print('--- Type Cast (as) ---');

  Object stringObj = 'Cast me';
  String str = stringObj as String;
  print('Cast to String: $str');

  // Cast with generics
  Object listObj = [1, 2, 3];
  List<int> intList = listObj as List<int>;
  print('Cast to List<int>: $intList');

  // Safe casting pattern
  print('');
  print('--- Safe Casting Pattern ---');

  Object maybeInt = 42;

  // Unsafe: would throw if wrong type
  // int unsafe = maybeInt as int;

  // Safe: check first
  int? safeInt = maybeInt is int ? maybeInt : null;
  print('Safe cast result: $safeInt');

  Object notAnInt = 'not an int';
  int? safeFail = notAnInt is int ? notAnInt : null;
  print('Safe cast of non-int: $safeFail');

  // Casting with nullable types
  print('');
  print('--- Casting with Nullable Types ---');

  Object? nullableObj = 'I might be null';
  String? nullableStr = nullableObj as String?;
  print('Cast to String?: $nullableStr');

  nullableObj = null;
  nullableStr = nullableObj as String?;
  print('Cast null to String?: $nullableStr');

  // Hierarchy casting
  print('');
  print('--- Hierarchy Casting ---');

  Animal animal = Dog('Buddy');
  print('animal.speak(): ${animal.speak()}');

  // Downcast to access subclass methods
  if (animal is Dog) {
    print('animal.fetch(): ${animal.fetch()}');
  }

  // Using as for downcast (when sure of type)
  Dog dog = animal as Dog;
  print('Downcast dog.name: ${dog.name}');

  // Pattern matching alternative (Dart 3+)
  print('');
  print('--- Pattern Matching Alternative ---');

  Object data = {'name': 'Alice', 'age': 30};

  if (data case Map<String, dynamic> map) {
    print('Map with name: ${map['name']}');
  }

  // Switch with type patterns
  String describe(Object obj) {
    return switch (obj) {
      int n => 'Integer: $n',
      double d => 'Double: $d',
      String s => 'String of length ${s.length}',
      List l => 'List with ${l.length} items',
      _ => 'Unknown: ${obj.runtimeType}'
    };
  }

  print('describe(42): ${describe(42)}');
  print('describe(3.14): ${describe(3.14)}');
  print('describe("hi"): ${describe('hi')}');

  print('');
  print('=== End of Type Operators Demo ===');
}

// Helper classes for hierarchy examples

abstract class Animal {
  String speak();
}

class Dog extends Animal {
  final String name;
  Dog(this.name);

  @override
  String speak() => 'Woof!';

  String fetch() => '$name fetches the ball!';
}

class Cat extends Animal {
  @override
  String speak() => 'Meow!';
}
