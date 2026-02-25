/// Result of running a D4rt script or eval test via [D4rtTester].
///
/// Contains information about the test execution including whether it
/// timed out, any exceptions thrown, and the captured process output.
///
/// The test runner outputs structured JSON that is parsed by
/// [D4rtTestResult.fromTestProcess]. If structured output is not found
/// (e.g., the process crashed), raw stdout/stderr are captured instead.
library;

import 'dart:convert';

/// Result of running a D4rt script or eval test via [D4rtTester].
///
/// Contains information about the test execution including
/// whether it timed out, any exceptions thrown, and the process output.
class D4rtTestResult {
  /// Whether the test timed out before completing.
  final bool timedOut;

  /// Exceptions thrown during test execution.
  ///
  /// Each entry contains the exception message and optionally the stack trace.
  /// Captured via `runZonedGuarded` in the test runner process.
  final List<String> exceptions;

  /// Captured stdout output from the D4rt script execution.
  ///
  /// Contains all `print()` calls made by the script, captured via
  /// `ZoneSpecification` in the test runner.
  final String processOutput;

  /// Stderr output from the test runner process.
  final String processError;

  /// Exit code of the test process (-1 if timed out / killed).
  final int exitCode;

  const D4rtTestResult({
    required this.timedOut,
    this.exceptions = const [],
    this.processOutput = '',
    this.processError = '',
    this.exitCode = 0,
  });

  /// Whether the test passed successfully (no timeout, no exceptions, exit 0).
  bool get success => !timedOut && exceptions.isEmpty && exitCode == 0;

  /// Parse a [D4rtTestResult] from the process output of a test runner.
  ///
  /// The test runner's `--test` mode outputs a JSON line prefixed with
  /// `###D4RT_TEST_RESULT###`. This factory parses that structured output.
  /// If no structured marker is found, raw stdout/stderr are used instead.
  factory D4rtTestResult.fromTestProcess({
    required int exitCode,
    required String stdout,
    required String stderr,
    bool timedOut = false,
  }) {
    // Try to parse structured JSON output from --test mode.
    // The test runner outputs a JSON line starting with the marker.
    const marker = '###D4RT_TEST_RESULT###';
    final markerIndex = stdout.indexOf(marker);

    if (markerIndex >= 0) {
      final jsonStr = stdout.substring(markerIndex + marker.length).trim();
      try {
        final json = jsonDecode(jsonStr) as Map<String, dynamic>;
        final capturedOutput = json['output'] as String? ?? '';
        final capturedExceptions = (json['exceptions'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [];

        return D4rtTestResult(
          timedOut: timedOut,
          exceptions: capturedExceptions,
          processOutput: capturedOutput,
          processError: stderr,
          exitCode: timedOut ? -1 : exitCode,
        );
      } catch (_) {
        // Fall through to raw output parsing
      }
    }

    // No structured output — treat stdout/stderr as raw output.
    return D4rtTestResult(
      timedOut: timedOut,
      exceptions: exitCode != 0 && !timedOut
          ? [stderr.isNotEmpty ? stderr : 'Process exited with code $exitCode']
          : [],
      processOutput: stdout,
      processError: stderr,
      exitCode: timedOut ? -1 : exitCode,
    );
  }

  @override
  String toString() {
    final buf = StringBuffer('D4rtTestResult(\n');
    buf.writeln('  success: $success');
    buf.writeln('  timedOut: $timedOut');
    buf.writeln('  exitCode: $exitCode');
    if (exceptions.isNotEmpty) {
      buf.writeln('  exceptions: [');
      for (final e in exceptions) {
        buf.writeln('    $e');
      }
      buf.writeln('  ]');
    }
    if (processOutput.isNotEmpty) {
      buf.writeln(
        '  processOutput: ${processOutput.length > 200 ? '${processOutput.substring(0, 200)}...' : processOutput}',
      );
    }
    if (processError.isNotEmpty) {
      buf.writeln(
        '  processError: ${processError.length > 200 ? '${processError.substring(0, 200)}...' : processError}',
      );
    }
    buf.writeln(')');
    return buf.toString();
  }
}
