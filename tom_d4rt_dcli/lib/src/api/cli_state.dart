// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// CLI State - Pure state container for CLI operations.
///
/// This file contains the state management classes that are independent
/// of any console/UI concerns. NO console package imports allowed here.
library;

import 'dart:io';

import 'cli_exceptions.dart';
import 'execution_context.dart';

// =============================================================================
// CliState - Pure State Container
// =============================================================================

/// Pure state container for CLI operations.
///
/// This class manages all CLI state without any Console dependency.
/// It handles:
/// - Execution context stack (working directories, multiline state)
/// - Command aliases (defines)
/// - Session file management
/// - Path resolution
///
/// The separation from Console enables:
/// - Testing without terminal dependencies
/// - Headless operation for script execution
/// - Bridge generation without console imports
///
/// Example:
/// ```dart
/// final state = CliState(dataDirectory: '/home/user/.tom/d4rt');
///
/// // Path resolution
/// print(state.cwd); // '/home/user/.tom/d4rt'
/// state.cd('/project');
/// print(state.cwd); // '/project'
///
/// // Aliases
/// state.setDefine('ll', 'ls -la');
/// print(state.getDefine('ll')); // 'ls -la'
/// ```
class CliState {
  /// Creates CLI state with the given data directory.
  ///
  /// The [dataDirectory] is the base directory for CLI data files
  /// (typically `~/.tom/d4rt` or `~/.tom/dcli`).
  ///
  /// The [initialDirectory] is the initial working directory.
  /// If not provided, defaults to [dataDirectory].
  CliState({
    required this.dataDirectory,
    String? initialDirectory,
  }) : contextStack = ContextStack(initialDirectory ?? dataDirectory);

  /// The base data directory for CLI files.
  ///
  /// This is typically `~/.tom/d4rt` for D4rt or `~/.tom/dcli` for DCli.
  final String dataDirectory;

  /// The execution context stack.
  ///
  /// Manages working directories and multiline state for nested execution.
  final ContextStack contextStack;

  /// Command aliases (defines).
  ///
  /// Maps alias names to their expanded values.
  final Map<String, String> _defines = {};

  /// The current session file for recording commands.
  ///
  /// Null when no session is active.
  RandomAccessFile? sessionFile;

  /// The current session identifier.
  ///
  /// Null when no session is active.
  String? currentSessionId;

  // ---------------------------------------------------------------------------
  // Working Directory
  // ---------------------------------------------------------------------------

  /// Current working directory.
  ///
  /// Delegates to the current execution context.
  String get cwd => contextStack.cwd;

  /// Changes the current working directory.
  ///
  /// Supports:
  /// - Absolute paths: `/path/to/dir`
  /// - Relative paths: `./subdir`, `../parent`
  /// - Home expansion: `~/documents`
  /// - Data directory shortcut: `-` (returns to data directory)
  ///
  /// Returns the new absolute path.
  ///
  /// Throws [DirectoryNotFoundException] if the directory doesn't exist.
  String cd(String path) {
    final resolved = resolvePath(path);
    final dir = Directory(resolved);

    if (!dir.existsSync()) {
      throw DirectoryNotFoundException(resolved);
    }

    contextStack.updateWorkingDirectory(resolved);
    return resolved;
  }

  /// Returns to the data directory.
  ///
  /// Equivalent to `cd(dataDirectory)`.
  String home() {
    contextStack.updateWorkingDirectory(dataDirectory);
    return dataDirectory;
  }

  // ---------------------------------------------------------------------------
  // Path Resolution
  // ---------------------------------------------------------------------------

  /// Resolves a path to an absolute path.
  ///
  /// Handles:
  /// - Absolute paths: returned as-is
  /// - Home expansion: `~/...` expands to home directory
  /// - Data directory: `-` returns the data directory
  /// - Relative paths: resolved from current working directory
  String resolvePath(String path) {
    if (path.isEmpty) {
      return cwd;
    }

    // Handle special shortcuts
    if (path == '-') {
      return dataDirectory;
    }

    // Handle home expansion
    if (path.startsWith('~/')) {
      final home = Platform.environment['HOME'] ?? '/';
      return '$home${path.substring(1)}';
    }

    if (path.startsWith('~')) {
      final home = Platform.environment['HOME'] ?? '/';
      return home;
    }

    // Handle absolute paths
    if (path.startsWith('/')) {
      return _normalizePath(path);
    }

    // Handle Windows absolute paths
    if (path.length > 1 && path[1] == ':') {
      return _normalizePath(path);
    }

    // Relative path - resolve from cwd
    return _normalizePath('$cwd/$path');
  }

