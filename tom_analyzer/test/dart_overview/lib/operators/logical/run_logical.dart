/// Demonstrates Dart logical operators
///
/// Features covered:
/// - NOT (!)
/// - AND (&&) with short-circuit evaluation
/// - OR (||) with short-circuit evaluation
library;

// Helper functions to prevent compile-time optimization
bool getTrue() => true;
bool getFalse() => false;

void main() {
  print('=== Logical Operators ===\n');

  // Basic logical operators
  print('--- Basic Logical Operators ---');
  bool a = getTrue();
  bool b = getFalse();

  print('a = $a, b = $b');
  print('!a (NOT): ${!a}'); // false
  print('!b (NOT): ${!b}'); // true
  print('a && b (AND): ${a && b}'); // false
  print('a || b (OR): ${a || b}'); // true

  // Truth table for AND
  print('\n--- AND Truth Table ---');
  print('true && true = ${getTrue() && getTrue()}');
  print('true && false = ${getTrue() && getFalse()}');
  print('false && true = ${getFalse() && getTrue()}');
  print('false && false = ${getFalse() && getFalse()}');

  // Truth table for OR
  print('\n--- OR Truth Table ---');
  print('true || true = ${getTrue() || getTrue()}');
  print('true || false = ${getTrue() || getFalse()}');
  print('false || true = ${getFalse() || getTrue()}');
  print('false || false = ${getFalse() || getFalse()}');

  // Short-circuit evaluation
  print('\n--- Short-Circuit AND ---');
  bool called = false;
  bool sideEffect() {
    called = true;
    print('sideEffect() was called!');
    return true;
  }

  // With AND, if first is false, second is not evaluated
  print('false && sideEffect():');
  called = false;
  bool result = getFalse() && sideEffect();
  print('Result: $result, sideEffect called: $called'); // false, false

  print('\ntrue && sideEffect():');
  called = false;
  result = getTrue() && sideEffect();
  print('Result: $result, sideEffect called: $called'); // true, true

  // Short-circuit OR
  print('\n--- Short-Circuit OR ---');
  // With OR, if first is true, second is not evaluated
  print('true || sideEffect():');
  called = false;
  result = getTrue() || sideEffect();
  print('Result: $result, sideEffect called: $called'); // true, false

  print('\nfalse || sideEffect():');
  called = false;
  result = getFalse() || sideEffect();
  print('Result: $result, sideEffect called: $called'); // true, true

  // Combining operators
  print('\n--- Combining Operators ---');
  bool x = getTrue();
  bool y = getFalse();
  bool z = getTrue();

  print('x = $x, y = $y, z = $z');
  print('x && y || z = ${x && y || z}'); // true (AND has higher precedence)
  print('x || y && z = ${x || y && z}'); // true
  print('(x || y) && z = ${(x || y) && z}'); // true
  print('!(x && y) = ${!(x && y)}'); // true

  // Practical examples
  print('\n--- Practical Examples ---');

  // Guard condition
  String? name = getName('Alice');
  if (name != null && name.isNotEmpty) {
    print('Valid name: $name');
  }

  // Default with OR
  String? input;
  String value = input ?? 'default'; // Using null-coalescing, similar concept
  print('value: $value');

  // Multiple conditions
  int age = 25;
  bool hasLicense = getTrue();
  bool hasInsurance = getTrue();

  if (age >= 18 && hasLicense && hasInsurance) {
    print('Can drive!');
  }

  // Any condition true
  bool isAdmin = getFalse();
  bool isModerator = getTrue();
  bool isOwner = getFalse();

  if (isAdmin || isModerator || isOwner) {
    print('Has elevated privileges');
  }

  // Complex condition
  int score = 85;
  bool isPassing = score >= 60;
  bool hasExtraCredit = getFalse();

  bool finalResult = isPassing || (score >= 50 && hasExtraCredit);
  print('Score: $score, Final result: $finalResult');

  print('\n=== End of Logical Operators Demo ===');
}

// Helper to return nullable string
String? getName(String? s) => s;
