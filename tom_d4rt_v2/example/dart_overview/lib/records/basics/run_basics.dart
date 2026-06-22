/// Demonstrates Dart records (Dart 3.0+)
///
/// Features covered:
/// - Record syntax
/// - Positional fields
/// - Named fields
/// - Mixed fields
/// - Record types
/// - Record equality
/// - Record destructuring

void main() {
  print('=== Records ===');
  print('');

  // Positional records
  print('--- Positional Records ---');
  var point = (10, 20);
  print('point: $point');
  print('point.\$1: ${point.$1}');
  print('point.\$2: ${point.$2}');

  var rgb = (255, 128, 64);
  print('rgb: $rgb (r=${rgb.$1}, g=${rgb.$2}, b=${rgb.$3})');

  // Named records
  print('');
  print('--- Named Records ---');
  var person = (name: 'Alice', age: 30);
  print('person: $person');
  print('person.name: ${person.name}');
  print('person.age: ${person.age}');

  var config = (host: 'localhost', port: 8080, secure: false);
  print('config: $config');

  // Mixed positional and named
  print('');
  print('--- Mixed Fields ---');
  var mixed = ('Hello', count: 5, active: true);
  print('mixed: $mixed');
  print('mixed.\$1: ${mixed.$1}');
  print('mixed.count: ${mixed.count}');
  print('mixed.active: ${mixed.active}');

  // Single element records
  print('');
  print('--- Single Element Records ---');
  var single = (42,); // Trailing comma required
  print('single: $single');
  print('single.\$1: ${single.$1}');

  var namedSingle = (value: 'hello');
  print('namedSingle: $namedSingle');

  // Record types
  print('');
  print('--- Record Types ---');
  (int, int) coordinates = (100, 200);
  ({String name, int age}) user = (name: 'Bob', age: 25);
  (String, {int count}) data = ('items', count: 10);

  print('coordinates: $coordinates');
  print('user: $user');
  print('data: $data');

  // Type annotations in functions
  print('');
  print('--- Records in Functions ---');
  var minMax = findMinMax([5, 2, 8, 1, 9, 3]);
  print('findMinMax([5,2,8,1,9,3]): min=${minMax.min}, max=${minMax.max}');

  var swapped = swap((10, 20));
  print('swap((10, 20)): $swapped');

  var parsed = parseUserString('Alice:30');
  print('parseUserString("Alice:30"): name=${parsed.$1}, age=${parsed.$2}');

  // Record equality
  print('');
  print('--- Record Equality ---');
  var r1 = (1, 2, name: 'test');
  var r2 = (1, 2, name: 'test');
  var r3 = (1, 2, name: 'other');

  print('r1: $r1');
  print('r2: $r2');
  print('r3: $r3');
  print('r1 == r2: ${r1 == r2}');
  print('r1 == r3: ${r1 == r3}');
  print('r1.hashCode == r2.hashCode: ${r1.hashCode == r2.hashCode}');

  // Destructuring
  print('');
  print('--- Destructuring ---');
  var (x, y) = (100, 200);
  print('var (x, y) = (100, 200): x=$x, y=$y');

  var (first, second, third) = ('a', 'b', 'c');
  print('Positional: first=$first, second=$second, third=$third');

  var (:name, :age) = (name: 'Charlie', age: 35);
  print('Named: name=$name, age=$age');

  var (String text, count: int n) = ('hello', count: 5);
  print('Mixed: text=$text, n=$n');

  // Swapping with records
  print('');
  print('--- Swapping Variables ---');
  var a = 1;
  var b = 2;
  print('Before: a=$a, b=$b');
  (a, b) = (b, a);
  print('After: a=$a, b=$b');

  // Records as return values
  print('');
  print('--- Multiple Return Values ---');
  var result = divideWithRemainder(17, 5);
  print('17 / 5: quotient=${result.quotient}, remainder=${result.remainder}');

  var stats = calculateStats([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  print('Stats: sum=${stats.sum}, avg=${stats.average}, count=${stats.count}');

  // Nested records
  print('');
  print('--- Nested Records ---');
  var nested = ((1, 2), (3, 4));
  print('nested: $nested');
  print('nested.\$1: ${nested.$1}');
  print('nested.\$1.\$1: ${nested.$1.$1}');

  var ((a1, a2), (b1, b2)) = nested;
  print('Destructured: a1=$a1, a2=$a2, b1=$b1, b2=$b2');

  print('');
  print('=== End of Records Demo ===');
}

// Function returning named record
({int min, int max}) findMinMax(List<int> numbers) {
  var min = numbers.first;
  var max = numbers.first;
  for (var n in numbers) {
    if (n < min) min = n;
    if (n > max) max = n;
  }
  return (min: min, max: max);
}

// Function returning positional record
(int, int) swap((int, int) pair) {
  return (pair.$2, pair.$1);
}

// Parsing function
(String, int) parseUserString(String input) {
  var parts = input.split(':');
  return (parts[0], int.parse(parts[1]));
}

// Division with remainder
({int quotient, int remainder}) divideWithRemainder(int dividend, int divisor) {
  return (quotient: dividend ~/ divisor, remainder: dividend % divisor);
}

// Statistics calculation
({int sum, double average, int count}) calculateStats(List<int> numbers) {
  var sum = numbers.reduce((a, b) => a + b);
  return (sum: sum, average: sum / numbers.length, count: numbers.length);
}
