// D4rt test: OP12 - Bitwise operators
// Verifies bitwise operators (&, |, ^, ~, <<, >>) on bridged classes.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  var a = BitFlags(0x0F); // 00001111
  var b = BitFlags(0xF0); // 11110000

  // AND
  var andResult = a & b;
  if (andResult.bits != 0x00) {
    errors.add('0x0F & 0xF0 expected 0x00, got 0x${andResult.bits.toRadixString(16)}');
  }

  // OR
  var orResult = a | b;
  if (orResult.bits != 0xFF) {
    errors.add('0x0F | 0xF0 expected 0xFF, got 0x${orResult.bits.toRadixString(16)}');
  }

  // XOR
  var xorResult = a ^ b;
  if (xorResult.bits != 0xFF) {
    errors.add('0x0F ^ 0xF0 expected 0xFF, got 0x${xorResult.bits.toRadixString(16)}');
  }

  // NOT
  var notResult = ~BitFlags(0x00);
  // ~0 in Dart is -1 (all bits set)
  if (notResult.bits != -1) {
    errors.add('~0x00 expected -1, got ${notResult.bits}');
  }

  // Left shift
  var shifted = BitFlags(1) << 4;
  if (shifted.bits != 16) {
    errors.add('1 << 4 expected 16, got ${shifted.bits}');
  }

  // Right shift
  var rshifted = BitFlags(16) >> 2;
  if (rshifted.bits != 4) {
    errors.add('16 >> 2 expected 4, got ${rshifted.bits}');
  }

  if (errors.isEmpty) {
    print('OP12_PASSED');
  } else {
    print('OP12_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
