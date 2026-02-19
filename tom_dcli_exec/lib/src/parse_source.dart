/// Provides the [parseSource] callback for the dcli_exec tool.
///
/// This bridges the analyzer (via tom_d4rt_astgen) to the D4rt interpreter's
/// [parseSourceCallback], enabling source code parsing without the interpreter
/// depending directly on the analyzer package.
library;

import 'package:analyzer/dart/analysis/utilities.dart' as analyzer;
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:tom_d4rt_astgen/tom_d4rt_astgen.dart';

/// Parse Dart source code into an [SCompilationUnit] using the analyzer
/// and [AstConverter].
///
/// This is the standard [parseSourceCallback] for D4rt in CLI environments.
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
      .any((e) => e.diagnosticCode.severity == DiagnosticSeverity.ERROR);
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
