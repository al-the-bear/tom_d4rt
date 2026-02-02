/// CLI Exception Types for D4rt CLI API
///
/// This file contains all exception types used by the CLI API.
/// These exceptions provide detailed error information for command failures.
library;

/// Base exception for CLI operations.
class CliException implements Exception {
  /// The error message.
  final String message;

  /// The command that caused the error, if applicable.
  final String? command;

  /// The stack trace at the point of error.
  final StackTrace? stackTrace;

  /// Creates a CLI exception with the given message.
  CliException(this.message, {this.command, this.stackTrace});

  @override
  String toString() => command != null
      ? 'CliException: $message (command: $command)'
      : 'CliException: $message';
}

/// File not found during execution.
class CliFileNotFoundException extends CliException {
  /// The path that was not found.
  final String path;

  /// Creates a file not found exception.
  CliFileNotFoundException(this.path) : super('File not found: $path');
}

/// Directory not found during navigation.
class DirectoryNotFoundException extends CliException {
  /// The path that was not found.
  final String path;

  /// Creates a directory not found exception.
  DirectoryNotFoundException(this.path) : super('Directory not found: $path');
}

/// Error during code execution.
class ExecutionException extends CliException {
  /// Creates an execution exception.
  ExecutionException(
    super.message, {
    super.command,
    super.stackTrace,
  });
}

/// Error during replay file execution.
class ReplayException extends CliException {
  /// The file being replayed.
  final String file;

  /// The line number where the error occurred.
  final int line;

  /// The underlying cause of the error.
  final CliException cause;

  /// Creates a replay exception.
  ReplayException(this.file, this.line, this.cause)
      : super('Error at $file:$line: ${cause.message}');
}

/// Thrown when a method is called that is invalid in the current multiline mode.
class InvalidMultilineModeException extends CliException {
  /// The current multiline mode.
  final String currentMode;

  /// The method that was attempted.
  final String attemptedMethod;

  /// Creates an invalid multiline mode exception.
  InvalidMultilineModeException({
    required this.currentMode,
    required this.attemptedMethod,
  }) : super(
          'Cannot call $attemptedMethod while in multiline mode ($currentMode). '
          'Call .end first to complete the multiline block, or clearMultilineBuffer() to cancel.',
        );
}

/// Thrown when maximum nesting depth is exceeded.
class MaxNestingDepthException extends CliException {
  /// The maximum allowed depth.
  final int maxDepth;

  /// Creates a max nesting depth exception.
  MaxNestingDepthException(this.maxDepth)
      : super('Maximum nesting depth ($maxDepth) exceeded. '
            'Check for circular references in replay files.');
}

/// Thrown when accessing cli global before initialization.
class CliNotInitializedException extends CliException {
  /// Creates a cli not initialized exception.
  CliNotInitializedException()
      : super('cli global not yet initialized. '
            'This happens when accessing cli before REPL startup.');
}
