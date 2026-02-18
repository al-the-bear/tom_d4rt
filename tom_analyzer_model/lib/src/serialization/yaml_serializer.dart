import '../model/model.dart';
import 'json_serializer.dart';

/// Serializes analysis results to a YAML representation.
class YamlSerializer {
  static String encode(AnalysisResult result) {
    final map = JsonSerializer.toMap(result);
    return _YamlEmitter().emit(map);
  }
}

class _YamlEmitter {
  String emit(Object? value, {int indent = 0}) {
    if (value == null) {
      return 'null';
    }
    if (value is Map) {
      return _emitMap(value.cast<String, Object?>(), indent);
    }
    if (value is List) {
      return _emitList(value, indent);
    }
    if (value is String) {
      return _escapeString(value, indent);
    }
    if (value is num || value is bool) {
      return value.toString();
    }
    return _escapeString(value.toString(), indent);
  }

  String _emitMap(Map<String, Object?> map, int indent) {
    final buffer = StringBuffer();
    final pad = ' ' * indent;
    for (final entry in map.entries) {
      final key = entry.key;
      final value = entry.value;
      if (value is Map || value is List) {
        buffer.writeln('$pad$key:');
        buffer.writeln(emit(value, indent: indent + 2));
      } else if (value is String && value.contains('\n')) {
        // Multiline strings need special handling
        buffer.write('$pad$key: ');
        buffer.writeln(_escapeString(value, indent + 2));
      } else {
        buffer.writeln('$pad$key: ${emit(value, indent: indent)}');
      }
    }
    return buffer.toString().trimRight();
  }

  String _emitList(List values, int indent) {
    final buffer = StringBuffer();
    final pad = ' ' * indent;
    for (final value in values) {
      if (value is Map || value is List) {
        buffer.writeln('$pad-');
        buffer.writeln(emit(value, indent: indent + 2));
      } else {
        buffer.writeln('$pad- ${emit(value, indent: indent)}');
      }
    }
    return buffer.toString().trimRight();
  }

  String _escapeString(String value, [int indent = 0]) {
    // Empty strings need quoting
    if (value.isEmpty) return '""';

    // For multiline strings, use literal block scalar
    if (value.contains('\n')) {
      final lines = value.split('\n');
      final pad = ' ' * indent;
      final buffer = StringBuffer('|\n');
      for (final line in lines) {
        buffer.writeln('$pad$line');
      }
      return buffer.toString().trimRight();
    }

    // Check for YAML special characters and patterns that need quoting
    final needsQuoting = value.contains(':') ||
        value.contains('#') ||
        value.contains('"') ||
        value.contains("'") ||
        value.contains('\\') ||
        value.contains('>') ||
        value.contains('|') ||
        value.contains('&') ||
        value.contains('*') ||
        value.contains('!') ||
        value.contains('%') ||
        value.contains('@') ||
        value.contains('`') ||
        value.contains('[') ||
        value.contains(']') ||
        value.contains('{') ||
        value.contains('}') ||
        value.contains(',') ||
        value.startsWith('-') ||
        value.startsWith('?') ||
        value.startsWith(' ') ||
        value.endsWith(' ') ||
        value == 'null' ||
        value == 'true' ||
        value == 'false' ||
        value == '~' ||
        // Numbers that might be misinterpreted
        RegExp(r'^[\d.eE+-]+$').hasMatch(value);

    if (needsQuoting) {
      // Escape backslashes first, then quotes
      final escaped = value.replaceAll('\\', '\\\\').replaceAll('"', '\\"');
      return '"$escaped"';
    }
    return value;
  }
}
