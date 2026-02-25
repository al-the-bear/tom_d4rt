// D4rt test: UBR03 - User bridge field/variable override
//
// Tests that global variables and functions are overridden by
// GlobalsUserBridge. The overrides change:
//   appName → 'OverriddenApp'
//   maxRetries → 10
//   greet() → 'Custom greeting for ...'
//   calculate() → custom implementation

import 'package:userbridge_override_example/userbridge_override_example.dart';

void main() {
  var errors = <String>[];

  // ── Global variable override: appName ────────────────────────────

  if (appName != 'OverriddenApp') {
    errors.add('appName expected "OverriddenApp", got "$appName"');
  }

  // ── Global variable override: maxRetries ─────────────────────────

  if (maxRetries != 10) {
    errors.add('maxRetries expected 10, got $maxRetries');
  }

  // ── Global const (NOT overridden): version ───────────────────────

  if (version != '1.0.0') {
    errors.add('version expected "1.0.0", got "$version"');
  }

  // ── Global function override: greet() ────────────────────────────

  var greeting = greet('World');
  if (greeting != 'Custom greeting for World!') {
    errors.add('greet expected "Custom greeting for World!", got "$greeting"');
  }

  var greeting2 = greet('Alice');
  if (greeting2 != 'Custom greeting for Alice!') {
    errors.add('greet expected "Custom greeting for Alice!", got "$greeting2"');
  }

  // ── Global function override: calculate() ────────────────────────

  var sum = calculate(5, 3);
  if (sum != 8) errors.add('calculate(5,3) expected 8, got $sum');

  var diff = calculate(10, 4, operation: 'subtract');
  if (diff != 6) errors.add('calculate(10,4,subtract) expected 6, got $diff');

  var product = calculate(3, 7, operation: 'multiply');
  if (product != 21) errors.add('calculate(3,7,multiply) expected 21, got $product');

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('UBR03_PASSED');
  } else {
    print('UBR03_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
