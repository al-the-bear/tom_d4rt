/// Demonstrates Dart arithmetic operators
///
/// Features covered:
/// - Addition, subtraction, multiplication, division
/// - Integer division, modulo
/// - Increment/decrement (pre and post)
/// - Unary minus

void main() {
  print('=== Arithmetic Operators ===\n');

  // Basic arithmetic
  print('--- Basic Arithmetic ---');
  int a = 10;
  int b = 3;

  print('a = $a, b = $b');
  print('a + b = ${a + b}'); // 13
  print('a - b = ${a - b}'); // 7
  print('a * b = ${a * b}'); // 30
  print('a / b = ${a / b}'); // 3.333... (double)
  print('a ~/ b = ${a ~/ b}'); // 3 (integer division)
  print('a % b = ${a % b}'); // 1 (modulo/remainder)

  // Division always returns double
  print('\n--- Division Types ---');
  print('5 / 2 = ${5 / 2}'); // 2.5 (double)
  print('5 ~/ 2 = ${5 ~/ 2}'); // 2 (int)
  print('5 % 2 = ${5 % 2}'); // 1 (remainder)

  // Negative numbers
  print('\n--- With Negative Numbers ---');
  print('-10 % 3 = ${-10 % 3}'); // 2 (Dart truncates toward negative infinity)
  print('10 % -3 = ${10 % -3}'); // 1
  print('-10 ~/ 3 = ${-10 ~/ 3}'); // -4

  // Unary minus
  print('\n--- Unary Minus ---');
  int positive = 42;
  int negative = -positive;
  print('positive: $positive');
  print('-positive: $negative');
  print('-(-negative): ${-negative}');

  // Increment and decrement
  print('\n--- Increment (++) ---');
  int count = 0;
  print('Initial count: $count');
  print('++count: ${++count}'); // Pre-increment: increment then return (1)
  print('count after pre-increment: $count'); // 1

  print('count++: ${count++}'); // Post-increment: return then increment (1)
  print('count after post-increment: $count'); // 2

  print('\n--- Decrement (--) ---');
  count = 5;
  print('Initial count: $count');
  print('--count: ${--count}'); // Pre-decrement (4)
  print('count--: ${count--}'); // Post-decrement, returns 4
  print('Final count: $count'); // 3

  // In expressions
  print('\n--- In Expressions ---');
  int x = 5;
  int y = ++x * 2; // x becomes 6, then y = 6 * 2 = 12
  print('x = 5, y = ++x * 2');
  print('x: $x, y: $y');

  x = 5;
  y = x++ * 2; // y = 5 * 2 = 10, then x becomes 6
  print('x = 5, y = x++ * 2');
  print('x: $x, y: $y');

  // Floating point arithmetic
  print('\n--- Floating Point ---');
  double d1 = 3.14159;
  double d2 = 2.0;
  print('$d1 + $d2 = ${d1 + d2}');
  print('$d1 * $d2 = ${d1 * d2}');
  print('$d1 % $d2 = ${d1 % d2}'); // Works with doubles too

  // Special values
  print('\n--- Special Values ---');
  print('1.0 / 0.0 = ${1.0 / 0.0}'); // infinity
  print('-1.0 / 0.0 = ${-1.0 / 0.0}'); // -infinity
  print('0.0 / 0.0 = ${0.0 / 0.0}'); // NaN

  print('\n=== End of Arithmetic Operators Demo ===');
}
