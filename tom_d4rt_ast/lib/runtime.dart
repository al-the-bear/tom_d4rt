/// D4rt Runtime - Interpreter and execution environment
///
/// This library provides the runtime components for D4rt:
/// - Interpreter visitor for executing SAstNode trees
/// - Environment for variable scope management
/// - Bridge infrastructure for native-interpreted interop
/// - Standard library implementations
///
/// This library has NO dependency on the analyzer package.
/// It can execute pre-parsed SAstNode trees from JSON or any source.
///
/// For parsing source code to SAstNode, use the tom_d4rt_exec package
/// which provides the full D4rt API with parser integration.
library;

// AST model (re-export from ast.dart)
export 'package:tom_d4rt_ast/ast.dart';

// Core exceptions
export 'src/runtime/exceptions.dart';

// Environment and variable management
export 'src/runtime/environment.dart';
export 'src/runtime/late_variable.dart';

// Runtime types and interfaces
export 'src/runtime/runtime_interfaces.dart';
export 'src/runtime/runtime_types.dart';

// Function calling infrastructure
export 'src/runtime/callable.dart';

// Interpreter visitors
export 'src/runtime/declaration_visitor.dart';
export 'src/runtime/interpreter_visitor.dart';

// Async execution support
export 'src/runtime/async_state.dart';

// Bridge types and registration
export 'src/runtime/bridge/bridged_types.dart';
export 'src/runtime/bridge/bridged_enum.dart';
export 'src/runtime/bridge/registration.dart' hide BridgedMethodCallable;

// Security permissions
export 'src/runtime/security/permissions.dart';

// Module context abstraction
export 'src/runtime/module_context.dart';

// Module loader for AST bundles
export 'src/runtime/ast_module_loader.dart';

// Main runner API
export 'src/runtime/d4rt_runner.dart';

// Bundle format
export 'src/runtime/ast_bundle.dart';

// Introspection
export 'src/runtime/introspection.dart';

// Generator helpers
export 'src/runtime/generator/d4.dart';
export 'src/runtime/generator/d4rt_user_bridge_annotation.dart';

// Utility extensions
export 'src/runtime/utils/extensions/map.dart';
export 'src/runtime/utils/extensions/list.dart';
export 'src/runtime/utils/extensions/visitor.dart';
export 'src/runtime/utils/extensions/iterable.dart';

// Logger
export 'src/runtime/utils/logger/logger.dart';

// Standard library
export 'src/runtime/stdlib/stdlib.dart';
