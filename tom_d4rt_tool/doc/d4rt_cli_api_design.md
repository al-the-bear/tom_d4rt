# D4rt CLI API Design

**Quest:** cli_dartbridge  
**Date:** 2026-02-02  
**Status:** Design Draft (Rev 3)

---

## Overview

This document describes the design for extracting a programmatic API from the D4rt REPL implementation, enabling scripts to interact with CLI functionality through a global `cli` variable.

### Goals

1. **Programmatic Access**: Allow D4rt scripts to invoke REPL commands without interactive terminal
2. **Global Variable Pattern**: Expose API as `cli.replay(...)`, `cli.processPrompt(...)`, etc.
3. **Complete Command Coverage**: Every REPL command maps to an API method
4. **Preserve Semantics**: Maintain current behavior for nested execution, directory context, and session handling
5. **Minimal Refactoring**: Extract API without breaking existing REPL functionality

---

## Usage Examples

```dart
// Execute a prompt as if typed in REPL (supports multiline)
cli.processPrompt('classes');
cli.processPrompt('.session mywork');
cli.processPrompt('define greet=print("Hello, \$1!")');

// Multiline code via processPrompt
cli.processPrompt('.start-script');
cli.processPrompt('var x = 1;');
cli.processPrompt('var y = 2;');
cli.processPrompt('return x + y;');
cli.processPrompt('.end');

// Replay files (new extensions: *.d4rt for D4rt, *.dcli for DCli)
await cli.replay('setup.d4rt');
await cli.load('~/scripts/init.dcli');  // with output

// Access process/platform info
print(cli.runtime.processDirectory);  // Directory.current
print(cli.runtime.platform.operatingSystem);
print(cli.runtime.pid);

// Direct API access
final allClasses = cli.classes();
cli.cd('/path/to/project');
print(cli.cwd());

// Execute code with basePath for import resolution
final result = await cli.execute('''
import 'lib/helpers.dart';
void main() => runHelper();
''', basePath: '/my/project');

// Session management
cli.session('debug-session');
cli.reset();

// Load file contents (instead of print-*)
final content = cli.loadFile('mycode.d4rt.dart');
final sessionContent = cli.loadSession('debug');
```

---

## Working Directory vs CWD

### Clarification

| Term | Meaning |
|------|---------|
| `cwd` | The **CLI's current working directory** for resolving relative paths in REPL commands |
| `cd` | Command to **change** the CLI's `cwd` |
| `Directory.current` | The **process's** working directory (system level, unchanged by `cd`) |

The CLI maintains its own `cwd` separate from `Directory.current`. This allows:
- Scripts to navigate directories without affecting the actual process
- Nested replay files to have isolated directory contexts
- Predictable path resolution regardless of how the CLI was launched

```dart
// Example: cd changes CLI's cwd, not the process directory
cli.cd('/project');
print(cli.cwd());           // → /project
print(Directory.current.path); // → unchanged, e.g., /Users/me
```

---

## Architecture

### Separation of Concerns

```
┌─────────────────────────────────────────────────────────────────────┐
│                         D4rtReplBase                                │
│  (Terminal UI Layer - handles Console I/O, prompts, readline)      │
│  Dependencies: dart_console (^4.1.2), console_markdown (^0.0.3)    │
├─────────────────────────────────────────────────────────────────────┤
│                         D4rtCliController                           │
│  (Command Logic Layer - pure command processing, no I/O)           │
├─────────────────────────────────────────────────────────────────────┤
│                         D4rtCliApi                                  │
│  (Public API Interface - exposed as `cli` global)                  │
├─────────────────────────────────────────────────────────────────────┤
│                         CliState                                    │
│  (State Container - directory, session, defines, context stack)    │
│  NO Console dependency - pure Dart, no I/O packages                │
└─────────────────────────────────────────────────────────────────────┘
```

### Console Package Separation

The `ReplState` class currently depends on `dart_console` for terminal I/O. The refactoring must cleanly separate:

| Layer | Console Dependency | Package Imports |
|-------|-------------------|-----------------|
| `CliState` | ❌ None | `dart:io` (File, Directory only) |
| `ExecutionContext` | ❌ None | None |
| `D4rtCliController` | ❌ None | D4rt, CliState |
| `ReplState` | ✅ Yes | `dart_console`, `console_markdown` |
| `D4rtReplBase` | ✅ Yes | `dart_console`, `console_markdown` |

### Class Responsibilities

