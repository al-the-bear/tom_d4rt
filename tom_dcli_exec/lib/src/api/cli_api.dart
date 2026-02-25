// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// D4rt CLI API Interface - Programmatic access to CLI functionality.
///
/// This file defines the abstract interface for CLI operations that is
/// exposed as the `cli` global variable in D4rt scripts.
library;

import 'package:tom_d4rt_exec/tom_d4rt_exec.dart';

import 'cli_result_types.dart';
import 'cli_runtime.dart';
import 'execution_context.dart';

// =============================================================================
// D4rtCliApi Interface
// =============================================================================

/// Programmatic interface to D4rt CLI functionality.
///
/// Accessed via the `cli` global variable in D4rt scripts.
///
/// This API provides programmatic access to all REPL commands and
/// functionality, enabling:
/// - Script automation of REPL operations
/// - Testing of CLI functionality
/// - Programmatic code execution and introspection
///
/// Example:
/// ```dart
/// // In a D4rt script
/// cli.cd('/project');
/// cli.replay('setup.d4rt');
///
/// final allClasses = cli.classes();
/// for (final c in allClasses) {
///   print('${c.name}: ${c.methods.length} methods');
/// }
///
/// final result = await cli.eval('1 + 2');
/// print(result); // 3
/// ```
abstract class D4rtCliApi {
  // ===========================================================================
  // CORE: Prompt Processing
  // ===========================================================================

  /// Process a command line as if entered interactively.
  ///
  /// This is the primary entry point that routes to all other functionality.
  /// Supports all REPL commands and maintains multiline state.
  ///
  /// **Multiline Support:**
  /// Multiline mode is tracked in the CLI state. When `.start-*` is called,
  /// subsequent `processPrompt()` calls accumulate in the multiline buffer
  /// until `.end` is called.
  ///
  /// Returns the result of the command, or null for commands with no output.
  /// Throws [CliException] for errors.
  ///
  /// Example:
  /// ```dart
  /// cli.processPrompt('classes');           // Single command
  /// cli.processPrompt('.start-script');     // Enter multiline mode
  /// cli.processPrompt('var x = 1;');        // Accumulates
  /// cli.processPrompt('.end');              // Executes multiline block
  /// ```
  Future<dynamic> processPrompt(String line);

  /// Process multiple prompts in sequence.
  ///
  /// Handles multiline mode correctly across calls.
  /// Stops on first error unless [continueOnError] is true.
  Future<List<dynamic>> processPrompts(
    List<String> lines, {
    bool continueOnError = false,
  });

  // ===========================================================================
  // COMMANDS: General Commands
  // Maps to: help, info, classes, enums, methods, variables, imports,
  //          registered-*, show-init, clear, exit/quit
  // ===========================================================================

  /// Show detailed help text.
  /// Maps to: `help`
  String help();

  /// Show details and suggestions for a symbol.
  /// Maps to: `info [name]`
  ///
  /// If [name] is null, shows general info.
  /// If [name] is a package name, shows package details.
  SymbolInfo? info([String? name]);

  /// List classes in current environment.
  /// Maps to: `classes`
  List<ClassInfo> classes();

  /// List enums in current environment.
  /// Maps to: `enums`
  List<EnumInfo> enums();

  /// List methods/functions in current environment.
  /// Maps to: `methods`
  List<FunctionInfo> methods();

  /// List variables in current environment.
  /// Maps to: `variables`
  List<VariableInfo> variables();

  /// Show imports in current environment.
  /// Maps to: `imports`
  List<ImportInfo> imports();

  /// List registered bridge classes.
  /// Maps to: `registered-classes`
  List<ClassInfo> registeredClasses();

  /// List registered bridge enums.
  /// Maps to: `registered-enums`
  List<EnumInfo> registeredEnums();

  /// List registered bridge methods.
  /// Maps to: `registered-methods`
  List<FunctionInfo> registeredMethods();

  /// List registered bridge variables.
  /// Maps to: `registered-variables`
  List<VariableInfo> registeredVariables();

