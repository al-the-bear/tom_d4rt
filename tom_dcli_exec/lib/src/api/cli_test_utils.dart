// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// CLI Test Utilities - Assertion and verification functions for testing.
///
/// This file provides global functions for testing D4rt/DCli scripts.
/// These functions are registered as D4rt bridges and available in scripts.
library;

/// Exception thrown when a verification fails.
class VerificationFailure implements Exception {
  /// The error message describing the failure.
  final String message;

  /// Creates a verification failure with the given message.
  VerificationFailure(this.message);

  @override
  String toString() => 'VerificationFailure: $message';
}

/// Storage for verification failures during test execution.
/// 
/// This list accumulates failures during test mode execution,
/// allowing the test runner to report all failures at the end.
final List<String> _verificationFailures = [];

/// Get the list of verification failures.
/// 
/// Used by the test runner to check for failures after execution.
List<String> get verificationFailures => List.unmodifiable(_verificationFailures);

/// Clear all verification failures.
/// 
/// Called at the start of a new test run.
void clearVerificationFailures() {
  _verificationFailures.clear();
}

/// Verify that a condition is true.
/// 
/// If [condition] is false, records a verification failure with [errorMessage].
/// In test mode, failures are collected and reported at the end.
/// In normal mode, prints an error message.
/// 
/// Example:
/// ```dart
/// verify(count > 0, 'Count should be positive');
/// verify(result == expected, 'Result $result did not match expected $expected');
/// ```
/// 
/// Returns `true` if the verification passed, `false` otherwise.
bool verify(bool condition, String errorMessage) {
  if (!condition) {
    _verificationFailures.add(errorMessage);
    return false;
  }
  return true;
}

/// Verify that two values are equal.
/// 
/// If [actual] != [expected], records a verification failure.
/// 
/// Example:
/// ```dart
/// verifyEquals(result, 42, 'Result should be 42');
/// verifyEquals(name, 'test', 'Name mismatch');
/// ```
/// 
/// Returns `true` if the verification passed, `false` otherwise.
bool verifyEquals(Object? actual, Object? expected, [String? message]) {
  if (actual != expected) {
    final msg = message ?? 'Expected $expected but got $actual';
    _verificationFailures.add(msg);
    return false;
  }
  return true;
}

/// Verify that a value is not null.
/// 
/// Example:
/// ```dart
/// verifyNotNull(result, 'Result should not be null');
/// ```
/// 
/// Returns `true` if the verification passed, `false` otherwise.
bool verifyNotNull(Object? value, [String? message]) {
  if (value == null) {
    final msg = message ?? 'Expected non-null value';
    _verificationFailures.add(msg);
    return false;
  }
  return true;
}

/// Verify that a value is null.
/// 
/// Example:
/// ```dart
/// verifyNull(error, 'Error should be null');
/// ```
/// 
/// Returns `true` if the verification passed, `false` otherwise.
bool verifyNull(Object? value, [String? message]) {
  if (value != null) {
    final msg = message ?? 'Expected null but got $value';
    _verificationFailures.add(msg);
    return false;
  }
  return true;
}

/// Verify that a string contains a substring.
/// 
/// Example:
/// ```dart
/// verifyContains(output, 'success', 'Output should contain success');
/// ```
/// 
/// Returns `true` if the verification passed, `false` otherwise.
bool verifyContains(String actual, String substring, [String? message]) {
  if (!actual.contains(substring)) {
    final msg = message ?? 'Expected "$actual" to contain "$substring"';
    _verificationFailures.add(msg);
    return false;
  }
  return true;
}

/// Verify that a string matches a regular expression.
/// 
/// Example:
/// ```dart
/// verifyMatches(email, r'^[\w.]+@[\w.]+$', 'Invalid email format');
/// ```
/// 
/// Returns `true` if the verification passed, `false` otherwise.
bool verifyMatches(String actual, String pattern, [String? message]) {
  if (!RegExp(pattern).hasMatch(actual)) {
    final msg = message ?? 'Expected "$actual" to match pattern "$pattern"';
    _verificationFailures.add(msg);
    return false;
  }
  return true;
}

/// Verify that a list is not empty.
/// 
/// Example:
/// ```dart
/// verifyNotEmpty(results, 'Results should not be empty');
/// ```
/// 
/// Returns `true` if the verification passed, `false` otherwise.
bool verifyNotEmpty(List list, [String? message]) {
  if (list.isEmpty) {
    final msg = message ?? 'Expected non-empty list';
    _verificationFailures.add(msg);
    return false;
  }
  return true;
}

/// Verify that a list has a specific length.
/// 
/// Example:
/// ```dart
/// verifyLength(items, 3, 'Should have exactly 3 items');
/// ```
/// 
/// Returns `true` if the verification passed, `false` otherwise.
bool verifyLength(List list, int length, [String? message]) {
  if (list.length != length) {
    final msg = message ?? 'Expected length $length but got ${list.length}';
    _verificationFailures.add(msg);
    return false;
  }
  return true;
}

/// Verify that a condition throws an exception.
/// 
/// Example:
/// ```dart
/// verifyThrows(() => divide(1, 0), 'Division by zero should throw');
/// ```
/// 
/// Returns `true` if an exception was thrown, `false` otherwise.
bool verifyThrows(void Function() fn, [String? message]) {
  try {
    fn();
    final msg = message ?? 'Expected exception to be thrown';
    _verificationFailures.add(msg);
    return false;
  } catch (_) {
    return true;
  }
}

/// Print a test summary.
/// 
/// Returns `true` if all verifications passed, `false` otherwise.
bool testSummary() {
  if (_verificationFailures.isEmpty) {
    print('All verifications passed!');
    return true;
  } else {
    print('${_verificationFailures.length} verification(s) failed:');
    for (var i = 0; i < _verificationFailures.length; i++) {
      print('  ${i + 1}. ${_verificationFailures[i]}');
    }
    return false;
  }
}
