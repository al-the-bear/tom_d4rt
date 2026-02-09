// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// D4rt CLI Controller - Implementation of D4rtCliApi.
///
/// This controller implements all CLI operations without Console dependency.
/// It handles command processing, file execution, and introspection.
library;

import 'dart:io';

import 'package:tom_d4rt/tom_d4rt.dart';

import 'cli_api.dart';
import 'cli_exceptions.dart';
import 'cli_result_types.dart';
import 'cli_runtime.dart';
import 'cli_state.dart';
import 'execution_context.dart';

// =============================================================================
// D4rtCliController
// =============================================================================

/// Implementation of [D4rtCliApi] that handles all CLI operations.
///
/// This controller is Console-independent and can be used for:
/// - Interactive REPL (via D4rtReplBase wrapper)
/// - Script automation (via cli global)
/// - Testing (without terminal dependencies)
class D4rtCliController implements D4rtCliApi {
  /// Creates a CLI controller.
  D4rtCliController({
    required D4rt d4rt,
    required CliState state,
    required String toolName,
    CliRuntime? runtime,
  })  : _d4rt = d4rt,
        _state = state,
        _toolName = toolName,
        _runtime = runtime ?? CliRuntimeImpl();

  final D4rt _d4rt;
  final CliState _state;
  final String _toolName;
  final CliRuntime _runtime;

  // ---------------------------------------------------------------------------
  // State Accessors
  // ---------------------------------------------------------------------------

  @override
  D4rt get d4rt => _d4rt;

  @override
  String get dataDirectory => _state.dataDirectory;

  @override
  String get toolName => _toolName;

  @override
  String? get currentSessionId => _state.currentSessionId;

  @override
  D4rtConfiguration get configuration => _d4rt.getConfiguration();

  @override
  CliRuntime get runtime => _runtime;

  // ---------------------------------------------------------------------------
  // CORE: Prompt Processing
  // ---------------------------------------------------------------------------

  @override
  Future<dynamic> processPrompt(String line) async {
    final trimmed = line.trim();

    // Handle empty lines
    if (trimmed.isEmpty) {
      return null;
    }

    // Handle comments
    if (trimmed.startsWith('#')) {
      return null;
    }

    // Handle multiline mode
    if (_state.isMultilineMode) {
      return _handleMultilineInput(line, trimmed);
    }

    // Handle multiline mode transitions
    if (trimmed == '.start-define') {
      startDefine();
      return null;
    }
    if (trimmed == '.start-script') {
      startScript();
      return null;
    }
    if (trimmed == '.start-file') {
      startFile();
      return null;
    }
    if (trimmed == '.start-execute') {
      startExecute();
      return null;
    }

    // Handle standard commands
    return _handleCommand(trimmed);
  }

  @override
  Future<List<dynamic>> processPrompts(
    List<String> lines, {
    bool continueOnError = false,
  }) async {
    final results = <dynamic>[];

    for (final line in lines) {
      try {
        final result = await processPrompt(line);
        results.add(result);
      } catch (e) {
        if (continueOnError) {
          results.add(e);
        } else {
          rethrow;
        }
      }
    }

    return results;
  }

  /// Handle input while in multiline mode.
  Future<dynamic> _handleMultilineInput(String line, String trimmed) async {
    final context = _state.contextStack.current;

    // Check for .end
    if (trimmed == '.end') {
      return end();
    }

    // Accumulate line in buffer
    context.addMultilineLine(line);
    return null;
  }

