// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Execution context and context stack for managing nested execution.
///
/// The execution context stack solves several problems:
/// 1. Working directory management during nested replay files
/// 2. Per-context multiline state (fixing the multiline nesting bug)
/// 3. Session recording control
/// 4. Error unwinding through nested execution
library;

import 'package:tom_d4rt/d4rt.dart';
import 'cli_exceptions.dart';

// =============================================================================
// MultilineMode Enum
// =============================================================================

/// Multiline input mode for accumulated code blocks.
///
/// Each execution context maintains its own multiline mode and buffer,
/// allowing nested replay files with their own multiline blocks.
enum MultilineMode {
  /// Not in multiline mode - normal command execution.
  none,

  /// Script mode: Accumulates code to execute with return value.
  /// Triggered by `.start-script`.
  script,

  /// File mode: Accumulates code to execute in current environment.
  /// Triggered by `.start-file`.
  file,

  /// Execute mode: Accumulates code to execute in fresh environment.
  /// Triggered by `.start-execute`.
  executeNew,

  /// Define mode: Accumulates definitions (classes, functions) to persist.
  /// Triggered by `.start-define`.
  define,
}

// =============================================================================
// ExecutionContext
// =============================================================================

/// Represents a single execution context in the context stack.
///
/// Each context tracks:
/// - Working directory for relative path resolution
/// - Source file being executed (null for interactive)
/// - Session recording preference
/// - Output suppression (silent mode)
/// - Multiline mode and buffer (per-context to fix nesting bug)
///
/// Example context stack during nested replay:
/// ```
/// 1. cli.replay('setup.d4rt')
///    └── Context: { cwd: '/project', file: 'setup.d4rt' }
///
/// 2. setup.d4rt calls .load libs/common.d4rt
///    └── Context: { cwd: '/project/libs', file: 'common.d4rt' }
///
/// 3. common.d4rt completes → pop → restore cwd to '/project'
/// 4. setup.d4rt completes → pop → restore original cwd
/// ```
class ExecutionContext {
  /// Creates an execution context.
  ///
  /// - [workingDirectory]: The working directory for path resolution.
  /// - [sourceFile]: The source file being executed (null for interactive).
  /// - [recordToSession]: Whether to record commands to session file.
  /// - [silent]: Whether output is suppressed.
  /// - [parent]: The parent context (null for root/interactive context).
  ExecutionContext({
    required this.workingDirectory,
    this.sourceFile,
    this.recordToSession = true,
    this.silent = false,
    this.parent,
  });

  /// The working directory for this context.
  ///
  /// Relative paths are resolved from this directory.
  final String workingDirectory;

  /// The source file being executed.
  ///
  /// Null for interactive/REPL context.
  final String? sourceFile;

  /// Whether commands should be recorded to the active session.
  ///
  /// Typically false for nested contexts (replay, load, script).
  final bool recordToSession;

  /// Whether output is suppressed.
  ///
  /// True for `.replay` (silent), false for `.load` (with output).
  final bool silent;

  /// The parent context in the stack.
  ///
  /// Null for the root interactive context.
  final ExecutionContext? parent;

  /// Current multiline input mode for this context.
  ///
  /// Each context has its own multiline state, allowing nested
  /// replay files with independent multiline blocks.
  MultilineMode multilineMode = MultilineMode.none;

  /// Accumulated lines in multiline mode for this context.
  ///
  /// Lines preserve original indentation for code formatting.
  final List<String> multilineBuffer = [];

  /// Whether this context is in multiline mode.
  bool get isMultilineMode => multilineMode != MultilineMode.none;

  /// Whether this is the root (interactive) context.
  bool get isRoot => parent == null;

  /// The depth of this context (0 for root).
  int get depth => parent == null ? 0 : parent!.depth + 1;

  /// Clears the multiline buffer and resets mode to none.
  void clearMultilineBuffer() {
    multilineBuffer.clear();
    multilineMode = MultilineMode.none;
  }

  /// Starts multiline mode with the given type.
  ///
  /// Throws [InvalidMultilineModeException] if already in multiline mode.
  void startMultilineMode(MultilineMode mode) {
    if (multilineMode != MultilineMode.none) {
      throw InvalidMultilineModeException(
        currentMode: multilineMode.name,
        attemptedMethod: 'start${_modeMethodName(mode)}',
      );
    }
    multilineMode = mode;
  }

  /// Adds a line to the multiline buffer.
  ///
  /// Preserves the original line including indentation.
  void addMultilineLine(String line) {
    multilineBuffer.add(line);
  }

  /// Gets the accumulated multiline buffer as joined code.
  String getMultilineCode() {
    return multilineBuffer.join('\n');
  }

  /// Helper to get method name for exception messages.
  String _modeMethodName(MultilineMode mode) {
    switch (mode) {
      case MultilineMode.none:
        return '';
      case MultilineMode.script:
        return 'Script';
      case MultilineMode.file:
        return 'File';
      case MultilineMode.executeNew:
        return 'Execute';
      case MultilineMode.define:
        return 'Define';
    }
  }