| Class | Responsibility |
|-------|----------------|
| `D4rtCliApi` | Abstract interface defining all CLI operations |
| `D4rtCliController` | Concrete implementation, stateless command processing |
| `CliState` | Mutable state container (no Console dependency) |
| `D4rtReplBase` | Terminal UI wrapper, delegates to controller |
| `cli` global | Singleton instance of `D4rtCliApi` bound to current D4rt |

---

## API Interface - Complete Command Mapping

Every REPL command maps to an API method. Commands are organized by category matching the help output.

```dart
/// Programmatic interface to D4rt CLI functionality.
/// 
/// Accessed via the `cli` global variable in D4rt scripts.
abstract class D4rtCliApi {
  
  // ═══════════════════════════════════════════════════════════════════
  // CORE: Prompt Processing
  // ═══════════════════════════════════════════════════════════════════
  
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

  // ═══════════════════════════════════════════════════════════════════
  // COMMANDS: General Commands
  // Maps to: help, info, classes, enums, methods, variables, imports,
  //          registered-*, show-init, clear, exit/quit
  // ═══════════════════════════════════════════════════════════════════
  
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
  List<MethodInfo> methods();
  
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
  List<MethodInfo> registeredMethods();
  
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

  // ═══════════════════════════════════════════════════════════════════
  // DEFINES: Command Aliases
  // Maps to: define, undefine, defines, .load-defines, $<name>
  // ═══════════════════════════════════════════════════════════════════
  
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
  /// Maps to: `$<name> [args]`
  /// 
  /// Returns the expanded command, or null if define not found.
  String? invokeDefine(String name, [List<String>? args]);
  
  /// Expand a define invocation string (e.g., "$greet World").
  /// Returns null if input doesn't match any define.
  String? expandDefine(String input);

  // ═══════════════════════════════════════════════════════════════════
  // DIRECTORY: Navigation and Listing
  // Maps to: sessions, scripts, plays, executes, ls, cd, cwd, home
  // ═══════════════════════════════════════════════════════════════════
  
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

  // ═══════════════════════════════════════════════════════════════════
  // MULTILINE: Multiline Input Modes
  // Maps to: .start-define, .start-script, .start-file, .start-execute, .end
  // ═══════════════════════════════════════════════════════════════════
  
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

  // ═══════════════════════════════════════════════════════════════════
  // FILES & SESSIONS: File Execution and Session Management
  // Maps to: .execute, .file, .script, .load, .replay, .session, .reset
  // ═══════════════════════════════════════════════════════════════════
  
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

  // ═══════════════════════════════════════════════════════════════════
  // LOAD FILE CONTENTS: Read files without printing
  // Replaces: .print-file, .print-script, .print-replay, .print-session
  // ═══════════════════════════════════════════════════════════════════
  
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

  // ═══════════════════════════════════════════════════════════════════
  // EXPRESSION EVALUATION
  // ═══════════════════════════════════════════════════════════════════
  
  /// Evaluate an expression and return the result.
  /// 
  /// This is the default action for non-command input.
  /// Supports `await` for async expressions.
  Future<dynamic> eval(String expression);

  // ═══════════════════════════════════════════════════════════════════
  // STATE: Direct State Access
  // ═══════════════════════════════════════════════════════════════════
  
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

/// Provides access to process and platform runtime information.
/// 
/// This exposes system-level information that is distinct from the CLI's
/// virtual working directory (`cwd`). While `cli.cwd()` returns the CLI's
/// navigated directory, `cli.runtime.processDirectory` returns the actual
/// process working directory (`Directory.current`).
abstract class CliRuntime {
  /// The actual process working directory (`Directory.current.path`).
  /// 
  /// Unlike `cli.cwd()`, this reflects the real process directory.
  /// Changing this affects the actual process, not just CLI path resolution.
  String get processDirectory;
  
  /// Set the actual process working directory (`Directory.current`).
  /// 
  /// Warning: This affects the entire process, not just CLI navigation.
  set processDirectory(String path);
  
  /// The Directory object for the current process directory.
  Directory get processDirectoryObject;
  
  /// The process ID of the current Dart VM.
  int get pid;
  
  /// Path to the Dart executable running this process.
  String get executable;
  
  /// The resolved path to the Dart executable.
  String get resolvedExecutable;
  
  /// Arguments passed to the executable.
  List<String> get executableArguments;
  
  /// The script URI being executed.
  Uri get script;
  
  /// The Dart version string.
  String get version;
  
  /// Environment variables as a map.
  Map<String, String> get environment;
  
  /// Operating system name (e.g., 'linux', 'macos', 'windows').
  String get operatingSystem;
  
  /// Operating system version.
  String get operatingSystemVersion;
  
  /// Number of processors available.
  int get numberOfProcessors;
  
  /// Local hostname.
  String get localHostname;
  
  /// Path separator for the current platform ('/' or '\').
  String get pathSeparator;
  
  /// Whether running on Linux.
  bool get isLinux;
  
  /// Whether running on macOS.
  bool get isMacOS;
  
  /// Whether running on Windows.
  bool get isWindows;
  
  /// Whether running on Android.
  bool get isAndroid;
  
  /// Whether running on iOS.
  bool get isIOS;
}

/// Multiline mode types.
enum MultilineMode { 
  /// Not in multiline mode.
  none,
  /// `.start-script` - run code block with return value
  script,
  /// `.start-file` - run as file in current environment
  file,
  /// `.start-execute` - run as fresh program  
  executeNew,
  /// `.start-define` - define functions/classes (persists)
  define,
}
```

