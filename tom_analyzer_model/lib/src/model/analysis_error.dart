part of 'model.dart';

/// Severity levels for analysis diagnostics.
enum AnalysisErrorSeverity { info, warning, error }

/// Represents a diagnostic produced during analysis.
class AnalysisError {
  final String message;
  final AnalysisErrorSeverity severity;
  final SourceLocation? location;
  final String? code;

  const AnalysisError({
    required this.message,
    required this.severity,
    this.location,
    this.code,
  });
}
