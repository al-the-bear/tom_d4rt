/// Result Types for D4rt CLI API
///
/// This file contains result/info types specific to the CLI API.
/// For introspection types (ClassInfo, EnumInfo, VariableInfo, etc.),
/// use the types from `package:tom_d4rt_exec/tom_d4rt_exec.dart`.
library;

/// Result of code execution.
class ExecuteResult {
  /// Whether execution succeeded.
  final bool success;

  /// The result value, if any.
  final dynamic result;

  /// Error message, if execution failed.
  final String? error;

  /// Stack trace, if execution failed.
  final StackTrace? stackTrace;

  /// Number of source files loaded.
  final int sourcesLoaded;

  /// Creates an execution result.
  const ExecuteResult({
    required this.success,
    this.result,
    this.error,
    this.stackTrace,
    this.sourcesLoaded = 1,
  });

  /// Creates a successful result.
  const ExecuteResult.success(this.result)
      : success = true,
        error = null,
        stackTrace = null,
        sourcesLoaded = 1;

  /// Creates a failed result.
  ExecuteResult.failure(this.error, {this.stackTrace})
      : success = false,
        result = null,
        sourcesLoaded = 0;
}

/// Information about an import.
class ImportInfo {
  /// The import path.
  final String path;

  /// Class names exported by this import.
  final List<String> classes;

  /// Enum names exported by this import.
  final List<String> enums;

  /// Function names exported by this import.
  final List<String> functions;

  /// Variable names exported by this import.
  final List<String> variables;

  /// Creates import info.
  const ImportInfo({
    required this.path,
    this.classes = const [],
    this.enums = const [],
    this.functions = const [],
    this.variables = const [],
  });

  @override
  String toString() => path;
}

/// Detailed symbol information.
class SymbolInfo {
  /// The symbol name.
  final String name;

  /// The kind of symbol.
  final SymbolKind kind;

  /// Documentation for the symbol.
  final String? documentation;

  /// Additional details about the symbol.
  final Map<String, dynamic> details;

  /// Creates symbol info.
  const SymbolInfo({
    required this.name,
    required this.kind,
    this.documentation,
    this.details = const {},
  });

  @override
  String toString() => '$kind: $name';
}

/// Kind of symbol.
enum SymbolKind {
  /// A class.
  class_,

  /// An enum.
  enum_,

  /// A method or function.
  method,

  /// A variable.
  variable,

  /// An import.
  import_,

  /// A package.
  package,
}
