/// Lightweight, always-on interpreter instrumentation counters.
///
/// These are plain integer increments on the hottest interpreter paths — no
/// allocation, no stack capture — so they are safe to leave compiled in. They
/// exist to diagnose pathological per-frame cost in embeddings (e.g. the
/// `particle_field` Flutter sample freeze): a harness reads [callCount] /
/// [maxDepth] before and after a unit of work to see whether a spike is driven
/// by call volume or interpreter recursion depth (the latter is what makes
/// exception-based `return` unwinding expensive — see the perf analysis).
class D4rtDiag {
  /// Monotonic count of interpreted function-call entries (`_callImpl`).
  static int callCount = 0;

  /// Current synchronous interpreter call-nesting depth.
  static int depth = 0;

  /// High-water mark of [depth] since the last [reset].
  static int maxDepth = 0;

  /// Per-window allocation counters for the prime per-rebuild garbage
  /// suspects. The `particle_field` freeze is a stop-the-world major GC of
  /// ~2.2GB old-gen garbage accumulated at ~22MB/frame; these counters localize
  /// which interpreter allocation dominates a single interpreted rebuild.
  static int envAllocs = 0;

  /// Count of interpreted-closure objects materialized in the window.
  static int closureAllocs = 0;

  /// Count of `InterpretedInstance` objects constructed in the window.
  static int instanceAllocs = 0;

  /// Count of `BridgedInstance` objects constructed in the window.
  static int bridgedAllocs = 0;

  /// Resets the windowed counters ([callCount], [maxDepth], and the allocation
  /// counters). [depth] is the live nesting level and is intentionally left
  /// untouched.
  static void reset() {
    callCount = 0;
    maxDepth = 0;
    envAllocs = 0;
    closureAllocs = 0;
    instanceAllocs = 0;
    bridgedAllocs = 0;
  }

  /// Records entry into an interpreted call frame.
  static void enterCall() {
    callCount++;
    depth++;
    if (depth > maxDepth) maxDepth = depth;
  }

  /// Records exit from an interpreted call frame.
  static void exitCall() {
    depth--;
  }
}

/// Static error reporter that tracks all created [D4rtException]s.
///
/// This is used primarily in test modes to detect errors that occurred
/// during script execution.
///
/// Errors can be revoked if they are caught and handled gracefully,
/// preventing them from causing test failures.
class ErrorReporter {
  /// Identity set of tracked errors.
  ///
  /// An identity [Set] makes [revokeError] an O(1) `remove` instead of the
  /// O(n) linear scan a `List.remove` performed — that scan was the dominant
  /// interpreter CPU cost (see the perf analysis). Exceptions are unique
  /// objects, so identity membership matches the prior list semantics exactly.
  /// Insertion order is preserved (identity sets are linked), so [report]
  /// ordering is unchanged.
  static final Set<D4rtException> _errors = Set<D4rtException>.identity();

  /// Tracking is **off by default**. It is an opt-in debugging/test aid:
  /// capturing `StackTrace.current` plus bookkeeping on every exception during
  /// normal execution is pure overhead. Test harnesses and the REPL call
  /// [enableTracking] when they need the report.
  static bool _trackingEnabled = false;

  /// Reports an error to the reporter (only if tracking is enabled).
  ///
  /// This is called automatically by the [D4rtException] constructor. The stack
  /// trace is stored on the exception instance itself (not in a side map), so
  /// no parallel `Map.remove` is needed on revoke.
  static void reportError(D4rtException error, [StackTrace? stackTrace]) {
    if (_trackingEnabled) {
      _errors.add(error);
      error.trackedStackTrace = stackTrace ?? StackTrace.current;
    }
  }

  /// Temporarily disables error tracking.
  ///
  /// This is useful during speculative operations (like trying to parse as expression
  /// before falling back to statement) where errors are expected and should not be tracked.
  static void disableTracking() {
    _trackingEnabled = false;
  }

  /// Enables error tracking. Off by default; opt in from tests/REPL.
  static void enableTracking() {
    _trackingEnabled = true;
  }

  /// Whether error tracking is currently enabled.
  static bool get isTrackingEnabled => _trackingEnabled;

  /// Revokes (removes) an error from the reporter.
  ///
  /// This should be called when an exception has been caught and handled
  /// gracefully, and should not count as a test failure.
  ///
  /// Returns true if the error was found and removed, false otherwise.
  static bool revokeError(D4rtException error) {
    error.trackedStackTrace = null;
    return _errors.remove(error);
  }

  /// Revokes all currently tracked errors.
  ///
  /// This is useful when a batch of errors occurred during a failed attempt
  /// (like trying to parse as expression before falling back to statement),
  /// and all those errors should be discarded.
  static void revokeAll() {
    _errors.clear();
  }

  /// Returns an unmodifiable list of all reported errors.
  static List<D4rtException> get errors => List.unmodifiable(_errors);

  /// Clears all reported errors.
  static void clear() {
    _errors.clear();
  }

  /// Returns true if any errors have been reported.
  static bool get hasErrors => _errors.isNotEmpty;

