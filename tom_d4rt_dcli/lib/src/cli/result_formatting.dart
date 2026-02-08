/// Result formatting utilities for D4rt REPL
///
/// Provides special formatting for Maps, Lists, and other result types.
library;

import 'package:console_markdown/console_markdown.dart';

/// Formats a result for display in the REPL.
/// 
/// Provides special formatting for:
/// - Copilot Chat responses (Maps with 'generatedMarkdown' key)
/// - Other Maps and Lists with indented JSON-like formatting
/// - Regular values with toString()
String formatResult(dynamic result) {
  if (result == null) return 'null';
  
  // Special handling for Copilot Chat responses
  if (result is Map) {
    if (result.containsKey('generatedMarkdown')) {
      final buffer = StringBuffer();
      buffer.writeln();
      buffer.writeln('<cyan>─</cyan>'* 60);
      buffer.writeln('📝 **Copilot Response:**');
      buffer.writeln('<cyan>─</cyan>' * 60);
      // Apply markdown formatting to the response
      buffer.writeln(result['generatedMarkdown'].toString());
      if (result['comments'] != null && result['comments'].toString().isNotEmpty) {
        buffer.writeln();
        buffer.writeln('💬 *Comments:* ${result['comments']}');
      }
      buffer.write('<cyan>─</cyan>' * 60);
      return buffer.toString();
    }
    
    // Format other Maps nicely
    if (result.isEmpty) return '{}';
    final buffer = StringBuffer('{');
    var first = true;
    for (final entry in result.entries) {
      if (!first) buffer.write(',');
      buffer.writeln();
      buffer.write('  ${entry.key}: ${_formatValue(entry.value)}');
      first = false;
    }
    buffer.writeln();
    buffer.write('}');
    return buffer.toString();
  }
  
  // Format Lists nicely
  if (result is List) {
    if (result.isEmpty) return '[]';
    if (result.length <= 5 && result.every((e) => e is! Map && e is! List)) {
      // Short list of simple values - keep on one line
      return '[${result.map(_formatValue).join(', ')}]';
    }
    final buffer = StringBuffer('[');
    for (var i = 0; i < result.length; i++) {
      buffer.writeln();
      buffer.write('  [$i] ${_formatValue(result[i])}');
    }
    buffer.writeln();
    buffer.write(']');
    return buffer.toString();
  }
  
  return result.toString();
}

/// Formats a single value for use within containers.
String _formatValue(dynamic value) {
  if (value is String) {
    // Truncate long strings
    if (value.length > 100) {
      return '"${value.substring(0, 97)}..."';
    }
    return '"$value"';
  }
  if (value is Map || value is List) {
    return value.runtimeType.toString();
  }
  return value.toString();
}

/// Prints a formatted result to stdout.
void printResult(dynamic result) {
  print(formatResult(result));
}
