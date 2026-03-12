// D4rt test: PAR05 - Default parameter values
//
// Tests that default values are applied correctly when optional/named
// parameters are omitted.

import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // ── sayHello() defaults: name='World', greeting='Hello' ──────────

  var r1 = sayHello();
  if (r1 != 'Hello, World!') {
    errors.add('sayHello() default expected "Hello, World!", got "$r1"');
  }

  // Override first default only
  var r2 = sayHello('Custom');
  if (r2 != 'Hello, Custom!') {
    errors.add('sayHello("Custom") expected "Hello, Custom!", got "$r2"');
  }

  // ── power() default: exponent=2 ─────────────────────────────────

  var r3 = power(4);
  if (r3 != 16) errors.add('power(4) default exp=2 expected 16, got $r3');

  var r4 = power(2);
  if (r4 != 4) errors.add('power(2) default exp=2 expected 4, got $r4');

  // Override default
  var r5 = power(2, 8);
  if (r5 != 256) errors.add('power(2, 8) expected 256, got $r5');

  // ── makeRequest() defaults: method='GET', timeout=30 ─────────────

  // Calling with just positional arg — named params use defaults
  // (void return, just verify no throw)
  makeRequest('/api/test');

  // Override one default
  makeRequest('/api/test', method: 'POST');

  // Override both defaults
  makeRequest('/api/test', method: 'DELETE', timeout: 5);

  // ── processOrder() default: priority='normal' ────────────────────

  // Required named quantity, optional priority with default
  processOrder('ORD-100', 'widget', quantity: 1);
  processOrder('ORD-101', 'gadget', quantity: 3, priority: 'urgent');

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('PAR05_PASSED');
  } else {
    print('PAR05_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
