/// Serializable AST model for D4rt
///
/// This library re-exports the AST model from `package:tom_ast_model`.
///
/// This library has NO dependency on the analyzer package.
///
/// To BUILD one of these trees from Dart source you need the analyzer, which
/// lives outside this package: `package:tom_ast_generator` walks the analyzer
/// AST and constructs the mirror node-for-node, and `package:tom_d4rt_exec`
/// wraps that into a parse-and-run front end. There is no `ast_converter.dart`
/// in this package — an earlier version of this line pointed at one.
library;

export 'package:tom_ast_model/ast.dart';
