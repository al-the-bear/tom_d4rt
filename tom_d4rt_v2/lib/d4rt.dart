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

export 'package:tom_d4rt_v2/src/bridge/bridged_types.dart';
export 'package:tom_d4rt_v2/src/runtime_types.dart';
export 'package:tom_d4rt_v2/src/callable.dart';
export 'package:tom_d4rt_v2/src/declaration_visitor.dart';
export 'package:tom_d4rt_v2/src/environment.dart';
export 'package:tom_d4rt_v2/src/exceptions.dart';
export 'package:tom_d4rt_v2/src/interpreter_visitor.dart';
export 'package:tom_d4rt_v2/src/late_variable.dart';
export 'package:tom_d4rt_v2/src/scope_frame.dart';
export 'package:tom_d4rt_v2/src/stdlib/stdlib.dart';
export 'src/d4rt_base.dart';
export 'src/bridge/registration.dart' hide BridgedMethodCallable;
export 'src/utils/extensions/map.dart';
export 'src/utils/extensions/list.dart';
export 'src/utils/extensions/visitor.dart';
export 'src/utils/extensions/iterable.dart';
export 'src/runtime_interfaces.dart';
export 'package:tom_d4rt_v2/src/async_state.dart';
export 'package:tom_d4rt_v2/src/utils/logger/logger.dart';
export 'package:tom_d4rt_v2/src/security/permissions.dart';
export 'package:tom_d4rt_v2/src/introspection.dart';
export 'package:tom_d4rt_v2/src/generator/d4.dart';
export 'package:tom_d4rt_v2/src/generator/d4rt_user_bridge_annotation.dart';
export 'package:tom_d4rt_v2/src/generator/d4rt_user_proxy_annotation.dart';
export 'package:tom_d4rt_v2/src/bridge/library_mapping.dart';
export 'package:tom_d4rt_v2/src/script_execution.dart';
