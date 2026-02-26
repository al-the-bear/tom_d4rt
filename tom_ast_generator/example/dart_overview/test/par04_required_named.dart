// D4rt test: PAR04 - Required named parameters
//
// Tests functions with required named parameters.
// Verifies that required named args must be provided and work correctly.

import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // ── describe() — required named 'name', optional named 'age', 'city' ──

  // Just required named param
  describe(name: 'Alice');

  // Required + optional named params
  describe(name: 'Bob', age: 30);
  describe(name: 'Charlie', age: 25, city: 'NYC');

  // Named params in different order
  describe(city: 'LA', name: 'Diana', age: 28);

  // ── processOrder() — positional + required named 'quantity' ──────

  // Required named param with positional
  processOrder('ORD-001', 'laptop', quantity: 2);
  processOrder('ORD-002', 'mouse', quantity: 5, priority: 'high');

  // ── makeRequest() — positional + named with defaults ─────────────

  // All named params optional (defaults: method='GET', timeout=30)
  makeRequest('/api/users');
  makeRequest('/api/data', method: 'POST');
  makeRequest('/api/items', method: 'PUT', timeout: 10);

  // If we reached here without errors, all calls succeeded
  // (these functions return void, so we verify they don't throw)

  if (errors.isEmpty) {
    print('PAR04_PASSED');
  } else {
    print('PAR04_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