  /// Returns a formatted string with all reported errors.
  static String get report {
    if (_errors.isEmpty) return 'No errors reported.';
    return _errors.map((e) {
      final stackTrace = e.trackedStackTrace;
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

  /// Stack trace captured by [ErrorReporter] when tracking is enabled.
  ///
  /// Stored on the instance (rather than in a side map) so revoking an error
  /// is a single O(1) set removal with no parallel map bookkeeping. Null when
  /// tracking was off at construction time or after the error was revoked.
  StackTrace? trackedStackTrace;

  /// Whether [message] already names which module failed to load which target.
  ///
  /// DFUB13. `loadModule` recurses, so every frame on the way out could prepend
  /// its own "Failed to load ..." prefix to the same underlying error. Only the
  /// innermost frame knows the file that actually contains the bad directive,
  /// so [wrapDirectiveError] sets this when it adds context and consults it to
  /// stay silent on every outer frame.
  ///
  /// It lives on the base class rather than on one subtype because the two
  /// module loaders report a missing module with *different* exception types —
  /// the filesystem loader raises [SourceCodeD4rtException], the bundle loader
  /// raises [RuntimeD4rtException] — and both need the same once-only rule.
  bool hasDirectiveContext = false;

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
class RuntimeD4rtException extends D4rtException {
  /// When this runtime error wraps a *native* exception thrown from a bridged
  /// adapter (method, static method, getter, setter, operator, constructor),
  /// the original exception object is preserved here. This lets a typed
  /// `on NativeType` / bare `catch` clause in interpreted code dispatch against
  /// the real exception type rather than this `RuntimeError` wrapper.
  /// (OPEN B.5 — U13/U24.)
  final Object? originalException;

  /// The stack trace that accompanied [originalException] at the point the
  /// bridged adapter threw it.
  ///
  /// Recovering the *value* was never enough on its own. The wrapper is
  /// constructed in the interpreter's own `catch` block, so an interpreted
  /// `catch (e, st)` used to receive the trace of the wrap site rather than of
  /// the throw — which makes `Error.throwWithStackTrace` inert, since preserving
  /// an earlier trace is the only thing that member does. Carrying the trace
  /// alongside the value lets `visitTryStatement` hand the script what actually
  /// happened.
  final StackTrace? originalStackTrace;

  /// Creates a new runtime error with the given message. When
  /// [originalException] is supplied, the wrapped native exception stays
  /// catchable by type; supply [originalStackTrace] from the same `catch`
  /// clause so the trace survives the wrapping too.
  RuntimeD4rtException(super.message,
      {this.originalException, this.originalStackTrace});

  @override
  String toString() => 'Runtime Error: $message';
}

/// Thrown when a script names a bridged class by its simple name and two
/// different libraries in scope declare a class under that name.
///
/// This mirrors Dart's own ambiguous-import rule. Once
/// `package:tom_doc_scanner/…` and `package:tom_md2latex/…` are both imported
/// unprefixed, the bare name `MarkdownParser` designates nothing in
/// particular; Dart rejects the reference and asks for a prefix. D4rt does the
/// same, because the alternative — binding the name to whichever bridge
/// happened to register last — silently picks a class the author never named,
/// and the script then fails somewhere else (or, worse, succeeds against the
/// wrong implementation).
///
/// [candidatesByQualifier] maps each qualifier a script can use (the package
/// name of the declaring library) to the source URI that qualifier resolves
/// to. Writing `tom_doc_scanner.MarkdownParser` selects one unambiguously.
class AmbiguousBridgedNameException extends D4rtException {
  /// The simple name that resolves to more than one bridged class.
  final String name;

  /// Qualifier → source URI, for every candidate reachable by qualification.
  final Map<String, String> candidatesByQualifier;

  /// Creates the ambiguity error for [name] over [candidatesByQualifier].
  AmbiguousBridgedNameException(this.name, this.candidatesByQualifier)
      : super(_buildMessage(name, candidatesByQualifier));

  static String _buildMessage(
      String name, Map<String, String> candidatesByQualifier) {
    final buffer = StringBuffer()
      ..write("The name '$name' is declared by more than one library in "
          "scope, so it cannot be used unqualified. Candidates:");
    candidatesByQualifier.forEach((qualifier, sourceUri) {
      buffer.write("\n  $qualifier.$name  ($sourceUri)");
    });
    buffer.write("\nQualify the reference with the package name shown above, "
        "e.g. '${candidatesByQualifier.keys.first}.$name'.");
    return buffer.toString();
  }

  @override
  String toString() => 'Ambiguous Name Error: $message';
}

/// Exception for state-related errors in D4rt components.
class StateD4rtException extends D4rtException {
  /// Creates a new state error with the given message.
  StateD4rtException(super.message);

  @override
  String toString() => 'State Error: $message';
}

/// Exception for argument-related errors in D4rt components.
class ArgumentD4rtException extends D4rtException {
  /// Creates a new argument error with the given message.
  ArgumentD4rtException(super.message);

  @override
  String toString() => 'Argument Error: $message';
}

/// Exception for range-related errors in D4rt components.
class Ranged4rtException extends D4rtException {
  /// Creates a new range error with the given message.
  Ranged4rtException(super.message);

  @override
  String toString() => 'Range Error: $message';
}

/// Exception for unsupported operations in D4rt components.
class UnsupportedD4rtException extends D4rtException {
  /// Creates a new unsupported error with the given message.
  UnsupportedD4rtException(super.message);

  @override
  String toString() => 'Unsupported Error: $message';
}

/// Exception for unimplemented features in D4rt components.
class UnimplementedD4rtException extends D4rtException {
  /// Creates a new unimplemented error with the given message.
  UnimplementedD4rtException(super.message);

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
class SourceCodeD4rtException extends D4rtException {
  /// The optional problematic code that caused the exception.
  final String? problematicCode;

  /// Creates a new source code exception with the given message and optional code.
  SourceCodeD4rtException(super.message, [this.problematicCode]);

  @override
  String toString() {
    if (problematicCode != null) {
      return 'SourceCodeException: $message\nProblematic code: [$problematicCode]';
    }
    return 'SourceCodeException: $message';
  }
}

/// DFUB13 — names the module that ASKED for a target that failed to load.
///
/// The loader's own diagnostic names the module it could not find. That is the
/// symptom; the file the user has to edit is the one holding the directive, and
/// in a barrel chain those are rarely the same file. [directiveType] is
/// `'import'` or `'export'`, [ownerUri] the module containing the directive,
/// [targetUri] the module it pointed at.
///
/// The concrete exception type is preserved so existing `on ...` clauses keep
/// matching — only the message gains a prefix. A type this function cannot
/// reconstruct is returned unchanged rather than downgraded to a base type.
///
/// Returns [error] unchanged when it already carries context (see
/// [D4rtException.hasDirectiveContext]) so a deep import chain yields one
/// prefix rather than one per frame.
D4rtException wrapDirectiveError(
  String directiveType,
  Uri ownerUri,
  Uri targetUri,
  D4rtException error,
) {
  if (error.hasDirectiveContext) return error;
  final message =
      'Failed to load $directiveType "$targetUri" from module "$ownerUri": '
      '${error.message}';
  final D4rtException? wrapped = switch (error) {
    SourceCodeD4rtException e =>
      SourceCodeD4rtException(message, e.problematicCode),
    RuntimeD4rtException e =>
      RuntimeD4rtException(message, originalException: e.originalException),
    _ => null,
  };
  // An unreconstructable type is returned untouched AND unflagged, so an outer
  // frame that can wrap is still free to do so.
  if (wrapped == null) return error;
  wrapped.hasDirectiveContext = true;
  return wrapped;
}

/// Internal exception wrapper for user-thrown exceptions.
///
/// This helps distinguish between user 'throw x' exceptions and internal
/// interpreter control flow exceptions like Return/Break/Continue.
/// It wraps the original thrown value for proper exception handling.
class InternalInterpreterD4rtException extends D4rtException {
  /// The original value that was thrown by user code.
  final Object? originalThrownValue;
  // StackTrace could be stored here if needed directly,
  // but catch in visitTryStatement already gets it.

  /// Creates a new internal interpreter exception wrapping the original thrown value.
  InternalInterpreterD4rtException(this.originalThrownValue)
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
class PatternMatchD4rtException extends D4rtException {
  /// Creates a new pattern match exception with the given message.
  PatternMatchD4rtException(super.message);

  @override
  String toString() => "PatternMatchException: $message";
}

/// Exception thrown by [D4.unwrapAs] when an interpreter result cannot be
/// converted to the requested native type [T].
///
/// Carries enough context (the requested type description, the actual runtime
/// type, and an optional source description) to make the failure actionable
/// for embedders that translate interpreter results to native Dart values.
///
/// Example:
/// ```dart
/// try {
///   final widget = D4.unwrapAs<Widget>(result, visitor: visitor);
/// } on D4UnwrapException catch (e) {
///   print(e); // -> Expected Widget but got String (from raw value)
/// }
/// ```
class D4UnwrapException extends D4rtException {
  /// String description of the expected type (typically `T.toString()`).
  final String expectedType;

  /// String description of the value's actual runtime type.
  final String actualType;

  /// Optional human-readable description of where the value came from
  /// (e.g. `BridgedInstance<Widget>` or `InterpretedInstance(MyClass)`).
  final String? source;

  /// Creates a new unwrap exception.
  D4UnwrapException({
    required this.expectedType,
    required this.actualType,
    this.source,
    String? extra,
  }) : super(_buildMessage(expectedType, actualType, source, extra));

  static String _buildMessage(
    String expectedType,
    String actualType,
    String? source,
    String? extra,
  ) {
    final base = source == null
        ? 'Expected $expectedType but got $actualType'
        : 'Expected $expectedType but got $actualType (from $source)';
    return extra == null ? base : '$base — $extra';
  }

  @override
  String toString() => 'D4UnwrapException: $message';
}
