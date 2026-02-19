/// Shared test helpers for tom_d4rt_exec tests.
///
/// Provides the [parseSource] callback that bridges the analyzer
/// (via tom_d4rt_astgen) to the D4rt interpreter's [parseSourceCallback].
import 'package:analyzer/dart/analysis/utilities.dart' as analyzer;
import 'package:tom_d4rt_ast/ast.dart';
import 'package:tom_d4rt_astgen/tom_d4rt_astgen.dart';

/// Parse Dart source code into an [SCompilationUnit] using the analyzer
/// and [AstConverter].
///
/// This is the standard [parseSourceCallback] for D4rt in test environments.
SCompilationUnit parseSource(String sourceCode, {String? path}) {
  final result = analyzer.parseString(
    content: sourceCode,
    path: path,
  );
  return AstConverter().convertCompilationUnit(result.unit);
}
