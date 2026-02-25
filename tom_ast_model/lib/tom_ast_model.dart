/// Serializable AST model for Dart source code.
///
/// This package provides a complete, self-contained AST representation
/// with JSON serialization. It has no dependency on the Dart analyzer
/// package or any interpreter runtime.
///
/// ## Usage
///
/// ```dart
/// import 'package:tom_ast_model/tom_ast_model.dart';
///
/// // Deserialize an AST from JSON
/// final unit = SCompilationUnit.fromJson(jsonMap);
///
/// // Serialize back to JSON
/// final json = unit.toJson();
///
/// // Visitor pattern
/// final visitor = MyVisitor();
/// unit.accept(visitor);
/// ```
library;

export 'ast.dart';