---

## Multiline Mode Exceptions

### Method Restrictions in Multiline Mode

When the CLI is in multiline mode (after `.start-*` but before `.end`), certain API methods are invalid and will throw exceptions.

### InvalidMultilineModeException

```dart
/// Thrown when a method is called that is invalid in the current multiline mode.
class InvalidMultilineModeException extends CliException {
  final MultilineMode currentMode;
  final String attemptedMethod;
  
  InvalidMultilineModeException({
    required this.currentMode,
    required this.attemptedMethod,
  }) : super(
    'Cannot call $attemptedMethod while in multiline mode ($currentMode). '
    'Call .end first to complete the multiline block, or clearMultilineBuffer() to cancel.',
  );
}
```

### Method Behavior by Multiline State

| Method Category | In Multiline Mode? | Behavior |
|-----------------|-------------------|----------|
| **processPrompt()** | ✓ Allowed | Accumulates lines or handles `.end` |
| **startDefine/Script/File/Execute()** | ✗ Throws | Already in multiline mode |
| **end()** | ✓ Allowed | Executes buffer and exits mode |
| **clearMultilineBuffer()** | ✓ Allowed | Cancels without executing |
| **replay(), load(), script()** | ✗ Throws | Cannot nest file execution in multiline |
| **execute(), executeContinued()** | ✗ Throws | Cannot run code while buffering |
| **session(), reset()** | ✗ Throws | Cannot switch context mid-buffer |
| **cd(), ls(), cwd(), home()** | ✓ Allowed | Directory navigation OK |
| **classes(), methods(), etc.** | ✓ Allowed | Read-only queries OK |
| **define(), defines()** | ✓ Allowed | Alias management OK |
| **eval()** | ✗ Throws | Cannot evaluate while buffering |

### Implementation Pattern

```dart
void _assertNotInMultilineMode(String methodName) {
  if (multilineMode != MultilineMode.none) {
    throw InvalidMultilineModeException(
      currentMode: multilineMode,
      attemptedMethod: methodName,
    );
  }
}

void _assertInMultilineMode(String methodName) {
  if (multilineMode == MultilineMode.none) {
    throw CliException('$methodName requires multiline mode to be active.');
  }
}

Future<ExecuteResult> execute(String source, {String? basePath}) async {
  _assertNotInMultilineMode('execute');
  // ... implementation
}

Future<dynamic> end() async {
  _assertInMultilineMode('end');
  // ... implementation
}

void startScript() {
  _assertNotInMultilineMode('startScript');
  multilineMode = MultilineMode.script;
}
```

### User Recovery Options

When `InvalidMultilineModeException` is thrown, users can:

1. **Complete the block**: Call `.end` or `cli.end()` to execute the buffered code
2. **Cancel the block**: Call `cli.clearMultilineBuffer()` to discard and reset mode
3. **Check state first**: Query `cli.isMultilineMode` before calling restricted methods

---

## Multiline Handling in API and Replay

### Design Decision: Why processPrompt() MUST Support Multiline

**Original recommendation was wrong.** After analysis, `processPrompt()` MUST support multiline because:

1. **Replay files can contain multiline blocks:**
   ```
   # setup.d4rt
   .start-define
   class Helper {
     void run() => print('Hello');
   }
   .end
   ```

2. **`.load` and `.replay` call `processPrompt()` for each line:**
   - When replaying the above file, each line goes through `processPrompt()`
   - If multiline isn't supported, `.start-define` would fail

3. **Scripts can dynamically build multiline input:**
   ```dart
   cli.processPrompt('.start-script');
   for (var i = 0; i < 10; i++) {
     cli.processPrompt('print($i);');
   }
   cli.processPrompt('.end');
   ```

### Multiline State Machine