  /// Normalizes a path by resolving `.` and `..` components.
  String _normalizePath(String path) {
    final parts = path.split('/');
    final normalized = <String>[];

    for (final part in parts) {
      if (part.isEmpty || part == '.') {
        continue;
      }
      if (part == '..') {
        if (normalized.isNotEmpty && normalized.last != '..') {
          normalized.removeLast();
        } else {
          normalized.add(part);
        }
      } else {
        normalized.add(part);
      }
    }

    // Handle root path
    if (path.startsWith('/')) {
      return '/${normalized.join('/')}';
    }

    return normalized.join('/');
  }

  // ---------------------------------------------------------------------------
  // Defines (Aliases)
  // ---------------------------------------------------------------------------

  /// Gets all defined aliases.
  Map<String, String> get defines => Map.unmodifiable(_defines);

  /// Gets a specific define/alias.
  ///
  /// Returns null if not defined.
  String? getDefine(String name) => _defines[name];

  /// Sets a define/alias.
  ///
  /// If [value] is null or empty, removes the define.
  void setDefine(String name, String? value) {
    if (value == null || value.isEmpty) {
      _defines.remove(name);
    } else {
      _defines[name] = value;
    }
  }

  /// Removes a define/alias.
  void removeDefine(String name) {
    _defines.remove(name);
  }

  /// Clears all defines/aliases.
  void clearDefines() {
    _defines.clear();
  }

  // ---------------------------------------------------------------------------
  // Session Management
  // ---------------------------------------------------------------------------

  /// Whether a session is currently active.
  bool get hasActiveSession => currentSessionId != null;

  /// Gets the path to a session file.
  String getSessionPath(String sessionId) {
    return '$dataDirectory/sessions/$sessionId.session.txt';
  }

  /// Starts a new session or resumes an existing one.
  ///
  /// - Creates the session file if it doesn't exist
  /// - Opens for append if it exists
  ///
  /// Returns true if this is a new session, false if resuming.
  bool startSession(String sessionId) {
    closeSession();

    currentSessionId = sessionId;
    final sessionPath = getSessionPath(sessionId);
    final file = File(sessionPath);
    final isNew = !file.existsSync();

    if (isNew) {
      // Create parent directories
      file.parent.createSync(recursive: true);
    }

    sessionFile = file.openSync(mode: FileMode.append);
    return isNew;
  }

  /// Closes the current session.
  void closeSession() {
    sessionFile?.closeSync();
    sessionFile = null;
    currentSessionId = null;
  }

  /// Records a command to the active session.
  ///
  /// Does nothing if no session is active or if we're in a nested context.
  void recordToSession(String command) {
    if (sessionFile == null) return;
    if (!contextStack.recordToSession) return;

    sessionFile!.writeStringSync('$command\n');
  }

  // ---------------------------------------------------------------------------
  // Multiline State (delegated to context)
  // ---------------------------------------------------------------------------

  /// Current multiline mode (from current context).
  MultilineMode get multilineMode => contextStack.multilineMode;

  /// Whether currently in multiline mode (from current context).
  bool get isMultilineMode => contextStack.isMultilineMode;

  /// Current multiline buffer (from current context).
  List<String> get multilineBuffer => contextStack.multilineBuffer;

  /// Clears the multiline buffer (in current context).
  void clearMultilineBuffer() {
    contextStack.current.clearMultilineBuffer();
  }

  // ---------------------------------------------------------------------------
  // Cleanup
  // ---------------------------------------------------------------------------

  /// Cleans up resources.
  ///
  /// Call when the CLI is shutting down.
  void dispose() {
    closeSession();
  }

  @override
  String toString() {
    return 'CliState(cwd: $cwd, session: $currentSessionId)';
  }
}
