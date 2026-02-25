// D4rt test: PAR02 - Optional positional parameters
//
// Tests functions with optional positional parameters (square brackets).
// Verifies calling with all, some, or no optional args.

import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // ── sayHello() — all optional positional ─────────────────────────

  // No args → defaults: sayHello('World', 'Hello')
  var r1 = sayHello();
  if (r1 != 'Hello, World!') errors.add('sayHello() expected "Hello, World!", got "$r1"');

  // One optional arg
  var r2 = sayHello('Bob');
  if (r2 != 'Hello, Bob!') errors.add('sayHello("Bob") expected "Hello, Bob!", got "$r2"');

  // Both optional args
  var r3 = sayHello('Charlie', 'Hi');
  if (r3 != 'Hi, Charlie!') errors.add('sayHello("Charlie", "Hi") expected "Hi, Charlie!", got "$r3"');

  // ── power() — required + optional positional ─────────────────────

  // Default exponent = 2
  var r4 = power(3);
  if (r4 != 9) errors.add('power(3) expected 9, got $r4');

  // Explicit exponent
  var r5 = power(2, 10);
  if (r5 != 1024) errors.add('power(2, 10) expected 1024, got $r5');

  var r6 = power(5, 3);
  if (r6 != 125) errors.add('power(5, 3) expected 125, got $r6');

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('PAR02_PASSED');
  } else {
    print('PAR02_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