```dart
class CliState {
  MultilineMode multilineMode = MultilineMode.none;
  final List<String> multilineBuffer = [];
}

Future<dynamic> processPrompt(String line) async {
  final trimmed = line.trim();
  
  // Handle multiline mode transitions
  if (trimmed == '.start-define') {
    multilineMode = MultilineMode.define;
    return null;
  }
  if (trimmed == '.start-script') {
    multilineMode = MultilineMode.script;
    return null;
  }
  if (trimmed == '.start-file') {
    multilineMode = MultilineMode.file;
    return null;
  }
  if (trimmed == '.start-execute') {
    multilineMode = MultilineMode.executeNew;
    return null;
  }
  
  // Accumulate lines in multiline mode
  if (multilineMode != MultilineMode.none) {
    if (trimmed == '.end') {
      return _executeMultilineBuffer();
    }
    multilineBuffer.add(line); // Preserve original indentation
    return null;
  }
  
  // Normal command processing
  return _executeCommand(line);
}

Future<dynamic> _executeMultilineBuffer() async {
  final code = multilineBuffer.join('\n');
  final mode = multilineMode;
  
  multilineBuffer.clear();
  multilineMode = MultilineMode.none;
  
  switch (mode) {
    case MultilineMode.script:
      return _executeScript(code);
    case MultilineMode.file:
      return executeContinued(code);
    case MultilineMode.executeNew:
      return execute(code);
    case MultilineMode.define:
      return d4rt.eval(code);
    case MultilineMode.none:
      return null;
  }
}
```

### Multiline in Nested Replay

When a replay file contains multiline blocks, the context stack handles it correctly:

```
1. cli.replay('setup.d4rt')
   └── Push context
   
2. Line 1: .start-define
   └── multilineMode = define, buffer = []
   
3. Line 2: class Helper {
   └── buffer = ['class Helper {']
   
4. Line 3:   void run() => print('Hello');
   └── buffer = ['class Helper {', '  void run() => print('Hello');']
   
5. Line 4: }
   └── buffer = ['class Helper {', '  void run()...', '}']
   
6. Line 5: .end
   └── Execute buffer, clear mode
   
7. Continue with remaining lines...

8. Replay completes
   └── Pop context
```

### Nested Replay with Nested Multiline

```
# outer.d4rt
.load inner.d4rt
print('after inner');

# inner.d4rt  
.start-script
var x = 1;
return x + 1;
.end
```

The multiline state is per-context, so nested replays don't interfere:

```dart
class ExecutionContext {
  final String workingDirectory;
  final String? sourceFile;
  final bool silent;
  
  // Each context has its own multiline state
  MultilineMode multilineMode = MultilineMode.none;
  final List<String> multilineBuffer = [];
}
```

---

## Execution Context Stack

### Problem: Nested Replay and Directory Context

When replaying files, several context aspects must be managed:

1. **Working Directory**: Relative paths in a replay file should resolve from that file's location
2. **Nested Replays**: A replay file can trigger another replay via `.load` or `.replay`
3. **Multiline State**: Each replay context needs its own multiline buffer
4. **Error Unwinding**: On error, all context levels must unwind properly
5. **Session Recording**: Only top-level commands should record to session

### Known Bug in Current Implementation

> **⚠️ BUG**: The current REPL implementation has a bug where multiline state is global,
> not per-context. This can be triggered with `.replay`/`.load` commands that contain
> multiline blocks. If a nested replay file starts a multiline block, it corrupts the
> parent context's multiline state.
>
> **Example of bug trigger:**
> ```
> # outer.d4rt
> .start-script
> var x = 1;
> .load inner.d4rt    # inner.d4rt also has .start-script
> return x;
> .end
> ```
> 
> The implementation in this design fixes this bug by moving multiline state into
> `ExecutionContext`, giving each nested execution its own isolated multiline buffer.

### Solution: Execution Context Stack

```dart
/// Represents a single execution context in the stack.
class ExecutionContext {
  /// The working directory for this context.
  final String workingDirectory;
  
  /// The source file being executed (null for interactive).
  final String? sourceFile;
  
  /// Whether to record commands to session.
  final bool recordToSession;
  
  /// Whether output is suppressed.
  final bool silent;
  
  /// Multiline mode for this context.
  MultilineMode multilineMode = MultilineMode.none;
  
  /// Multiline buffer for this context.
  final List<String> multilineBuffer = [];
  
  /// Parent context (null for root).
  final ExecutionContext? parent;
}

/// Manages the execution context stack.
class ContextStack {
  final _stack = <ExecutionContext>[];
  
  /// Current context (top of stack).
  ExecutionContext get current => _stack.last;
  
  /// Push a new context for file execution.
  void push(ExecutionContext context) => _stack.add(context);
  
  /// Pop context after execution completes.
  ExecutionContext pop() => _stack.removeLast();
  
  /// Current working directory.
  String get cwd => current.workingDirectory;
  
  /// Whether currently in silent mode.
  bool get silent => current.silent;
  
  /// Depth of nesting (0 = interactive).
  int get depth => _stack.length - 1;
}
```

