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

export 'package:tom_d4rt/src/bridge/bridged_types.dart';
export 'package:tom_d4rt/src/runtime_types.dart';
export 'package:tom_d4rt/src/callable.dart';
export 'package:tom_d4rt/src/declaration_visitor.dart';
export 'package:tom_d4rt/src/environment.dart';
export 'package:tom_d4rt/src/exceptions.dart';
export 'package:tom_d4rt/src/interpreter_visitor.dart';
export 'package:tom_d4rt/src/late_variable.dart';
export 'package:tom_d4rt/src/scope_frame.dart';
export 'package:tom_d4rt/src/stdlib/stdlib.dart';
export 'src/d4rt_base.dart';
export 'src/profiler.dart';
export 'src/bridge/registration.dart' hide BridgedMethodCallable;
export 'src/utils/extensions/map.dart';
export 'src/utils/extensions/list.dart';
export 'src/utils/extensions/visitor.dart';
export 'src/utils/extensions/iterable.dart';
export 'src/runtime_interfaces.dart';
export 'package:tom_d4rt/src/async_state.dart';
export 'package:tom_d4rt/src/utils/logger/logger.dart';
export 'package:tom_d4rt/src/security/permissions.dart';
export 'package:tom_d4rt/src/introspection.dart';
export 'package:tom_d4rt/src/generator/d4.dart';
export 'package:tom_d4rt/src/generator/d4rt_user_bridge_annotation.dart';
export 'package:tom_d4rt/src/generator/d4rt_user_proxy_annotation.dart';
export 'package:tom_d4rt/src/bridge/library_mapping.dart';
export 'package:tom_d4rt/src/script_execution.dart';

// SCD134 — three files the barrel never exported, each holding a type this
// package's own public API already hands back. A type that a consumer receives
// but cannot NAME is not a private type; it is a public type with a missing
// export, and the twin (`tom_d4rt_ast/runtime.dart`) exports all three
// equivalents. `tom_d4rt/test/scd134_barrel_surface_parity_test.dart` is what
// keeps the two surfaces comparable from here on.
//
//   * `BridgedEnum` / `BridgedEnumValue` — what `BridgedEnumDefinition
//     .buildBridgedEnum()` returns and what `Environment.getRuntimeType` hands
//     back for an enum value. Consumers were reaching them through
//     `package:tom_d4rt/src/...`, which is an implementation import.
//   * `D4rtTypeError` / `D4rtNoSuchMethodError` / `indexRangeError` — the SDK
//     error types the interpreter raises itself (SCB10), so `on TypeError` in
//     interpreted code matches. A host that wants to catch one needs the name.
//   * `ModuleLoader` / `LoadedModule` — `InterpreterVisitor.moduleLoader` is a
//     public field of type `ModuleLoader`. The AST twin exports its
//     counterpart (`ModuleContext`); this side did not.
export 'package:tom_d4rt/src/bridge/bridged_enum.dart';
export 'package:tom_d4rt/src/sdk_errors.dart';
export 'package:tom_d4rt/src/module_loader.dart';
