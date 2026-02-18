/// Demonstrates Dart type system features
///
/// Features covered:
/// - dynamic - opt-out of static checking
/// - Object and Object?
/// - Type test (is)
/// - Type cast (as)
/// - Never type
library;

void main() {
  print('=== Type System ===\n');

  // dynamic - opt-out of static checking
  print('--- dynamic ---');
  dynamic value = 'Hello';
  print('dynamic as String: $value (${value.runtimeType})');
  print('Calling .length: ${value.length}'); // Works - String has length

  value = 42;
  print('dynamic as int: $value (${value.runtimeType})');
  print('Calling .isEven: ${value.isEven}'); // Works - int has isEven

  value = [1, 2, 3];
  print('dynamic as List: $value (${value.runtimeType})');

  // dynamic allows any operation (checked at runtime)
  // value.nonExistentMethod(); // Would throw NoSuchMethodError

  // Object - the root of Dart's type hierarchy
  print('\n--- Object and Object? ---');
  Object obj = 'Can be anything non-null';
  print('Object holding String: $obj');

  obj = 123;
  print('Object holding int: $obj');

  // Object only has methods common to all objects
  print('toString(): ${obj.toString()}');
  print('hashCode: ${obj.hashCode}');
  print('runtimeType: ${obj.runtimeType}');

  // Object? can hold null
  Object? nullableObj;
  print('Object? with null: $nullableObj');
  nullableObj = 'Not null anymore';
  print('Object? with value: $nullableObj');

  // Difference: Object vs dynamic
  // Object o = 'Hello';
  // print(o.length); // Error: 'length' isn't defined for 'Object'

  // Type test (is)
  print('\n--- Type Test (is) ---');
  Object item = 'Hello, Dart';

  if (item is String) {
    // Type is promoted to String inside this block
    print('item is String: ${item.toUpperCase()}');
  }

  if (item is! int) {
    print('item is not an int');
  }

  // Type testing with different types
  void checkType(Object value) {
    if (value is int) {
      print('$value is int, doubled: ${value * 2}');
    } else if (value is double) {
      print('$value is double, halved: ${value / 2}');
    } else if (value is String) {
      print('$value is String, length: ${value.length}');
    } else if (value is List) {
      print('$value is List, isEmpty: ${value.isEmpty}');
    } else {
      print('$value is ${value.runtimeType}');
    }
  }

  checkType(42);
  checkType(3.14);
  checkType('Dart');
  checkType([1, 2, 3]);
  checkType({'key': 'value'});

  // Type cast (as)
  print('\n--- Type Cast (as) ---');
  Object stringObj = 'Cast me';
  String str = stringObj as String;
  print('Cast to String: $str');

  // Safe casting pattern
  Object maybeInt = 42;
  int? safeInt = maybeInt is int ? maybeInt : null;
  print('Safe cast result: $safeInt');

  // Casting with null
  Object? nullableValue = 'Not null';
  String? castResult = nullableValue as String?;
  print('Cast to String?: $castResult');

  // Dangerous cast would throw
  // Object notAString = 42;
  // String wrong = notAString as String; // Throws TypeError

  // Never type
  print('\n--- Never Type ---');
  print('About to call a function that could throw...');
  try {
    int result = getValueOrThrow(null);
    print('Result: $result');
  } catch (e) {
    print('Caught: $e');
  }

  // Never in exhaustive checking
  print('\nShape area calculation:');
  final circle = Circle(5);
  final square = Square(4);
  print('Circle area: ${calculateArea(circle)}');
  print('Square area: ${calculateArea(square)}');

  print('\n=== End of Type System Demo ===');
}

// Function using Never - indicates it never returns normally
Never throwError(String message) {
  throw Exception(message);
}

// Using Never for exhaustive checks
int getValueOrThrow(int? value) {
  if (value != null) {
    return value;
  }
  throwError('Value was null!');
  // No return needed - Never indicates code won't reach here
}

// Sealed class for exhaustive matching
sealed class Shape {}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

class Square extends Shape {
  final double side;
  Square(this.side);
}

double calculateArea(Shape shape) {
  return switch (shape) {
    Circle(:var radius) => 3.14159 * radius * radius,
    Square(:var side) => side * side,
    // No default needed - sealed class is exhaustive
  };
}
