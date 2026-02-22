/// D4rt - A powerful Dart code interpreter and runtime environment.
///
/// D4rt provides a complete Dart interpreter that can execute Dart code at runtime,
/// with support for bridging between interpreted and native Dart code, async/await,
/// classes, inheritance, enums, and more.
///
/// ## Key Features:
/// - Full Dart syntax support including classes, methods, functions
/// - Async/await execution with proper state management
/// - Bridged types for seamless native-interpreted code integration
/// - Standard library implementation
/// - Module system with import/export support
/// - Extension methods and mixins
///
/// ## Basic Usage:
/// ```dart
/// final interpreter = D4rt();
/// final result = await interpreter.execute('''
///   int add(int a, int b) => a + b;
///
///   void main() {
///     print(add(5, 3));
///   }
/// ''');
/// ```
library;

// Re-export all runtime components from tom_d4rt_ast
export 'package:tom_d4rt_ast/ast.dart';
export 'package:tom_d4rt_ast/runtime.dart' hide LoadedModule;

// tom_d4rt_exec specific exports
export 'src/d4rt_base.dart';
export 'src/module_loader.dart' show ModuleLoader, LoadedModule;
export 'src/script_execution.dart';
