/// Serializable AST model that mirrors the Dart analyzer's AST.
///
/// This module provides AST node classes that:
/// 1. Mirror the structure of `package:analyzer/dart/ast/ast.dart`
/// 2. Can be serialized to/from JSON or binary format
/// 3. Can be interpreted without the analyzer dependency
///
/// ## Usage
///
/// **Build time (with analyzer):**
/// ```dart
/// import 'package:analyzer/dart/analysis/utilities.dart';
/// import 'package:tom_analyzer/ast.dart';
///
/// final parseResult = parseString(content: sourceCode);
/// final serializableAst = AstConverter.convert(parseResult.unit);
/// final json = serializableAst.toJson();
/// ```
///
/// **Runtime (without analyzer):**
/// ```dart
/// import 'package:tom_analyzer/ast.dart';
///
/// final ast = SCompilationUnit.fromJson(json);
/// final result = ast.accept(MyInterpreterVisitor());
/// ```
library;

export 'nodes/node.dart';
export 'nodes/compilation_unit.dart';
export 'nodes/declarations.dart';
export 'nodes/expressions.dart';
export 'nodes/statements.dart';
export 'nodes/literals.dart';
export 'nodes/patterns.dart';
export 'nodes/types.dart';
export 'nodes/directives.dart';
export 'nodes/function_body.dart';
export 'nodes/parameters.dart';
export 'nodes/members.dart';
export 'token.dart';
export 'visitor.dart';
export 'converter.dart';
export 'serialization.dart';