  /// Handle a standard command.
  Future<dynamic> _handleCommand(String line) async {
    // Help
    if (line == 'help') {
      return help();
    }

    // Clear
    if (line == 'clear') {
      clear();
      return null;
    }

    // Exit/quit - handled by caller
    if (line == 'exit' || line == 'quit') {
      return null;
    }

    // Directory commands
    if (line == 'cwd') {
      return cwd();
    }
    if (line == 'home') {
      return home();
    }
    if (line.startsWith('cd ')) {
      return cd(line.substring(3).trim());
    }
    if (line == 'ls' || line.startsWith('ls ')) {
      final path = line == 'ls' ? null : line.substring(3).trim();
      return ls(path);
    }

    // Listing commands
    if (line == 'sessions') {
      return sessions();
    }
    if (line == 'scripts') {
      return scripts();
    }
    if (line == 'plays') {
      return plays();
    }
    if (line == 'executes') {
      return executes();
    }
    if (line == 'classes') {
      return classes();
    }
    if (line == 'enums') {
      return enums();
    }
    if (line == 'methods') {
      return methods();
    }
    if (line == 'variables') {
      return variables();
    }
    if (line == 'imports') {
      return imports();
    }
    if (line == 'registered-classes') {
      return registeredClasses();
    }
    if (line == 'registered-enums') {
      return registeredEnums();
    }
    if (line == 'registered-methods') {
      return registeredMethods();
    }
    if (line == 'registered-variables') {
      return registeredVariables();
    }
    if (line == 'registered-imports') {
      return registeredImports();
    }
    if (line == 'show-init') {
      return showInit();
    }

    // Info command
    if (line == 'info' || line.startsWith('info ')) {
      final name = line == 'info' ? null : line.substring(5).trim();
      return info(name);
    }

    // Define commands
    if (line.startsWith('define ')) {
      final parts = line.substring(7).split('=');
      if (parts.length >= 2) {
        define(parts[0].trim(), parts.sublist(1).join('=').trim());
      }
      return null;
    }
    if (line.startsWith('undefine ')) {
      return undefine(line.substring(9).trim());
    }
    if (line == 'defines') {
      return defines();
    }
    if (line.startsWith('.load-defines ')) {
      return loadDefines(line.substring(14).trim());
    }
    if (line.startsWith('@')) {
      return expandDefine(line);
    }

    // File execution commands
    if (line.startsWith('.execute ')) {
      return executeFile(line.substring(9).trim());
    }
    if (line.startsWith('.file ')) {
      return file(line.substring(6).trim());
    }
    if (line.startsWith('.script ')) {
      return script(line.substring(8).trim());
    }
    if (line.startsWith('.load ')) {
      return load(line.substring(6).trim());
    }
    if (line.startsWith('.replay ')) {
      return replay(line.substring(8).trim());
    }
    if (line.startsWith('.session ')) {
      return session(line.substring(9).trim());
    }
    if (line == '.reset' || line.startsWith('.reset ')) {
      final path = line == '.reset' ? null : line.substring(7).trim();
      return reset(replayPath: path);
    }

    // Load file contents
    if (line.startsWith('.print-file ')) {
      return loadFile(line.substring(12).trim());
    }
    if (line.startsWith('.print-script ')) {
      return loadScript(line.substring(14).trim());
    }
    if (line.startsWith('.print-replay ')) {
      return loadReplay(line.substring(14).trim());
    }
    if (line.startsWith('.print-session ')) {
      return loadSession(line.substring(15).trim());
    }

    // Default: evaluate as expression
    return eval(line);
  }

  // ---------------------------------------------------------------------------
  // COMMANDS: General Commands
  // ---------------------------------------------------------------------------

  @override
  String help() {
    // Return help text placeholder - actual implementation deferred
    return 'Help text - use the REPL help command for detailed help.';
  }

  @override
  SymbolInfo? info([String? name]) {
    if (name == null) {
      return SymbolInfo(
        name: toolName,
        kind: SymbolKind.package,
        documentation: 'Use info <name> to get information about a symbol.',
      );
    }

    // Try to find the symbol in configuration
    final config = _d4rt.getConfiguration();
    
    // Check bridged classes from all imports
    for (final imp in config.imports) {
      for (final cls in imp.classes) {
        if (cls.name == name) {
          return SymbolInfo(
            name: name,
            kind: SymbolKind.class_,
            documentation: 'Bridged class: ${cls.name}',
            details: {
              'methods': cls.methods,
              'constructors': cls.constructors,
            },
          );
        }
      }

      // Check bridged enums
      for (final e in imp.enums) {
        if (e.name == name) {
          return SymbolInfo(
            name: name,
            kind: SymbolKind.enum_,
            documentation: 'Bridged enum: ${e.name}',
            details: {'values': e.values},
          );
        }
      }
    }

    return null;
  }

  @override
  List<ClassInfo> classes() {
    // Get classes from all imports in configuration
    final result = <ClassInfo>[];
    for (final imp in _d4rt.getConfiguration().imports) {
      for (final c in imp.classes) {
        result.add(ClassInfo(
          name: c.name,
          methods: c.methods,
          constructors: c.constructors,
        ));
      }
    }
    return result;
  }

  @override
  List<EnumInfo> enums() {
    final result = <EnumInfo>[];
    for (final imp in _d4rt.getConfiguration().imports) {
      for (final e in imp.enums) {
        result.add(EnumInfo(
          name: e.name,
          values: e.values,
        ));
      }
    }
    return result;
  }

