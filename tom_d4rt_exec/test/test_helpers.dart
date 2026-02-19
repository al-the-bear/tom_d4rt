/// Shared test helpers for tom_d4rt_exec tests.
///
/// Provides the [parseSource] callback that bridges the analyzer
/// (via tom_d4rt_astgen) to the D4rt interpreter's [parseSourceCallback].
import 'package:analyzer/dart/analysis/utilities.dart' as analyzer;
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:tom_d4rt_astgen/tom_d4rt_astgen.dart';

/// Parse Dart source code into an [SCompilationUnit] using the analyzer
/// and [AstConverter].
///
/// This is the standard [parseSourceCallback] for D4rt in test environments.
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
