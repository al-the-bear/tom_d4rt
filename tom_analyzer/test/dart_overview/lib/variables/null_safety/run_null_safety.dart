/// Demonstrates Dart null safety features
///
/// Features covered:
/// - Nullable types (Type?)
/// - Null-aware access (?.)
/// - Null coalescing (??)
/// - Null coalescing assignment (??=)
/// - Null assertion (!)
library;

void main() {
  print('=== Null Safety ===\n');

  // Nullable types
  print('--- Nullable Types ---');
  String nonNullable = 'Always has a value';
  String? nullable; // Can be null
  print('nonNullable: $nonNullable');
  print('nullable: $nullable');

  nullable = 'Now has a value';
  print('nullable after assignment: $nullable');

  // Nullable in collections
  List<String?> namesWithNulls = ['Alice', null, 'Bob'];
  List<String>? nullableList;
  print('namesWithNulls: $namesWithNulls');
  print('nullableList: $nullableList');

  // Null-aware access (?.)
  print('\n--- Null-Aware Access (?.) ---');
  String? name = getName('Alice');
  print('name?.length: ${name?.length}'); // 5

  name = getName(null);
  print('null name?.length: ${name?.length}'); // null (no crash)

  // Chained null-aware access
  User? user = getUser('Bob');
  print('user?.address?.city: ${user?.address?.city}');

  user = getUser(null);
  print('null user?.address?.city: ${user?.address?.city}'); // null

  // Null coalescing (??)
  print('\n--- Null Coalescing (??) ---');
  String? maybeNull = getName(null);
  String result = maybeNull ?? 'Default Value';
  print('maybeNull ?? "Default Value": $result');

  maybeNull = getName('Actual Value');
  result = maybeNull ?? 'Default Value';
  print('After assignment, maybeNull ?? "Default Value": $result');

  // Chained null coalescing
  String? first;
  String? second;
  String? third = 'Third';
  print('first ?? second ?? third: ${first ?? second ?? third}');

  // Null coalescing assignment (??=)
  print('\n--- Null Coalescing Assignment (??=) ---');
  String? value = getName(null);
  print('Before ??=: value = $value');
  value ??= 'Assigned because null';
  print('After ??=: value = $value');
  
  String? value2 = getName('Already set');
  print('Before second ??=: value2 = $value2');
  value2 ??= 'Not assigned because not null';
  print('After second ??=: value2 = $value2');

  // Null assertion (!)
  print('\n--- Null Assertion (!) ---');
  String? definitelyHasValue = getName('I exist');
  String nonNull = definitelyHasValue!; // Assert non-null
  print('Asserted value: $nonNull');

  // Using ! when you know a value is non-null
  Map<String, int> scores = {'Alice': 95, 'Bob': 87};
  // We know 'Alice' exists, so we can use !
  int aliceScore = scores['Alice']!;
  print("Alice's score: $aliceScore");

  // Dangerous: Using ! on null throws
  // String? nullValue = null;
  // print(nullValue!); // Throws: Null check operator used on a null value

  // Type promotion with null checks
  print('\n--- Type Promotion ---');
  String? maybeString = getName('Hello');
  if (maybeString != null) {
    // maybeString is promoted to String (non-nullable)
    print('Length: ${maybeString.length}'); // No ?. needed
  }

  // Promotion with return
  String getLength(String? s) {
    if (s == null) return 'null';
    return 'Length: ${s.length}'; // s is promoted to String
  }
  print(getLength('Dart'));
  print(getLength(null));

  // Late and null safety
  print('\n--- late with Null Safety ---');
  late String lateValue;
  // lateValue is non-nullable but can be assigned later
  lateValue = 'Assigned later';
  print('lateValue: $lateValue');

  print('\n=== End of Null Safety Demo ===');
}

class Address {
  final String city;
  final String country;
  Address(this.city, this.country);
}

class User {
  final String name;
  final Address? address;
  User(this.name, [this.address]);
}

// Helper functions to return nullable values
// (prevents analyzer from knowing the value at compile time)
String? getName(String? input) => input;
User? getUser(String? name) =>
    name != null ? User(name, Address('NYC', 'USA')) : null;
