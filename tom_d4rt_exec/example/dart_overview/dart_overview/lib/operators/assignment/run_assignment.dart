/// Demonstrates Dart assignment operators
///
/// Features covered:
/// - Simple assignment (=)
/// - Compound assignment (+=, -=, *=, /=, ~/=, %=, etc.)
/// - Null-aware assignment (??=)
/// - Bitwise compound assignment (&=, |=, ^=, <<=, >>=)

void main() {
  print('=== Assignment Operators ===\n');

  // Simple assignment
  print('--- Simple Assignment (=) ---');
  int x = 10;
  String name = 'Alice';
  List<int> numbers = [1, 2, 3];
  print('x = $x');
  print('name = $name');
  print('numbers = $numbers');

  // Multiple assignment
  int a, b, c;
  a = b = c = 5; // Right-to-left evaluation
  print('a = b = c = 5: a=$a, b=$b, c=$c');

  // Compound assignment - arithmetic
  print('\n--- Compound Assignment (Arithmetic) ---');
  int value = 10;
  print('Initial value: $value');

  value += 5; // value = value + 5
  print('value += 5: $value'); // 15

  value -= 3; // value = value - 3
  print('value -= 3: $value'); // 12

  value *= 2; // value = value * 2
  print('value *= 2: $value'); // 24

  double d = 24.0;
  d /= 4; // d = d / 4
  print('d /= 4: $d'); // 6.0

  int intVal = 24;
  intVal ~/= 5; // intVal = intVal ~/ 5
  print('intVal ~/= 5: $intVal'); // 4

  intVal %= 3; // intVal = intVal % 3
  print('intVal %= 3: $intVal'); // 1

  // Null-aware assignment
  print('\n--- Null-Aware Assignment (??=) ---');
  String? nullableStr = getString(null);
  print('nullableStr before ??=: $nullableStr'); // null

  nullableStr ??= 'Default Value'; // Assign if null
  print('nullableStr after first ??=: $nullableStr'); // Default Value

  String? nullableStr2 = getString('Already set');
  print('nullableStr2 before ??=: $nullableStr2');
  nullableStr2 ??= 'Another Value'; // Won't assign (not null)
  print('nullableStr2 after ??=: $nullableStr2'); // Already set

  // Practical use case
  int? userId = getInt(null);
  userId ??= generateUserId();
  print('userId: $userId');

  // Compound assignment - bitwise
  print('\n--- Compound Assignment (Bitwise) ---');
  int bits = 12; // 0b1100
  print('Initial bits: ${bits.toRadixString(2).padLeft(4, '0')} ($bits)');

  bits &= 10; // AND with 0b1010
  print('bits &= 10 (0b1010): ${bits.toRadixString(2).padLeft(4, '0')} ($bits)');

  bits = 5; // 0b0101
  bits |= 2; // OR with 0b0010
  print('bits |= 2 (0b0010): ${bits.toRadixString(2).padLeft(4, '0')} ($bits)');

  bits ^= 3; // XOR with 0b0011
  print('bits ^= 3 (0b0011): ${bits.toRadixString(2).padLeft(4, '0')} ($bits)');

  bits = 1;
  bits <<= 3; // Left shift
  print('bits <<= 3: ${bits.toRadixString(2).padLeft(4, '0')} ($bits)');

  bits >>= 1; // Right shift
  print('bits >>= 1: ${bits.toRadixString(2).padLeft(4, '0')} ($bits)');

  // Assignment in expressions
  print('\n--- Assignment in Expressions ---');
  int result;
  // Assignment returns the assigned value
  print('result = 42 evaluates to: ${result = 42}');
  print('result is now: $result');

  // Chained with operations
  int counter = 0;
  List<int> items = [];
  items.add(counter++); // Add 0, then increment
  items.add(counter++); // Add 1, then increment
  items.add(counter++); // Add 2, then increment
  print('items: $items, counter: $counter');

  // Destructuring assignment (Dart 3+)
  print('\n--- Destructuring Assignment ---');
  var (first, second) = (1, 2);
  print('(first, second) = (1, 2): first=$first, second=$second');

  var [head, ...tail] = [1, 2, 3, 4, 5];
  print('[head, ...tail] = [1,2,3,4,5]: head=$head, tail=$tail');

  var {'name': userName, 'age': userAge} = {'name': 'Bob', 'age': 30};
  print("{'name': userName, 'age': userAge}: $userName, $userAge");

  print('\n=== End of Assignment Operators Demo ===');
}

int generateUserId() {
  print('Generating user ID...');
  return 12345;
}

// Helper functions to prevent compile-time optimization
String? getString(String? s) => s;
int? getInt(int? i) => i;
