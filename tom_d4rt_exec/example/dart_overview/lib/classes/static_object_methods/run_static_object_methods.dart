/// Demonstrates Dart static members and Object methods
///
/// Features covered:
/// - Static fields
/// - Static methods
/// - toString()
/// - operator ==
/// - hashCode
/// - noSuchMethod

void main() {
  print('=== Static Members and Object Methods ===');
  print('');

  // Static fields
  print('--- Static Fields ---');
  print('MathUtils.pi: ${MathUtils.pi}');
  print('MathUtils.e: ${MathUtils.e}');

  // Create instances to demonstrate static counter
  Counter();
  Counter();
  Counter();
  print('');
  print('Created 3 Counter instances');
  print('Counter.instanceCount: ${Counter.instanceCount}');

  // Static methods
  print('');
  print('--- Static Methods ---');
  print('MathUtils.square(5): ${MathUtils.square(5)}');
  print('MathUtils.cube(3): ${MathUtils.cube(3)}');
  print('MathUtils.isEven(4): ${MathUtils.isEven(4)}');

  // Cannot access static through instance
  // var math = MathUtils();
  // math.pi; // Error: static accessed through instance

  // toString()
  print('');
  print('--- toString() ---');
  var person = Person('Alice', 30);
  print('person.toString(): ${person.toString()}');
  print('print(person): $person'); // Implicitly calls toString()

  var point = Point(3, 4);
  print('point: $point');

  // operator == and hashCode
  print('');
  print('--- operator == and hashCode ---');
  var p1 = Point(1, 2);
  var p2 = Point(1, 2);
  var p3 = Point(3, 4);
  var p4 = p1; // Same reference

  print('p1: $p1, p2: $p2, p3: $p3');
  print('p1 == p2: ${p1 == p2}'); // true (custom ==)
  print('p1 == p3: ${p1 == p3}'); // false
  print('identical(p1, p2): ${identical(p1, p2)}'); // false (different objects)
  print('identical(p1, p4): ${identical(p1, p4)}'); // true (same reference)

  print('');
  print('p1.hashCode: ${p1.hashCode}');
  print('p2.hashCode: ${p2.hashCode}');
  print('p1.hashCode == p2.hashCode: ${p1.hashCode == p2.hashCode}');

  // Using in Set and Map
  print('');
  print('--- Using Custom == in Collections ---');
  var pointSet = <Point>{p1, p2, p3};
  print('Set with p1, p2, p3: $pointSet');
  print('Set size: ${pointSet.length}'); // 2 (p1 and p2 are equal)

  var pointMap = <Point, String>{
    Point(1, 2): 'Origin',
    Point(3, 4): 'Target',
  };
  print('Map lookup Point(1, 2): ${pointMap[Point(1, 2)]}');

  // runtimeType
  print('');
  print('--- runtimeType ---');
  print('person.runtimeType: ${person.runtimeType}');
  print('point.runtimeType: ${point.runtimeType}');

  Object obj = 'Hello';
  print('obj.runtimeType: ${obj.runtimeType}');

  // noSuchMethod
  print('');
  print('--- noSuchMethod ---');
  dynamic flexible = FlexibleObject();
  print('Calling unknown method:');
  flexible.anyMethod();
  flexible.anotherMethod('arg');
  var result = flexible.computeSomething();
  print('Result from unknown method: $result');

  // Comparable
  print('');
  print('--- Comparable ---');
  var people = [
    SortablePerson('Charlie', 25),
    SortablePerson('Alice', 30),
    SortablePerson('Bob', 25),
  ];

  print('Before sort:');
  for (var p in people) {
    print('  $p');
  }

  people.sort();
  print('');
  print('After sort (by age, then name):');
  for (var p in people) {
    print('  $p');
  }

  print('');
  print('=== End of Static Members and Object Methods Demo ===');
}

// ignore: unused_element
void _useCounters(Counter c1, Counter c2, Counter c3) {
  // Just to suppress unused variable warnings
  c1.toString();
  c2.toString();
  c3.toString();
}

// Static members
class MathUtils {
  // Static constants
  static const double pi = 3.14159265359;
  static const double e = 2.71828182846;

  // Private constructor - prevent instantiation
  MathUtils._();

  // Static methods
  static int square(int n) => n * n;
  static int cube(int n) => n * n * n;
  static bool isEven(int n) => n % 2 == 0;
}

// Static counter
class Counter {
  static int instanceCount = 0;

  Counter() {
    instanceCount++;
  }
}

// toString()
class Person {
  final String name;
  final int age;

  Person(this.name, this.age);

  @override
  String toString() => 'Person(name: $name, age: $age)';
}

// == and hashCode
class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Point($x, $y)';
}

// noSuchMethod
class FlexibleObject {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    print('  Called: ${invocation.memberName}');
    if (invocation.isMethod) {
      print('  Arguments: ${invocation.positionalArguments}');
    }
    return 42;
  }
}

// Comparable
class SortablePerson implements Comparable<SortablePerson> {
  final String name;
  final int age;

  SortablePerson(this.name, this.age);

  @override
  int compareTo(SortablePerson other) {
    // First compare by age
    int result = age.compareTo(other.age);
    if (result != 0) return result;
    // Then by name
    return name.compareTo(other.name);
  }

  @override
  String toString() => '$name (age $age)';
}
