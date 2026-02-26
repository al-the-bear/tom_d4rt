/// Tom D4rt Exec - Analyzer-free D4rt interpreter.
///
/// This package is the migration target for the D4rt split. It will run
/// entirely on the mirror AST from `tom_d4rt_ast`, eliminating the
/// `analyzer` dependency. This enables use in Flutter apps for on-the-fly
/// UI updates without app store republishing.
///
/// During migration, this starts as a copy of `tom_d4rt` v1.8.1.
/// The interpreter infrastructure will be moved to `tom_d4rt_ast` and
/// this package will become the CLI entry point using `tom_ast_generator`.
///
/// See [d4rt.dart] for the full API documentation.
library;

export 'd4rt.dart';