### Execution Flow

```
1. User calls: cli.replay('setup.d4rt')
   └── Push context: { cwd: '/project', file: 'setup.d4rt', silent: false }
   
2. setup.d4rt line 5: .load libs/common.d4rt
   └── Push context: { cwd: '/project/libs', file: 'common.d4rt', silent: false }
   
3. common.d4rt completes
   └── Pop context → restore cwd to '/project'
   
4. setup.d4rt completes
   └── Pop context → restore original cwd
```

### Directory Resolution Rules

```dart
String resolvePath(String path) {
  if (path.startsWith('/')) {
    // Absolute path - use as-is
    return path;
  } else if (path.startsWith('~/')) {
    // Home expansion
    return '${Platform.environment['HOME']}${path.substring(1)}';
  } else if (path == '-') {
    // Data directory shortcut
    return dataDirectory;
  } else {
    // Relative path - resolve from current context's cwd
    return '${contextStack.cwd}/$path';
  }
}
```

---

## Session Recording

### Rules for Session Recording

| Context | Record to Session? |
|---------|-------------------|
| Interactive prompt | ✓ Yes |
| Top-level `processPrompt()` | ✓ Yes (if session active) |
| Inside `replay()` / `load()` | ✗ No (replay is atomic) |
| Inside nested replay | ✗ No |
| `recordToSession: true` param | ✓ Force recording |

### Implementation

```dart
Future<dynamic> processPrompt(String line, {bool? recordToSession}) async {
  final shouldRecord = recordToSession ?? 
    (contextStack.depth == 0 && currentSessionId != null);
  
  if (shouldRecord) {
    _appendToSessionFile(line);
  }
  
  return _executeCommand(line);
}
```

---

## D4rt Stdlib Imports

### Available Bridged Packages

The D4rt stdlib provides bridges for the following Dart core packages. These are registered during D4rt initialization and available in the REPL environment.

| Package | Key Classes/APIs | Notes |
|---------|------------------|-------|
| `dart:core` | Object, String, int, double, bool, List, Map, Set, DateTime, Duration, RegExp, Exception, Error | Always available |
| `dart:async` | Future, Stream, Completer, Timer, StreamController | Registered by default |
| `dart:io` | File, Directory, Platform, Process, Socket, ServerSocket, stdin, stdout, stderr, HttpClient, HttpServer | IO platform only |
| `dart:isolate` | Isolate, SendPort, ReceivePort, Capability | Registered |
| `dart:collection` | HashMap, LinkedHashMap, Queue, etc. | Registered |
| `dart:convert` | json, utf8, base64, ascii, latin1 | Registered |
| `dart:math` | Random, min, max, sin, cos, sqrt, pi, e | Registered |
| `dart:typed_data` | Uint8List, Int32List, ByteData, etc. | Registered |

### Key Classes for CLI API

The `CliRuntime` interface exposes these bridged classes:

```dart
// Directory.current is already bridged with getter/setter
print(Directory.current.path);        // Works in D4rt
Directory.current = Directory('/tmp'); // Works in D4rt

// Platform static getters are bridged
print(Platform.operatingSystem);       // Works in D4rt
print(Platform.environment['HOME']);   // Works in D4rt

// Process static methods are bridged
final result = await Process.run('ls', ['-la']);  // Works in D4rt
```

### Init Source Considerations

The CLI should ensure these imports are available in the init source block so scripts can use them directly:

```dart
// Suggested init source imports (generated by getImportBlock()):
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'dart:collection';
import 'dart:typed_data';
// Note: dart:isolate may require special handling for sandboxed contexts
```

---

## Global Variable Registration

### Bridge Registration vs Initialization

The `cli` global follows a two-phase pattern:

1. **Registration**: Happens during bridge registration (early)
2. **Initialization**: Happens later when the REPL/CLI is ready with full context

This separation is necessary because:
- Bridge registration happens before the REPL is fully configured
- The `cli` API needs access to the D4rt instance AND the CLI controller
- Some state (like data directory, session management) isn't available during registration

### Export Barrel

