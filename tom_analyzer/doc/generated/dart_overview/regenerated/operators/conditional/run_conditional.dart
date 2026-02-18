/// Demonstrates Dart conditional operators
///
/// Features covered:
/// - Ternary operator (? :)
/// - Null coalescing (??)
/// - Conditional member access (?.)
/// - Conditional index access (?[])
library;

// Helper functions to prevent compile-time optimization
String? getString(String? s) => s;
List<int>? getList(List<int>? l) => l;
Map<String, int>? getMap(Map<String, int>? m) => m;
User? getUser(User? u) => u;

void main() {
  print('=== Conditional Operators ===');
  print('');

  // Ternary operator
  print('--- Ternary Operator (? :) ---');
  int age = 20;
  String status = age >= 18 ? 'Adult' : 'Minor';
  print('age = $age, status = $status');

  age = 15;
  status = age >= 18 ? 'Adult' : 'Minor';
  print('age = $age, status = $status');

  // Nested ternary (use sparingly)
  int score = 85;
  String grade = score >= 90
      ? 'A'
      : score >= 80
          ? 'B'
          : score >= 70
              ? 'C'
              : score >= 60
                  ? 'D'
                  : 'F';
  print('score = $score, grade = $grade');

  // Ternary with expressions
  int a = 10, b = 20;
  int max = a > b ? a : b;
  print('max($a, $b) = $max');

  // Null coalescing
  print('');
  print('--- Null Coalescing (??) ---');
  String? nullableName = getString(null);
  String name = nullableName ?? 'Guest';
  print('nullableName = $nullableName');
  print('name = nullableName ?? Guest: $name');

  nullableName = getString('Alice');
  name = nullableName ?? 'Guest';
  print('nullableName = $nullableName');
  print('name = nullableName ?? Guest: $name');

  // Chained null coalescing
  String? first = getString(null);
  String? second = getString(null);
  String? third = getString('Third');
  String result = first ?? second ?? third ?? 'Default';
  print('');
  print('Chained: first ?? second ?? third ?? Default = $result');

  // With function calls (short-circuit)
  print('');
  String? getValue() {
    print('getValue() called');
    return 'From getValue';
  }

  String? withValue = getString('Already set');
  String? final1 = withValue ?? getValue(); // getValue not called
  print('final1 (already has value): $final1');

  String? noValue = getString(null);
  String? final2 = noValue ?? getValue(); // getValue is called
  print('final2 (was null): $final2');

  // Conditional member access
  print('');
  print('--- Conditional Member Access (?.) ---');
  String? maybeString = getString('Hello');
  print('maybeString = $maybeString');
  print('maybeString?.length = ${maybeString?.length}');
  print('maybeString?.toUpperCase() = ${maybeString?.toUpperCase()}');

  maybeString = getString(null);
  print('');
  print('maybeString = $maybeString');
  print('maybeString?.length = ${maybeString?.length}');
  print('maybeString?.toUpperCase() = ${maybeString?.toUpperCase()}');

  // Chained conditional access
  User? user = getUser(User('Bob', Address('NYC')));
  print('');
  print('user?.address?.city = ${user?.address?.city}');

  user = getUser(null);
  print('user (null)?.address?.city = ${user?.address?.city}');

  // Conditional index access
  print('');
  print('--- Conditional Index Access (?[]) ---');
  List<int>? maybeList = getList([1, 2, 3]);
  print('maybeList = $maybeList');
  print('maybeList?[0] = ${maybeList?[0]}');
  print('maybeList?[1] = ${maybeList?[1]}');

  maybeList = getList(null);
  print('');
  print('maybeList = $maybeList');
  print('maybeList?[0] = ${maybeList?[0]}');

  // With maps
  Map<String, int>? maybeMap = getMap({'a': 1, 'b': 2});
  print('');
  print('maybeMap = $maybeMap');
  print('maybeMap?[a] = ${maybeMap?['a']}');

  maybeMap = getMap(null);
  print('maybeMap (null)?[a] = ${maybeMap?['a']}');

  // Combining operators
  print('');
  print('--- Combining Conditional Operators ---');
  String? input = getString(null);
  // Get length if not null, otherwise default to 0
  int length = input?.length ?? 0;
  print('input = $input, length = $length');

  input = getString('Hello');
  length = input?.length ?? 0;
  print('input = $input, length = $length');

  // Safe navigation with method calls
  List<String>? items = getStringList(['apple', 'banana', 'cherry']);
  String? firstItem = items?.isNotEmpty == true ? items?.first : null;
  print('');
  print('First item: $firstItem');

  print('');
  print('=== End of Conditional Operators Demo ===');
}

// Helper function for string lists
List<String>? getStringList(List<String>? l) => l;

class Address {
  final String city;
  Address(this.city);
}

class User {
  final String name;
  final Address? address;
  User(this.name, [this.address]);
}
