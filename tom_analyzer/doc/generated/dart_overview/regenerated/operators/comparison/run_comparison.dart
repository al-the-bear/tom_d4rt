/// Demonstrates Dart comparison operators
///
/// Features covered:
/// - Equal (==) and not equal (!=)
/// - Relational operators (>, <, >=, <=)
/// - Identity comparison (identical())
library;

void main() {
  print('=== Comparison Operators ===\n');

  // Equality
  print('--- Equality (==, !=) ---');
  int a = 5;
  int b = 5;
  int c = 10;

  print('a = $a, b = $b, c = $c');
  print('a == b: ${a == b}'); // true
  print('a == c: ${a == c}'); // false
  print('a != c: ${a != c}'); // true
  print('a != b: ${a != b}'); // false

  // String equality
  print('\n--- String Equality ---');
  String s1 = 'hello';
  String s2 = 'hello';
  String s3 = 'Hello';
  print("'hello' == 'hello': ${s1 == s2}"); // true (value comparison)
  print("'hello' == 'Hello': ${s1 == s3}"); // false (case-sensitive)

  // Relational operators
  print('\n--- Relational Operators ---');
  print('5 > 3: ${5 > 3}'); // true
  print('5 < 3: ${5 < 3}'); // false
  print('5 >= 5: ${5 >= 5}'); // true
  print('5 <= 4: ${5 <= 4}'); // false

  // Comparing doubles
  print('\n--- Comparing Doubles ---');
  double d1 = 3.14;
  double d2 = 3.14;
  double d3 = 3.15;
  print('$d1 == $d2: ${d1 == d2}'); // true
  print('$d1 < $d3: ${d1 < d3}'); // true

  // Beware of floating point precision
  print('\n--- Floating Point Precision ---');
  double result = 0.1 + 0.2;
  print('0.1 + 0.2 = $result');
  print('0.1 + 0.2 == 0.3: ${result == 0.3}'); // false!
  // Better approach:
  bool closeEnough = (result - 0.3).abs() < 0.0001;
  print('Close enough to 0.3: $closeEnough');

  // Identity comparison
  print('\n--- Identity (identical()) ---');
  var list1 = [1, 2, 3];
  var list2 = [1, 2, 3];
  var list3 = list1;

  print('list1: $list1');
  print('list2: $list2');
  print('list3 = list1');

  print('\nlist1 == list2: ${list1 == list2}'); // false (different objects)
  print('identical(list1, list2): ${identical(list1, list2)}'); // false
  print('identical(list1, list3): ${identical(list1, list3)}'); // true (same reference)

  // Identity with const
  print('\n--- Identity with const ---');
  const constList1 = [1, 2, 3];
  const constList2 = [1, 2, 3];
  print('identical(constList1, constList2): ${identical(constList1, constList2)}'); // true!

  // Comparing with null
  print('\n--- Comparing with null ---');
  String? nullableStr = getString(null);
  print('nullableStr == null: ${nullableStr == null}'); // true
  nullableStr = getString('value');
  print('nullableStr == null: ${nullableStr == null}'); // false

  // Custom equality (using Object.== override)
  print('\n--- Custom Equality ---');
  var p1 = Point(1, 2);
  var p2 = Point(1, 2);
  var p3 = p1;
  print('p1: $p1, p2: $p2');
  print('p1 == p2: ${p1 == p2}'); // true (custom == implemented)
  print('identical(p1, p2): ${identical(p1, p2)}'); // false
  print('identical(p1, p3): ${identical(p1, p3)}'); // true

  print('\n=== End of Comparison Operators Demo ===');
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

// Helper to return nullable string (prevents compile-time optimization)
String? getString(String? s) => s;
