/// D4rtgen invocation logging for debugging test runs.
///
/// Logs all d4rtgen invocations (CLI and API) to a fixed file.
library;

import 'dart:io';

/// Fixed log file path in workspace root.
const String _logFilePath = '/Users/alexiskyaw/Desktop/Code/tom2/d4rtgen_invocations.log';

/// Logs a d4rtgen invocation.
///
/// [source] - Either 'CLI' or 'API'
/// [details] - Additional context about the invocation
/// [stackTrace] - Optionally include call stack for debugging
void logD4rtgenInvocation({
  required String source,
  required String details,
  bool includeStackTrace = false,
}) {
  try {
    final timestamp = DateTime.now().toIso8601String();
    final buffer = StringBuffer();
    buffer.writeln('='.padRight(80, '='));
    buffer.writeln('[$timestamp] D4RTGEN INVOCATION: $source');
    buffer.writeln('Details: $details');
    
    if (includeStackTrace) {
      buffer.writeln('Stack trace:');
      final trace = StackTrace.current.toString();
      // Only include first 15 lines of stack trace
      final lines = trace.split('\n').take(15);
      for (final line in lines) {
        buffer.writeln('  $line');
      }
    }
    
    buffer.writeln();
    
    final file = File(_logFilePath);
    file.writeAsStringSync(buffer.toString(), mode: FileMode.append);
  } catch (e) {
    // Silently ignore logging errors to not break the tool
    stderr.writeln('Warning: Failed to log d4rtgen invocation: $e');
  }
}

/// Clears the d4rtgen invocation log.
void clearD4rtgenLog() {
  try {
    final file = File(_logFilePath);
    if (file.existsSync()) {
      file.deleteSync();
    }
  } catch (e) {
    stderr.writeln('Warning: Failed to clear d4rtgen log: $e');
  }
}

/// Returns summary of d4rtgen invocations from the log.
String getD4rtgenLogSummary() {
  try {
    final file = File(_logFilePath);
    if (!file.existsSync()) {
      return 'No d4rtgen invocations logged.';
    }
    
    final content = file.readAsStringSync();
    final cliCount = RegExp(r'D4RTGEN INVOCATION: CLI').allMatches(content).length;
    final apiCount = RegExp(r'D4RTGEN INVOCATION: API').allMatches(content).length;
    
    return '''
D4rtgen Invocation Summary:
  CLI invocations: $cliCount
  API invocations: $apiCount
  Total: ${cliCount + apiCount}
''';
  } catch (e) {
    return 'Failed to read d4rtgen log: $e';
  }
}