```dart
// lib/tom_d4rt_cli_api.dart
/// Export barrel for D4rt CLI API.
/// 
/// This barrel exports all types needed for the `cli` global variable
/// and is used by the bridge generator.
library;

export 'src/api/cli_api.dart';
export 'src/api/cli_controller.dart';
export 'src/api/cli_state.dart';
export 'src/api/cli_exceptions.dart';
export 'src/api/cli_result_types.dart';
export 'src/api/cli_runtime.dart';
export 'src/api/execution_context.dart';
```

### Build Configuration

```yaml
# In tom_d4rt_dcli/build.yaml
modules:
  - name: cli_api
    barrelFiles:
      - package:tom_d4rt_dcli/tom_d4rt_cli_api.dart
    barrelImport: package:tom_d4rt_dcli/tom_d4rt_cli_api.dart
    outputPath: lib/src/bridges/cli_api_bridge.dart
```

### Two-Phase Initialization

```dart
// Phase 1: Registration (during bridge init)
// Creates a placeholder or uninitialized controller
class CliGlobalHolder {
  D4rtCliController? _controller;
  
  D4rtCliController get controller {
    if (_controller == null) {
      throw CliException('cli global not yet initialized. '
        'This happens when accessing cli before REPL startup.');
    }
    return _controller!;
  }
  
  void initialize(D4rtCliController controller) {
    _controller = controller;
  }
  
  bool get isInitialized => _controller != null;
}

// Register during bridge registration
void registerBridges(D4rt d4rt) {
  TomD4rtDcliBridge.register(d4rt);
  // Register cli holder - not yet initialized
  d4rt.defineGlobal('cli', _cliHolder);
}

// Phase 2: Initialization (during REPL startup)
void initializeCli(D4rt d4rt, CliState state) {
  final controller = D4rtCliController(d4rt, state);
  _cliHolder.initialize(controller);
}

// Called during REPL/CLI startup after bridge registration
void registerBridges(D4rt d4rt) {
  TomD4rtDcliBridge.register(d4rt);
  initializeCliGlobal(d4rt);
}
```

### Init Source Integration

```dart
// Generated in getImportBlock():
// import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';

// Available in D4rt scripts:
void main() {
  cli.cd('/project');
  cli.replay('setup.d4rt');
  final allClasses = cli.classes();
}
```

---

## Error Handling

### Exception Types

```dart
/// Base exception for CLI operations.
class CliException implements Exception {
  final String message;
  final String? command;
  final StackTrace? stackTrace;
  
  CliException(this.message, {this.command, this.stackTrace});
  
  @override
  String toString() => command != null 
    ? 'CliException: $message (command: $command)'
    : 'CliException: $message';
}

/// File not found during execution.
class FileNotFoundException extends CliException {
  final String path;
  FileNotFoundException(this.path) : super('File not found: $path');
}

/// Directory not found during navigation.
class DirectoryNotFoundException extends CliException {
  final String path;
  DirectoryNotFoundException(this.path) : super('Directory not found: $path');
}

/// Error during code execution.
class ExecutionException extends CliException {
  ExecutionException(String message, {String? command, StackTrace? stackTrace})
    : super(message, command: command, stackTrace: stackTrace);
}

/// Error during replay.
class ReplayException extends CliException {
  final String file;
  final int line;
  final CliException cause;
  
  ReplayException(this.file, this.line, this.cause)
    : super('Error at $file:$line: ${cause.message}');
}
```

### Error Propagation in Nested Replay

```dart
Future<int> replay(String path) async {
  final resolvedPath = resolvePath(path);
  final file = File(resolvedPath);
  
  if (!file.existsSync()) {
    throw FileNotFoundException(resolvedPath);
  }
  
  // Push context with its own multiline state
  contextStack.push(ExecutionContext(
    workingDirectory: file.parent.path,
    sourceFile: resolvedPath,
    silent: true, // replay is silent
  ));
  
  try {
    final lines = file.readAsLinesSync();
    var lineNumber = 0;
    
    for (final line in lines) {
      lineNumber++;
      if (line.trim().isEmpty || line.startsWith('#')) continue;
      
      try {
        await processPrompt(line, recordToSession: false);
      } catch (e) {
        if (e is CliException) {
          throw ReplayException(resolvedPath, lineNumber, e);
        }
        rethrow;
      }
    }
    
    return lineNumber;
  } finally {
    // Always restore context (including any incomplete multiline state)
    contextStack.pop();
  }
}
```

---

## Result Types

