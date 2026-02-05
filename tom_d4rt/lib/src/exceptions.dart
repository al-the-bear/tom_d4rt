/// Static error reporter that tracks all created [D4rtException]s.
///
/// This is used primarily in test modes to detect errors that occurred
/// during script execution.
/// 
/// Errors can be revoked if they are caught and handled gracefully,
/// preventing them from causing test failures.
class ErrorReporter {
  static final List<D4rtException> _errors = [];
  static final Map<D4rtException, StackTrace> _stackTraces = {};
  static bool _trackingEnabled = true;

  /// Reports an error to the reporter (only if tracking is enabled).
  ///
  /// This is called automatically by the [D4rtException] constructor.
  static void reportError(D4rtException error, [StackTrace? stackTrace]) {
    if (_trackingEnabled) {
      _errors.add(error);
      _stackTraces[error] = stackTrace ?? StackTrace.current;
    }
  }

  /// Temporarily disables error tracking.
  ///
  /// This is useful during speculative operations (like trying to parse as expression
  /// before falling back to statement) where errors are expected and should not be tracked.
  static void disableTracking() {
    _trackingEnabled = false;
  }

  /// Re-enables error tracking.
  static void enableTracking() {
    _trackingEnabled = true;
  }

  /// Revokes (removes) an error from the reporter.
  ///
  /// This should be called when an exception has been caught and handled
  /// gracefully, and should not count as a test failure.
  /// 
  /// Returns true if the error was found and removed, false otherwise.
  static bool revokeError(D4rtException error) {
    _stackTraces.remove(error);
    return _errors.remove(error);
  }

  /// Revokes all currently tracked errors.
  ///
  /// This is useful when a batch of errors occurred during a failed attempt
  /// (like trying to parse as expression before falling back to statement),
  /// and all those errors should be discarded.
  static void revokeAll() {
    _errors.clear();
    _stackTraces.clear();
  }

  /// Returns an unmodifiable list of all reported errors.
  static List<D4rtException> get errors => List.unmodifiable(_errors);

  /// Clears all reported errors.
  static void clear() {
    _errors.clear();
    _stackTraces.clear();
  }

  /// Returns true if any errors have been reported.
  static bool get hasErrors => _errors.isNotEmpty;

  /// Returns a formatted string with all reported errors.
  static String get report {
    if (_errors.isEmpty) return 'No errors reported.';
    return _errors.map((e) {
      final stackTrace = _stackTraces[e];
      if (stackTrace != null) {
        return '$e\nStack trace:\n$stackTrace';
      }
      return e.toString();
    }).join('\n\n');
  }

  /// Returns a formatted string with all reported errors (without stack traces).
  static String get reportShort {
    if (_errors.isEmpty) return 'No errors reported.';
    return _errors.map((e) => e.toString()).join('\n');
  }
}

/// Base class for all D4rt-specific exceptions that should be tracked.
/// 
/// All exceptions are automatically registered with [ErrorReporter] on creation.
/// If an exception is caught and handled gracefully, call [revoke()] to prevent
/// it from causing test failures.
abstract class D4rtException implements Exception {
  /// The error message.
  final String message;

  /// Creates a [D4rtException] and registers it with the [ErrorReporter].
  D4rtException(this.message) {
    ErrorReporter.reportError(this);
  }

  /// Revokes this error from the ErrorReporter.
  /// 
  /// Call this when the exception has been caught and handled gracefully,
  /// and should not count as a test failure.
  /// 
  /// Returns true if the error was successfully revoked, false if it was
  /// not found in the reporter (possibly already revoked).
  /// 
  /// Example:
  /// ```dart
  /// try {
  ///   // Some code that might fail
  ///   d4rt.eval('badCode');
  /// } catch (e) {
  ///   if (e is SourceCodeException) {
  ///     // Handle the error gracefully
  ///     print('Handled parse error');
  ///     e.revoke(); // Don't count this as a test failure
  ///   }
  /// }
  /// ```
  bool revoke() {
    return ErrorReporter.revokeError(this);
  }

  @override
  String toString();
}

/// Custom exception for runtime errors during interpretation.
///
/// This exception is thrown when the interpreter encounters an error
/// during code execution, such as accessing undefined variables,
/// calling non-existent methods, or type mismatches.
class RuntimeError extends D4rtException {
  /// Creates a new runtime error with the given message.
  RuntimeError(super.message);