  @override
  List<FunctionInfo> methods() {
    return _d4rt.getConfiguration().globalFunctions
        .map((f) => FunctionInfo(
              name: f.name,
              parameterNames: const [],
              arity: 0, // arity not available in GlobalFunctionInfo
            ))
        .toList();
  }

  @override
  List<VariableInfo> variables() {
    final env = _d4rt.getEnvironmentState();
    if (env == null) return [];
    
    return env.variables
        .map((v) => VariableInfo(
              name: v.name,
              valueType: v.valueType,
            ))
        .toList();
  }

  @override
  List<ImportInfo> imports() {
    return _d4rt.getConfiguration().imports
        .map((i) => ImportInfo(
              path: i.importPath,
              classes: i.classes.map((c) => c.name).toList(),
              enums: i.enums.map((e) => e.name).toList(),
              functions: const [], // functions not available per-import
            ))
        .toList();
  }

  @override
  List<ClassInfo> registeredClasses() {
    return classes(); // Same as classes()
  }

  @override
  List<EnumInfo> registeredEnums() {
    return enums(); // Same as enums()
  }

  @override
  List<FunctionInfo> registeredMethods() {
    return methods(); // Same as methods()
  }

  @override
  List<VariableInfo> registeredVariables() {
    return _d4rt.getConfiguration().globalVariables
        .map((v) => VariableInfo(
              name: v.name,
              valueType: v.valueType,
            ))
        .toList();
  }

  @override
  List<ImportInfo> registeredImports() {
    return imports(); // Same as imports()
  }

  @override
  String showInit() {
    // Init source is managed by the REPL, not available here
    return '// Init source not available in controller';
  }

  @override
  void clear() {
    // No-op in headless mode
  }

  // ---------------------------------------------------------------------------
  // DEFINES: Command Aliases
  // ---------------------------------------------------------------------------

  @override
  void define(String name, String template) {
    _state.setDefine(name, template);
  }

  @override
  bool undefine(String name) {
    final hadDefine = _state.getDefine(name) != null;
    _state.removeDefine(name);
    return hadDefine;
  }

  @override
  Map<String, String> defines() {
    return _state.defines;
  }

  @override
  int loadDefines(String path) {
    final resolved = _state.resolvePath(path);
    final file = File(resolved);

    if (!file.existsSync()) {
      return -1;
    }

    var count = 0;
    final lines = file.readAsLinesSync();
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty || trimmed.startsWith('#')) continue;