```dart
/// Result of code execution.
class ExecuteResult {
  final bool success;
  final dynamic result;
  final String? error;
  final StackTrace? stackTrace;
  final int sourcesLoaded;
  
  const ExecuteResult({
    required this.success,
    this.result,
    this.error,
    this.stackTrace,
    this.sourcesLoaded = 1,
  });
}

/// Information about a class in the environment.
class ClassInfo {
  final String name;
  final String? importPath;
  final List<String> constructors;
  final List<String> methods;
  final List<String> getters;
  final List<String> setters;
  final List<String> staticMethods;
}

/// Information about an enum in the environment.
class EnumInfo {
  final String name;
  final String? importPath;
  final List<String> values;
}

/// Information about a method/function.
class MethodInfo {
  final String name;
  final String? importPath;
  final String signature;
  final bool isAsync;
}

/// Information about a variable.
class VariableInfo {
  final String name;
  final String type;
  final bool isFinal;
  final dynamic value;
}

/// Information about an import.
class ImportInfo {
  final String path;
  final List<String> classes;
  final List<String> enums;
  final List<String> functions;
  final List<String> variables;
}

/// Detailed symbol information.
class SymbolInfo {
  final String name;
  final SymbolKind kind;
  final String? documentation;
  final Map<String, dynamic> details;
}

enum SymbolKind { class_, enum_, method, variable, import }
```

---

## Command to Method Mapping Table

| REPL Command | API Method | Notes |
|--------------|------------|-------|
| `help` | `help()` | Returns help text |
| `info [name]` | `info([name])` | Returns SymbolInfo |
| `classes` | `classes()` | Environment classes |
| `enums` | `enums()` | Environment enums |
| `methods` | `methods()` | Environment methods |
| `variables` | `variables()` | Environment variables |
| `imports` | `imports()` | Environment imports |
| `registered-classes` | `registeredClasses()` | Bridge classes |
| `registered-enums` | `registeredEnums()` | Bridge enums |
| `registered-methods` | `registeredMethods()` | Bridge methods |
| `registered-variables` | `registeredVariables()` | Bridge variables |
| `registered-imports` | `registeredImports()` | Bridge imports |
| `show-init` | `showInit()` | Init source |
| `clear` | `clear()` | No-op in API mode |
| `define <n>=<t>` | `define(n, t)` | Create alias |
| `undefine <n>` | `undefine(n)` | Remove alias |
| `defines` | `defines()` | List aliases |
| `.load-defines <path>` | `loadDefines(path)` | Load from file |
| `$<n> [args]` | `invokeDefine(n, args)` | Invoke alias |
| `sessions` | `sessions()` | List session IDs |
| `scripts` | `scripts()` | List *.script.txt |
| `plays` | `plays()` | List *.d4rt / *.dcli |
| `executes` | `executes()` | List *.d4rt.dart |
| `ls` | `ls([path])` | List directory |
| `cd <path>` | `cd(path)` | Change directory |
| `cwd` | `cwd()` | Current directory |
| `home` | `home()` | Go to data dir |
| `.start-define` | `startDefine()` | Enter define mode |
| `.start-script` | `startScript()` | Enter script mode |
| `.start-file` | `startFile()` | Enter file mode |
| `.start-execute` | `startExecute()` | Enter execute mode |
| `.end` | `end()` | Execute buffer |
| `.execute <path>` | `executeFile(path)` | Fresh program |
| `.file <path>` | `file(path)` | Current env |
| `.script <path>` | `script(path)` | Line-by-line |
| `.load <path>` | `load(path)` | Replay with output |
| `.replay <path>` | `replay(path)` | Replay silent |
| `.session <name>` | `session(name)` | Switch session |
| `.reset [name]` | `reset([path])` | Reset env |
| `.print-file <p>` | `loadFile(p)` | Read file content |
| `.print-script <p>` | `loadScript(p)` | Read script content |
| `.print-replay <p>` | `loadReplay(p)` | Read replay content |
| `.print-session <n>` | `loadSession(n)` | Read session content |
| `<expression>` | `eval(expr)` | Evaluate expression |
| `<source code>` | `execute(src, basePath)` | Fresh program |
| (continued) | `executeContinued(src)` | Current env |

---

## Implementation Phases

### Phase 1: Extract State (CliState)

- Create `CliState` class without Console dependency
- Include multiline state (mode, buffer)
- Move state fields from `ReplState` to `CliState`
- Keep `ReplState` as subclass adding Console

### Phase 2: Extract Logic (D4rtCliController)

- Create `D4rtCliController` implementing `D4rtCliApi`
- Move command handlers from `D4rtReplBase`
- Replace print statements with return values
- Implement multiline handling in controller

### Phase 3: Implement Context Stack

- Create `ExecutionContext` and `ContextStack`
- Move multiline state into context
- Refactor `replay()` and `execute()` to use stack
- Add proper error unwinding

