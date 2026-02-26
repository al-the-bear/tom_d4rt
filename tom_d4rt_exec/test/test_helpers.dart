/// Shared test helpers for tom_d4rt_exec tests.
///
/// Provides the [parseSource] callback for direct AST testing scenarios.
/// Note: D4rt now handles parsing internally, so tests using D4rt() don't
/// need this callback.
import 'package:analyzer/dart/analysis/utilities.dart' as analyzer;
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:tom_ast_generator/tom_ast_generator.dart';

/// Parse Dart source code into an [SCompilationUnit] using the analyzer
/// and [AstConverter].
///
/// Useful for direct AST testing or when you need access to the parsed AST
/// outside of D4rt.
SCompilationUnit parseSource(String sourceCode, {String? path}) {
  final result = analyzer.parseString(
    content: sourceCode,
    path: path,
    throwIfDiagnostics: false,
  );
  final cu = AstConverter().convertCompilationUnit(result.unit);
  // Check for parse errors (not warnings/hints) so that eval() can distinguish
  // valid declarations from error-recovery artifacts.
  final hasErrors = result.errors
      .any((e) => e.errorCode.errorSeverity == ErrorSeverity.ERROR);
  if (hasErrors) {
    return SCompilationUnit(
      offset: cu.offset,
      length: cu.length,
      scriptTag: cu.scriptTag,
      directives: cu.directives,
      declarations: cu.declarations,
      comments: cu.comments,
      hasParseErrors: true,
    );
  }
  return cu;
}