  /// List registered bridge imports.
  /// Maps to: `registered-imports`
  List<ImportInfo> registeredImports();

  /// Show initialization source.
  /// Maps to: `show-init`
  String showInit();

  /// Clear the screen.
  /// Maps to: `clear`
  /// Note: No-op in headless/API mode.
  void clear();

  // ===========================================================================
  // DEFINES: Command Aliases
  // Maps to: define, undefine, defines, .load-defines, @<name>
  // ===========================================================================

  /// Create a command alias.
  /// Maps to: `define <name>=<template>`
  ///
  /// Template supports `$$` (entire args) and `$1`-`$9` (positional args).
  void define(String name, String template);

  /// Remove a command alias.
  /// Maps to: `undefine <name>`
  bool undefine(String name);

  /// List all defines.
  /// Maps to: `defines`
  Map<String, String> defines();

  /// Load defines from a file.
  /// Maps to: `.load-defines <path>`
  ///
  /// Returns number of defines loaded, -1 if file not found.
  int loadDefines(String path);

  /// Invoke a define with arguments.
  /// Maps to: `@<name> [args]`
  ///
  /// Returns the expanded command, or null if define not found.
  String? invokeDefine(String name, [List<String>? args]);

  /// Expand a define invocation string (e.g., "@greet World").
  /// Returns null if input doesn't match any define.
  String? expandDefine(String input);

  // ===========================================================================
  // DIRECTORY: Navigation and Listing
  // Maps to: sessions, scripts, plays, executes, ls, cd, cwd, home
  // ===========================================================================

  /// List session IDs.
  /// Maps to: `sessions`
  List<String> sessions();

  /// List script files (*.script.txt).
  /// Maps to: `scripts`
  List<String> scripts();

  /// List replay files (*.d4rt for D4rt, *.dcli for DCli).
  /// Maps to: `plays`
  List<String> plays();

  /// List executable files (*.d4rt.dart).
  /// Maps to: `executes`
  List<String> executes();

  /// List all files in current (or specified) directory.
  /// Maps to: `ls`
  ///
  /// Returns list of names (directories end with `/`).
  List<String> ls([String? path]);

  /// Change current directory.
  /// Maps to: `cd <path>`
  ///
  /// Supports:
  /// - Absolute paths: `/path/to/dir`
  /// - Relative paths: `./subdir`, `../parent`
  /// - Home expansion: `~/documents`
  /// - Data directory shortcut: `-` (returns to ~/.tom/d4rt)
  ///
  /// Returns the new absolute path.
  /// Throws [DirectoryNotFoundException] if directory doesn't exist.
  String cd(String path);

  /// Show current working directory.
  /// Maps to: `cwd`
  String cwd();

  /// Return to data directory (~/.tom/d4rt or ~/.tom/dcli).
  /// Maps to: `home`
  String home();

  // ===========================================================================
  // MULTILINE: Multiline Input Modes
  // Maps to: .start-define, .start-script, .start-file, .start-execute, .end
  // ===========================================================================

  /// Start multiline define mode (functions/classes persist).
  /// Maps to: `.start-define`
  ///
  /// Subsequent `processPrompt()` calls accumulate lines until `.end`.
  /// On `.end`, content is added to the D4rt environment.
  void startDefine();

  /// Start multiline script mode (run code block with return value).
  /// Maps to: `.start-script`
  ///
  /// Subsequent `processPrompt()` calls accumulate lines until `.end`.
  /// On `.end`, code is executed and result returned.
  void startScript();

  /// Start multiline file mode (run as file in current environment).
  /// Maps to: `.start-file`
  ///
  /// Subsequent `processPrompt()` calls accumulate lines until `.end`.
  /// On `.end`, code is executed with continued environment.
  void startFile();

  /// Start multiline execute mode (run as fresh program).
  /// Maps to: `.start-execute`
  ///
  /// Subsequent `processPrompt()` calls accumulate lines until `.end`.
  /// On `.end`, code is executed in fresh environment.
  void startExecute();

  /// End multiline input and execute.
  /// Maps to: `.end`
  ///
  /// Returns the result of executing the accumulated code.
  Future<dynamic> end();

