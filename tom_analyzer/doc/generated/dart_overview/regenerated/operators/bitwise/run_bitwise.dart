/// Demonstrates Dart bitwise operators
///
/// Features covered:
/// - Bitwise AND (&), OR (|), XOR (^)
/// - Bitwise NOT (~)
/// - Left shift (<<), Right shift (>>)
/// - Unsigned right shift (>>>)
library;

void main() {
  print('=== Bitwise Operators ===\n');

  // Binary representation helper
  String toBinary(int n, [int width = 8]) {
    if (n >= 0) {
      return n.toRadixString(2).padLeft(width, '0');
    } else {
      // For negative numbers, show two's complement
      return (n & ((1 << width) - 1)).toRadixString(2).padLeft(width, '0');
    }
  }

  // Bitwise AND
  print('--- Bitwise AND (&) ---');
  int a = 5; // 0101
  int b = 3; // 0011
  print('a = $a (${toBinary(a, 4)})');
  print('b = $b (${toBinary(b, 4)})');
  print('a & b = ${a & b} (${toBinary(a & b, 4)})'); // 1 (0001)

  // Practical: Check if bit is set
  int flags = 10; // 0b1010 - bits 1 and 3 are set
  bool bit1Set = (flags & 2) != 0; // 2 = 0b0010
  bool bit0Set = (flags & 1) != 0; // 1 = 0b0001
  print('\nflags = ${toBinary(flags, 4)}');
  print('bit 1 set: $bit1Set'); // true
  print('bit 0 set: $bit0Set'); // false

  // Bitwise OR
  print('\n--- Bitwise OR (|) ---');
  print('a = $a (${toBinary(a, 4)})');
  print('b = $b (${toBinary(b, 4)})');
  print('a | b = ${a | b} (${toBinary(a | b, 4)})'); // 7 (0111)

  // Practical: Set a bit
  int value = 4; // 0b0100
  int withBit0 = value | 1; // 1 = 0b0001
  print('\nvalue = ${toBinary(value, 4)}');
  print('with bit 0 set = ${toBinary(withBit0, 4)}');

  // Bitwise XOR
  print('\n--- Bitwise XOR (^) ---');
  print('a = $a (${toBinary(a, 4)})');
  print('b = $b (${toBinary(b, 4)})');
  print('a ^ b = ${a ^ b} (${toBinary(a ^ b, 4)})'); // 6 (0110)

  // Practical: Toggle a bit
  int state = 10; // 0b1010
  int toggled = state ^ 2; // 2 = 0b0010, Toggle bit 1
  print('\nstate = ${toBinary(state, 4)}');
  print('toggled bit 1 = ${toBinary(toggled, 4)}');
  print('toggle again = ${toBinary(toggled ^ 2, 4)}'); // 2 = 0b0010

  // XOR swap (classic algorithm)
  print('\n--- XOR Swap ---');
  int x = 10;
  int y = 20;
  print('Before: x = $x, y = $y');
  x = x ^ y;
  y = x ^ y;
  x = x ^ y;
  print('After:  x = $x, y = $y');

  // Bitwise NOT
  print('\n--- Bitwise NOT (~) ---');
  int n = 5;
  print('n = $n (${toBinary(n)})');
  print('~n = ${~n}'); // -6 (two's complement)

  // Left shift
  print('\n--- Left Shift (<<) ---');
  int num = 1;
  print('num = $num');
  print('num << 1 = ${num << 1}'); // 2 (multiply by 2)
  print('num << 2 = ${num << 2}'); // 4 (multiply by 4)
  print('num << 3 = ${num << 3}'); // 8 (multiply by 8)

  print('\n5 << 1 = ${5 << 1}'); // 10 (5 * 2)
  print('5 << 2 = ${5 << 2}'); // 20 (5 * 4)

  // Right shift (signed)
  print('\n--- Right Shift (>>) ---');
  int large = 16;
  print('large = $large');
  print('large >> 1 = ${large >> 1}'); // 8 (divide by 2)
  print('large >> 2 = ${large >> 2}'); // 4 (divide by 4)

  // With negative numbers (sign-extended)
  int neg = -16;
  print('\nneg = $neg');
  print('neg >> 1 = ${neg >> 1}'); // -8 (sign preserved)
  print('neg >> 2 = ${neg >> 2}'); // -4

  // Unsigned right shift
  print('\n--- Unsigned Right Shift (>>>) ---');
  print('neg = $neg');
  print('neg >>> 1 = ${neg >>> 1}'); // Large positive (sign bit shifted)

  // Practical examples
  print('\n--- Practical Examples ---');

  // Extract byte from int
  int color = 0xFF5733; // RGB color
  int red = (color >> 16) & 0xFF;
  int green = (color >> 8) & 0xFF;
  int blue = color & 0xFF;
  print('Color: 0x${color.toRadixString(16).toUpperCase()}');
  print('Red: $red, Green: $green, Blue: $blue');

  // Pack bytes into int
  int red2 = 255, green2 = 128, blue2 = 64;
  int packed = (red2 << 16) | (green2 << 8) | blue2;
  print('\nPacked RGB($red2, $green2, $blue2) = 0x${packed.toRadixString(16).toUpperCase()}');

  // Check if power of 2
  bool isPowerOf2(int n) => n > 0 && (n & (n - 1)) == 0;
  print('\n1 is power of 2: ${isPowerOf2(1)}');
  print('2 is power of 2: ${isPowerOf2(2)}');
  print('3 is power of 2: ${isPowerOf2(3)}');
  print('4 is power of 2: ${isPowerOf2(4)}');
  print('16 is power of 2: ${isPowerOf2(16)}');

  print('\n=== End of Bitwise Operators Demo ===');
}
