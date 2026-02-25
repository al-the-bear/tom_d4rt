/// Demonstrates Dart error handling
///
/// Features covered:
/// - throw expression
/// - try/catch/finally
/// - on clause for specific exceptions
/// - rethrow
/// - Custom exceptions
/// - Stack traces
/// - Error vs Exception

void main() {
  print('=== Error Handling ===');
  print('');

  // Basic try/catch
  print('--- Basic try/catch ---');
  try {
    var result = divide(10, 0);
    print('Result: $result');
  } catch (e) {
    print('Caught: $e');
  }

  // Catching specific exception types
  print('');
  print('--- Catching Specific Types ---');
  try {
    parseNumber('not a number');
  } on FormatException catch (e) {
    print('FormatException: ${e.message}');
  } on ArgumentError catch (e) {
    print('ArgumentError: $e');
  } catch (e) {
    print('Other: $e');
  }

  // Multiple exception types
  print('');
  print('--- Multiple Exception Types ---');
  var inputs = ['42', 'hello', null];
  for (var input in inputs) {
    try {
      var result = processInput(input);
      print('Result for "$input": $result');
    } on FormatException {
      print('Format error for "$input"');
    } on TypeError {
      print('Type error for "$input"');
    } catch (e) {
      print('Other error for "$input": $e');
    }
  }

  // Stack trace
  print('');
  print('--- Stack Trace ---');
  try {
    level1();
  } catch (e, stackTrace) {
    print('Error: $e');
    print('Stack trace (first 3 lines):');
    var lines = stackTrace.toString().split('\n').take(3);
    for (var line in lines) {
      print('  $line');
    }
  }

  // finally clause
  print('');
  print('--- finally clause ---');
  try {
    print('Opening resource...');
    throw Exception('Operation failed');
  } catch (e) {
    print('Caught: $e');
  } finally {
    print('Closing resource (always runs)');
  }

  // finally with return
  print('');
  print('--- finally with return ---');
  var value = testFinally();
  print('Returned value: $value');

  // rethrow
  print('');
  print('--- rethrow ---');
  try {
    handleWithLogging();
  } catch (e) {
    print('Caught after rethrow: $e');
  }

  // Custom exceptions
  print('');
  print('--- Custom Exceptions ---');
  try {
    validateUser('', -5);
  } on ValidationException catch (e) {
    print('Validation failed:');
    for (var error in e.errors) {
      print('  - $error');
    }
  }

  // Error vs Exception
  print('');
  print('--- Error vs Exception ---');
  print('Errors (usually unrecoverable):');
  print('  - StateError: bad state');
  print('  - ArgumentError: bad argument');
  print('  - RangeError: index out of bounds');
  print('  - TypeError: type mismatch');
  print('');
  print('Exceptions (recoverable):');
  print('  - FormatException: parse error');
  print('  - IOException: I/O error');
  print('  - Custom exceptions');

  // Throwing different types
  print('');
  print('--- Throwing Different Types ---');
  var throwables = ['String error', 42, Exception('Exception'), Error()];
  for (var t in throwables.take(3)) {
    try {
      throw t;
    } catch (e) {
      print('Caught ${e.runtimeType}: $e');
    }
  }

  // Assert (debug mode only)
  print('');
  print('--- Assert ---');
  try {
    var value = 10;
    assert(value > 0, 'Value must be positive');
    print('Value $value is valid');

    // This would fail in debug mode:
    // assert(value < 0, 'This would fail');
  } catch (e) {
    print('Assert failed: $e');
  }

  print('');
  print('=== End of Error Handling Demo ===');
}

// Division with error
int divide(int a, int b) {
  if (b == 0) {
    throw ArgumentError('Cannot divide by zero');
  }
  return a ~/ b;
}

// Parse with FormatException
int parseNumber(String input) {
  return int.parse(input); // Throws FormatException
}

// Process with multiple error types
int processInput(dynamic input) {
  if (input == null) {
    throw ArgumentError.notNull('input');
  }
  return int.parse(input as String);
}

// Nested calls for stack trace
void level1() => level2();
void level2() => level3();
void level3() => throw Exception('Error in level3');

// Finally with return
String testFinally() {
  try {
    return 'try';
  } finally {
    print('  finally block executed');
  }
}

// Rethrow example
void handleWithLogging() {
  try {
    throw Exception('Original error');
  } catch (e) {
    print('Logging error: $e');
    rethrow;
  }
}

// Custom exception
class ValidationException implements Exception {
  final List<String> errors;

  ValidationException(this.errors);

  @override
  String toString() => 'ValidationException: ${errors.join(", ")}';
}

void validateUser(String name, int age) {
  var errors = <String>[];

  if (name.isEmpty) {
    errors.add('Name is required');
  }

  if (age < 0) {
    errors.add('Age cannot be negative');
  }

  if (age > 150) {
    errors.add('Age is unrealistic');
  }

  if (errors.isNotEmpty) {
    throw ValidationException(errors);
  }
}