  @override
  String toString() => 'Runtime Error: $message';
}

/// Exception for state-related errors in D4rt components.
class TomStateError extends D4rtException {
  /// Creates a new state error with the given message.
  TomStateError(super.message);

  @override
  String toString() => 'State Error: $message';
}

/// Exception for argument-related errors in D4rt components.
class TomArgumentError extends D4rtException {
  /// Creates a new argument error with the given message.
  TomArgumentError(super.message);

  @override
  String toString() => 'Argument Error: $message';
}

/// Exception for range-related errors in D4rt components.
class TomRangeError extends D4rtException {
  /// Creates a new range error with the given message.
  TomRangeError(super.message);

  @override
  String toString() => 'Range Error: $message';
}

/// Exception for unsupported operations in D4rt components.
class TomUnsupportedError extends D4rtException {
  /// Creates a new unsupported error with the given message.
  TomUnsupportedError(super.message);

  @override
  String toString() => 'Unsupported Error: $message';
}

/// Exception for unimplemented features in D4rt components.
class TomUnimplementedError extends D4rtException {
  /// Creates a new unimplemented error with the given message.
  TomUnimplementedError(super.message);

  @override
  String toString() => 'Unimplemented Error: $message';
}

/// Internal exception used to unwind the stack during a 'return' statement.
///
/// This exception is used internally by the interpreter to implement
/// return statement control flow. It carries the return value up the call stack.
class ReturnException implements Exception {
  /// The value being returned from the function.
  final Object? value;

  /// Creates a new return exception with the given return value.
  const ReturnException(this.value);
}

/// Internal exception used to unwind the stack during a 'break' statement.
///
/// This exception is used internally by the interpreter to implement
/// break statement control flow in loops and switch statements.
class BreakException implements Exception {
  /// Optional label for labeled break statements.
  final String? label;

  /// Creates a new break exception, optionally with a label.
  const BreakException([this.label]);

  @override
  String toString() => 'BreakException(label: $label)';
}

/// Internal exception used to unwind the stack during a 'continue' statement.
///
/// This exception is used internally by the interpreter to implement
/// continue statement control flow in loops.
class ContinueException implements Exception {
  /// Optional label for labeled continue statements.
  final String? label;

  /// Creates a new continue exception, optionally with a label.
  const ContinueException([this.label]);

  @override
  String toString() => 'ContinueException(label: $label)';
}

/// Internal exception for continue-to-label in switch statements.
/// This is used to signal the switch handler to restart from a specific labeled case.
class ContinueSwitchLabel implements Exception {
  const ContinueSwitchLabel();
}

/// Exception thrown when there's an issue with the source code itself,
/// like parsing errors or missing files.
///
/// This exception indicates problems with the Dart source code being
/// interpreted, such as syntax errors, missing imports, or invalid URIs.
class SourceCodeException extends D4rtException {
  /// The optional problematic code that caused the exception.
  final String? problematicCode;

  /// Creates a new source code exception with the given message and optional code.
  SourceCodeException(super.message, [this.problematicCode]);

  @override
  String toString() {
    if (problematicCode != null) {
      return 'SourceCodeException: $message\nProblematic code: [$problematicCode]';
    }
    return 'SourceCodeException: $message';
  }
}

/// Internal exception wrapper for user-thrown exceptions.
///
/// This helps distinguish between user 'throw x' exceptions and internal
/// interpreter control flow exceptions like Return/Break/Continue.
/// It wraps the original thrown value for proper exception handling.
class InternalInterpreterException extends D4rtException {
  /// The original value that was thrown by user code.
  final Object? originalThrownValue;
  // StackTrace could be stored here if needed directly,
  // but catch in visitTryStatement already gets it.

  /// Creates a new internal interpreter exception wrapping the original thrown value.
  InternalInterpreterException(this.originalThrownValue)
      : super('External error caught by interpreter');

  @override
  String toString() {
    // Provide a meaningful representation if needed,
    // but primarily used internally.
    return 'InternalInterpreterException(originalThrownValue: $originalThrownValue)';
  }
}

/// Exception specifically for pattern matching failures.
///
/// This exception is thrown when pattern matching operations fail
/// to match the expected pattern against the actual value.
class PatternMatchException extends D4rtException {
  /// Creates a new pattern match exception with the given message.
  PatternMatchException(super.message);

  @override
  String toString() => "PatternMatchException: $message";
}