      final idx = trimmed.indexOf('=');
      if (idx > 0) {
        final name = trimmed.substring(0, idx).trim();
        final template = trimmed.substring(idx + 1).trim();
        define(name, template);
        count++;
      }
    }

    return count;
  }

  @override
  String? invokeDefine(String name, [List<String>? args]) {
    final template = _state.getDefine(name);
    if (template == null) return null;

    var expanded = template;
    final argList = args ?? [];

    // Replace $$ with all args
    expanded = expanded.replaceAll(r'$$', argList.join(' '));

    // Replace $1-$9 with positional args
    for (var i = 1; i <= 9; i++) {
      final arg = i <= argList.length ? argList[i - 1] : '';
      expanded = expanded.replaceAll('\$$i', arg);
    }

    return expanded;
  }

  @override
  String? expandDefine(String input) {
    if (!input.startsWith('@')) return null;

    final parts = input.substring(1).split(RegExp(r'\s+'));
    if (parts.isEmpty) return null;

    final name = parts[0];
    final args = parts.length > 1 ? parts.sublist(1) : <String>[];

    return invokeDefine(name, args);
  }

  // ---------------------------------------------------------------------------
  // DIRECTORY: Navigation and Listing
  // ---------------------------------------------------------------------------

  @override
  List<String> sessions() {
    final sessionDir = Directory('${_state.dataDirectory}/sessions');
    if (!sessionDir.existsSync()) return [];

    return sessionDir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.session.txt'))
        .map((f) => f.uri.pathSegments.last.replaceAll('.session.txt', ''))
        .toList()
      ..sort();
  }

  @override
  List<String> scripts() {
    return _listFilesWithExtension('.script.txt');
  }

  @override
  List<String> plays() {
    return [
      ..._listFilesWithExtension('.replay.txt'),
      ..._listFilesWithExtension('.${toolName.toLowerCase()}'),
    ];
  }

  @override
  List<String> executes() {
    return _listFilesWithExtension('.dart')
        .where((f) => f.endsWith('.exec.dart') || f.endsWith('.d4rt.dart'))
        .toList();
  }

  List<String> _listFilesWithExtension(String ext) {
    final dir = Directory(_state.cwd);
    if (!dir.existsSync()) return [];

    return dir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith(ext))
        .map((f) => f.uri.pathSegments.last)
        .toList()
      ..sort();
  }

  @override
  List<String> ls([String? path]) {
    final targetPath = path != null ? _state.resolvePath(path) : _state.cwd;
    final dir = Directory(targetPath);

    if (!dir.existsSync()) {
      throw DirectoryNotFoundException(targetPath);
    }

    final entries = dir.listSync();
    final result = <String>[];

    for (final entry in entries) {
      // Use path.split to get the name since uri.pathSegments.last
      // returns empty string for directories
      final segments = entry.path.split('/');
      final name = segments.last.isEmpty && segments.length > 1
          ? segments[segments.length - 2]
          : segments.last;
      if (entry is Directory) {
        result.add('$name/');
      } else {
        result.add(name);
      }
    }

    return result..sort();
  }

  @override
  String cd(String path) {
    return _state.cd(path);
  }

  @override
  String cwd() {
    return _state.cwd;
  }

  @override
  String home() {
    return _state.home();
  }

  // ---------------------------------------------------------------------------
  // MULTILINE: Multiline Input Modes
  // ---------------------------------------------------------------------------

  @override
  void startDefine() {
    _state.contextStack.current.startMultilineMode(MultilineMode.define);
  }

  @override
  void startScript() {
    _state.contextStack.current.startMultilineMode(MultilineMode.script);
  }

  @override
  void startFile() {
    _state.contextStack.current.startMultilineMode(MultilineMode.file);
  }

  @override
  void startExecute() {
    _state.contextStack.current.startMultilineMode(MultilineMode.executeNew);
  }

  @override
  Future<dynamic> end() async {
    final context = _state.contextStack.current;
    final code = context.getMultilineCode();
    final mode = context.multilineMode;

    // Clear multiline state
    context.clearMultilineBuffer();

    // Execute based on mode
    switch (mode) {
      case MultilineMode.none:
        throw CliException('.end called without active multiline mode');
      case MultilineMode.define:
        return _d4rt.eval(code);
      case MultilineMode.script:
        return _executeScript(code);
      case MultilineMode.file:
        return executeContinued(code);
      case MultilineMode.executeNew:
        return execute(code);
    }
  }

  Future<dynamic> _executeScript(String code) async {
    // Wrap code in a function to capture return value
    final wrapperCode = '''
dynamic __repl_multiline__() {
$code
}
''';
    _d4rt.eval(wrapperCode);
    final result = _d4rt.eval('__repl_multiline__()');
    if (result is Future) {
      return await result;
    }
    return result;
  }

  @override
  bool get isMultilineMode => _state.isMultilineMode;

  @override
  MultilineMode get multilineMode => _state.multilineMode;

  @override
  List<String> get multilineBuffer => _state.multilineBuffer;

  @override
  void clearMultilineBuffer() {
    _state.clearMultilineBuffer();
  }

  // ---------------------------------------------------------------------------
  // FILES & SESSIONS: File Execution and Session Management
  // ---------------------------------------------------------------------------

  @override
  Future<ExecuteResult> execute(String source, {String? basePath}) async {
    try {
      final result = await _d4rt.execute(source: source);
      return ExecuteResult.success(result);
    } catch (e, st) {
      return ExecuteResult.failure(e.toString(), stackTrace: st);
    }
  }

  @override
  Future<ExecuteResult> executeFile(String path) async {
    final resolved = _state.resolvePath(path);
    final file = File(resolved);

    if (!file.existsSync()) {
      throw CliFileNotFoundException(resolved);
    }

    final source = file.readAsStringSync();
    return execute(source, basePath: file.parent.path);
  }

  @override
  Future<ExecuteResult> executeContinued(String source, {String? basePath}) async {
    try {
      final result = await _d4rt.continuedExecute(source: source);
      return ExecuteResult.success(result);
    } catch (e, st) {
      return ExecuteResult.failure(e.toString(), stackTrace: st);
    }
  }

  @override
  Future<ExecuteResult> file(String path) async {
    final resolved = _state.resolvePath(path);
    final f = File(resolved);

    if (!f.existsSync()) {
      throw CliFileNotFoundException(resolved);
    }

    final source = f.readAsStringSync();
    return executeContinued(source, basePath: f.parent.path);
  }

  @override
  Future<int> script(String path) async {
    final resolved = _state.resolvePath(path);
    final file = File(resolved);

    if (!file.existsSync()) {
      throw CliFileNotFoundException(resolved);
    }

    final lines = file.readAsLinesSync();
    var count = 0;

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty || trimmed.startsWith('#')) continue;

      await _d4rt.eval(line);
      count++;
    }

    return count;
  }

  @override
  Future<int> load(String path) async {
    return _replayFile(path, silent: false);
  }

  @override
  Future<int> replay(String path) async {
    return _replayFile(path, silent: true);
  }

  Future<int> _replayFile(String path, {required bool silent}) async {
    final resolved = _state.resolvePath(path);
    final file = File(resolved);

    if (!file.existsSync()) {
      throw CliFileNotFoundException(resolved);
    }

    // Push new execution context
    _state.contextStack.push(ExecutionContext(
      workingDirectory: file.parent.path,
      sourceFile: resolved,
      recordToSession: false,
      silent: silent,
    ));

    try {
      final lines = file.readAsLinesSync();
      var count = 0;

      for (var i = 0; i < lines.length; i++) {
        try {
          await processPrompt(lines[i]);
          count++;
        } catch (e) {
          throw ReplayException(resolved, i + 1, 
            e is CliException ? e : CliException(e.toString()));
        }
      }

      return count;
    } finally {
      // Pop context
      _state.contextStack.pop();
    }
  }

  @override
  Future<void> session(String sessionId) async {
    final isNew = _state.startSession(sessionId);

    if (!isNew) {
      // Replay existing session
      final sessionPath = _state.getSessionPath(sessionId);
      if (File(sessionPath).existsSync()) {
        await replay(sessionPath);
      }
    }
  }

  @override
  Future<void> reset({String? replayPath}) async {
    // Reset is not directly supported by D4rt - would need to recreate instance
    // For now, just replay if a path is provided
    if (replayPath != null) {
      await replay(replayPath);
    }
  }

  @override
  void closeSession() {
    _state.closeSession();
  }

  // ---------------------------------------------------------------------------
  // LOAD FILE CONTENTS
  // ---------------------------------------------------------------------------

  @override
  String loadFile(String path) {
    return _loadFileContents(path, '.exec.dart');
  }

  @override
  String loadScript(String path) {
    return _loadFileContents(path, '.script.txt');
  }

  @override
  String loadReplay(String path) {
    return _loadFileContents(path, '.replay.txt');
  }

  @override
  String loadSession(String sessionId) {
    final sessionPath = _state.getSessionPath(sessionId);
    return _loadFileContents(sessionPath, '');
  }

  String _loadFileContents(String path, String defaultExt) {
    var resolved = _state.resolvePath(path);
    
    // Add default extension if needed
    if (defaultExt.isNotEmpty && !resolved.contains('.')) {
      resolved = '$resolved$defaultExt';
    }

    final file = File(resolved);
    if (!file.existsSync()) {
      throw CliFileNotFoundException(resolved);
    }

    return file.readAsStringSync();
  }

  // ---------------------------------------------------------------------------
  // EXPRESSION EVALUATION
  // ---------------------------------------------------------------------------

  @override
  Future<dynamic> eval(String expression) async {
    // Record to session if active
    _state.recordToSession(expression);

    // Handle await expressions
    final result = _d4rt.eval(expression);
    if (result is Future) {
      return await result;
    }
    return result;
  }
}

// =============================================================================
// CliGlobalHolder
// =============================================================================

/// Holder for the cli global variable.
///
/// This enables two-phase initialization:
/// 1. Registration: Creates the holder during bridge registration
/// 2. Initialization: Sets the controller when REPL is ready
class CliGlobalHolder {
  D4rtCliController? _controller;

  /// Gets the controller, throwing if not initialized.
  D4rtCliController get controller {
    if (_controller == null) {
      throw CliNotInitializedException();
    }
    return _controller!;
  }

  /// Initializes the holder with a controller.
  void initialize(D4rtCliController controller) {
    _controller = controller;
  }

  /// Whether the holder has been initialized.
  bool get isInitialized => _controller != null;

  /// Resets the holder (for testing).
  void reset() {
    _controller = null;
  }
}