### Phase 4: Wire Up ReplBase

- Refactor `D4rtReplBase` to delegate to controller
- Add IO wrapper layer for terminal interaction
- Verify existing behavior preserved

### Phase 5: Register Bridge

- Create export barrel `tom_d4rt_cli_api.dart`
- Add to bridge generator config
- Initialize `cli` global during startup

### Phase 6: Testing

- Unit tests for controller (no terminal)
- Integration tests for replay/context
- Multiline tests across replay boundaries
- E2E tests in D4rt REPL

---

## Files to Create/Modify

### New Files (in `lib/src/api/`)

| File | Description |
|------|-------------|
| `lib/src/api/cli_api.dart` | `D4rtCliApi` abstract interface |
| `lib/src/api/cli_controller.dart` | `D4rtCliController` implementation |
| `lib/src/api/cli_state.dart` | `CliState` container (no Console dependency) |
| `lib/src/api/execution_context.dart` | `ExecutionContext` and `ContextStack` |
| `lib/src/api/cli_exceptions.dart` | Exception types (`CliException`, etc.) |
| `lib/src/api/cli_result_types.dart` | Result types (`ExecuteResult`, `ClassInfo`, etc.) |
| `lib/src/api/cli_runtime.dart` | `CliRuntime` implementation |

### Export Barrel

| File | Description |
|------|-------------|
| `lib/tom_d4rt_cli_api.dart` | Export barrel for all API types (for bridge generation) |

### Files to Modify

| File | Action | Description |
|------|--------|-------------|
| `lib/src/cli/repl_state.dart` | Modify | Extend `CliState`, keep Console methods |
| `lib/src/cli/repl_base.dart` | Modify | Delegate command handling to controller |
| `lib/tom_d4rt_dcli.dart` | Modify | Export API barrel, init cli global |
| `build.yaml` | Modify | Add cli_api module for bridge generation |

---

## File Extensions

### Extension Mapping by Tool

| Extension | Tool | Purpose | Replaces |
|-----------|------|---------|----------|
| `*.d4rt` | D4rt | Replay files for D4rt REPL | `*.replay.txt` |
| `*.dcli` | DCli | Replay files for DCli REPL | `*.replay.txt` |
| `*.d4rt.dart` | D4rt | Executable Dart files for D4rt | `*.exec.dart` |
| `*.script.txt` | Both | Line-by-line script execution | (unchanged) |
| `*.session.txt` | Both | Session recordings | (unchanged) |

### Notes on Extensions

1. **`*.d4rt` and `*.dcli`** are the new standard extensions for replay files:
   - D4rt looks for `*.d4rt` files in the `plays` command
   - DCli looks for `*.dcli` files in the `plays` command
   - Both can be executed with `.replay` or `.load`
   - The content format is identical (one command per line)

2. **`*.d4rt.dart`** replaces `*.exec.dart`:
   - Used for executable Dart source files
   - Listed by the `executes` command
   - Executed with `.execute <file>`
   - The `.dart` suffix ensures IDE support for syntax highlighting

3. **Cross-tool compatibility**:
   - `*.dcli` files CAN be run in d4rt, but may have issues if they contain commands with special meaning in d4rt but not in dcli
   - `*.d4rt` files should NOT be run in dcli if they use d4rt-specific features

### API Method Considerations

The listing methods should filter by the appropriate extensions:

```dart
// In D4rt:
List<String> plays() => _listFiles('*.d4rt');
List<String> executes() => _listFiles('*.d4rt.dart');

// In DCli:
List<String> plays() => _listFiles('*.dcli');
List<String> executes() => _listFiles('*.d4rt.dart'); // Same as D4rt
```

---

## Backward Compatibility

- All existing REPL commands work unchanged
- Session files remain compatible
- Replay files remain compatible (including multiline blocks)
- Old `*.replay.txt` files still work (but new files should use `*.d4rt`/`*.dcli`)
- Old `*.exec.dart` files still work (but new files should use `*.d4rt.dart`)
- `D4rtReplBase` API unchanged for subclasses

---

## Open Questions

1. **Should `cli.replay()` in a script record to session?**  
   Decision: No by default, but allow `recordToSession: true` parameter.

2. **Should `cli` be available in fresh `execute()` contexts?**  
   Decision: Yes, `cli` is always available as it's registered as a bridge.

3. **How to handle infinite recursion in replay?**  
   Decision: Maximum nesting depth (50 levels), throw on exceed.

4. **Incomplete multiline at end of replay file?**  
   Decision: Throw error - multiline block must be closed with `.end`.
