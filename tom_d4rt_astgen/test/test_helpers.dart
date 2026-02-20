/// Shared test helpers for tom_d4rt_astgen generator tests.
///
/// Provides the [parseSource] callback that performs a full AST round-trip:
/// source → analyzer → AstConverter → toJson → fromJson → SCompilationUnit.
///
/// This tests that the serialization/deserialization preserves enough
/// information for the D4rt interpreter to execute correctly.
import 'dart:convert';

import 'package:analyzer/dart/analysis/utilities.dart' as analyzer;
import 'package:analyzer/error/error.dart' show ErrorSeverity;
import 'package:tom_d4rt_astgen/tom_d4rt_astgen.dart';

/// Parse Dart source code into an [SCompilationUnit] via full AST round-trip.
///
/// Pipeline: source → analyzer parse → AstConverter → toJson → fromJson
///
/// This is the [parseSourceCallback] for astgen tests. The round-trip through
/// JSON serialization/deserialization validates that the serializable AST
/// model faithfully preserves the information needed for interpretation.
SCompilationUnit parseSource(String sourceCode, {String? path}) {
  final result = analyzer.parseString(
    content: sourceCode,
    path: path,
    throwIfDiagnostics: false,
  );
  final converter = AstConverter();
  final cu = converter.convertCompilationUnit(result.unit);

  // Check for parse errors
  final hasErrors = result.errors
      .any((e) => e.errorCode.errorSeverity == ErrorSeverity.ERROR);

  // Perform the round-trip: toJson → fromJson
  final json = cu.toJson();
  final jsonString = jsonEncode(json);
  final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
  final roundTripped = SCompilationUnit.fromJson(decoded);

  if (hasErrors) {
    return SCompilationUnit(
      offset: roundTripped.offset,
      length: roundTripped.length,
      scriptTag: roundTripped.scriptTag,
      directives: roundTripped.directives,
      declarations: roundTripped.declarations,
      comments: roundTripped.comments,
      hasParseErrors: true,
    );
  }
  return roundTripped;
}