  /// Check if currently in multiline mode.
  bool get isMultilineMode;

  /// Get the current multiline mode type.
  MultilineMode get multilineMode;

  /// Get the current multiline buffer contents.
  List<String> get multilineBuffer;

  /// Clear multiline buffer without executing.
  void clearMultilineBuffer();

  // ===========================================================================
  // FILES & SESSIONS: File Execution and Session Management
  // Maps to: .execute, .file, .script, .load, .replay, .session, .reset
  // ===========================================================================

  /// Execute source code as a fresh program.
  /// Maps to: `.execute <path>` (when given source) or D4rt.execute()
  ///
  /// Creates a new environment, only bridged classes available.
  /// [basePath] specifies the directory for resolving imports in the source.
  /// If [basePath] is null, uses [cwd].
  Future<ExecuteResult> execute(String source, {String? basePath});

  /// Execute a file as a fresh program.
  /// Maps to: `.execute <path>`
  ///
  /// Resolves imports relative to the file's location.
  Future<ExecuteResult> executeFile(String path);

  /// Execute source code in the current environment (continued).
  /// Maps to D4rt.continuedExecute()
  ///
  /// Code has access to all previously defined variables/functions.
  /// [basePath] specifies the directory for resolving imports.
  Future<ExecuteResult> executeContinued(String source, {String? basePath});

  /// Execute file in current environment.
  /// Maps to: `.file <path>`
  Future<ExecuteResult> file(String path);

  /// Load file line-by-line as script.
  /// Maps to: `.script <path>`
  Future<int> script(String path);

  /// Replay file with output.
  /// Maps to: `.load <path>`
  ///
  /// Executes each line as a command, showing output.
  Future<int> load(String path);

  /// Replay file silently.
  /// Maps to: `.replay <path>`
  ///
  /// Executes each line as a command, suppressing output.
  Future<int> replay(String path);

  /// Switch to a session.
  /// Maps to: `.session <name>`
  ///
  /// If session exists, replays its history.
  /// If new, starts recording to session file.
  Future<void> session(String sessionId);

  /// Reset environment, optionally replay session/file.
  /// Maps to: `.reset [name]`
  Future<void> reset({String? replayPath});

  // ===========================================================================
  // LOAD FILE CONTENTS: Read files without printing
  // Replaces: .print-file, .print-script, .print-replay, .print-session
  // ===========================================================================

  /// Load file contents (*.exec.dart).
  /// Replaces: `.print-file <path>`
  String loadFile(String path);

  /// Load script contents (*.script.txt).
  /// Replaces: `.print-script <path>`
  String loadScript(String path);

  /// Load replay contents (*.replay.txt).
  /// Replaces: `.print-replay <path>`
  String loadReplay(String path);

  /// Load session contents (*.session.txt).
  /// Replaces: `.print-session <name>`
  String loadSession(String sessionId);

  // ===========================================================================
  // EXPRESSION EVALUATION
  // ===========================================================================

  /// Evaluate an expression and return the result.
  ///
  /// This is the default action for non-command input.
  /// Supports `await` for async expressions.
  Future<dynamic> eval(String expression);

  // ===========================================================================
  // STATE: Direct State Access
  // ===========================================================================

  /// The underlying D4rt interpreter.
  D4rt get d4rt;

  /// The data directory (~/.tom/d4rt or ~/.tom/dcli).
  String get dataDirectory;

  /// The tool name (e.g., 'D4rt', 'DCLI').
  String get toolName;

  /// Current session ID, or null if no session active.
  String? get currentSessionId;

  /// Close the current session.
  void closeSession();

  /// Get the D4rt bridge configuration.
  D4rtConfiguration get configuration;

  /// Access process and platform runtime information.
  ///
  /// Provides access to:
  /// - `Directory.current` (the actual process working directory)
  /// - Platform information (OS, version, etc.)
  /// - Process information (pid, executable, etc.)
  ///
  /// See [CliRuntime] for full details.
  CliRuntime get runtime;
}