  @override
  String toString() {
    final sb = StringBuffer('ExecutionContext(');
    sb.write('cwd: $workingDirectory');
    if (sourceFile != null) sb.write(', file: $sourceFile');
    if (silent) sb.write(', silent');
    if (!recordToSession) sb.write(', noRecord');
    if (isMultilineMode) sb.write(', multiline: $multilineMode');
    sb.write(')');
    return sb.toString();
  }
}

// =============================================================================
// ContextStack
// =============================================================================

/// Manages the execution context stack.
///
/// The context stack tracks nested execution contexts, allowing proper
/// handling of:
/// - Working directory during nested replay files
/// - Per-context multiline state
/// - Session recording control
/// - Error unwinding
///
/// Example:
/// ```dart
/// final stack = ContextStack('/home/user/.tom/d4rt');
///
/// // Interactive context is created automatically
/// print(stack.cwd); // '/home/user/.tom/d4rt'
///
/// // Push context for file execution
/// stack.push(ExecutionContext(
///   workingDirectory: '/project',
///   sourceFile: 'setup.d4rt',
///   recordToSession: false,
/// ));
///
/// print(stack.depth); // 1
/// print(stack.cwd);   // '/project'
///
/// // Pop after execution
/// stack.pop();
/// print(stack.cwd);   // '/home/user/.tom/d4rt'
/// ```
class ContextStack {
  /// Creates a context stack with the given initial working directory.
  ContextStack(String initialWorkingDirectory) {
    // Create the root interactive context
    _stack.add(
      ExecutionContext(
        workingDirectory: initialWorkingDirectory,
        sourceFile: null,
        recordToSession: true,
        silent: false,
        parent: null,
      ),
    );
  }

  /// Maximum nesting depth to prevent infinite recursion.
  static const int maxDepth = 50;

  final List<ExecutionContext> _stack = [];

  /// The current (top) execution context.
  ///
  /// Always returns the context at the top of the stack.
  /// The stack always has at least the root context.
  ExecutionContext get current => _stack.last;

  /// The root (interactive) context.
  ExecutionContext get root => _stack.first;

  /// Current working directory (from current context).
  String get cwd => current.workingDirectory;

  /// Whether output is currently suppressed (from current context).
  bool get silent => current.silent;

  /// Whether to record to session (from current context).
  bool get recordToSession => current.recordToSession;

  /// Current multiline mode (from current context).
  MultilineMode get multilineMode => current.multilineMode;

  /// Whether currently in multiline mode (from current context).
  bool get isMultilineMode => current.isMultilineMode;

  /// Current multiline buffer (from current context).
  List<String> get multilineBuffer => current.multilineBuffer;

  /// Depth of nesting (0 = interactive root).
  int get depth => _stack.length - 1;

  /// Whether at the root (interactive) context.
  bool get isRoot => _stack.length == 1;

  /// Number of contexts in the stack.
  int get length => _stack.length;

  /// Pushes a new execution context onto the stack.
  ///
  /// The new context's [parent] is set to the current context.
  ///
  /// Throws [MaxNestingDepthException] if maximum depth is exceeded.
  void push(ExecutionContext context) {
    if (depth >= maxDepth) {
      throw MaxNestingDepthException(maxDepth);
    }

    // Create new context with parent reference
    final newContext = ExecutionContext(
      workingDirectory: context.workingDirectory,
      sourceFile: context.sourceFile,
      recordToSession: context.recordToSession,
      silent: context.silent,
      parent: current,
    );

    _stack.add(newContext);
  }

  /// Pops the current context and returns to the parent.
  ///
  /// Returns the popped context.
  ///
  /// Throws [StateError] if attempting to pop the root context.
  ExecutionContext pop() {
    if (_stack.length <= 1) {
      throw StateD4rtException('Cannot pop the root execution context');
    }
    return _stack.removeLast();
  }

  /// Pops all contexts above the root, returning to interactive mode.
  ///
  /// Useful for error recovery - unwinding the entire stack.
  void popToRoot() {
    while (_stack.length > 1) {
      _stack.removeLast();
    }
  }

  /// Updates the working directory of the current context.
  ///
  /// This creates a new context with the updated directory.
  void updateWorkingDirectory(String newDirectory) {
    final current = _stack.removeLast();
    _stack.add(
      ExecutionContext(
        workingDirectory: newDirectory,
        sourceFile: current.sourceFile,
        recordToSession: current.recordToSession,
        silent: current.silent,
        parent: current.parent,
      )
        ..multilineMode = current.multilineMode
        ..multilineBuffer.addAll(current.multilineBuffer),
    );
  }

  @override
  String toString() {
    return 'ContextStack(depth: $depth, cwd: $cwd)';
  }
}
