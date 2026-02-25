import 'io.dart' if (dart.library.html) 'web.dart';

enum D4LogLevel { debug, info, warning, error }

class Logger {
  static bool debugEnabled = false;
  static D4LogLevel minLevel = D4LogLevel.debug;

  static final Map<D4LogLevel, String> _levelLabels = {
    D4LogLevel.debug: 'DEBUG',
    D4LogLevel.info: 'INFO',
    D4LogLevel.warning: 'WARN',
    D4LogLevel.error: 'ERROR',
  };

  static final Map<D4LogLevel, String> _levelColors = {
    D4LogLevel.debug: '\x1B[36m', // Cyan
    D4LogLevel.info: '\x1B[32m', // Green
    D4LogLevel.warning: '\x1B[33m', // Yellow
    D4LogLevel.error: '\x1B[31m', // Red
  };

  static final String _resetColor = '\x1B[0m';

  static void log(String message,
      {D4LogLevel level = D4LogLevel.info, Object? error, StackTrace? stackTrace}) {
    if (!_shouldLog(level)) return;
    final now = DateTime.now();
    final timestamp = now
        .toIso8601String()
        .replaceFirst('T', ' ')
        .substring(0, 23); // yyyy-MM-dd HH:mm:ss.SSS
    final label = _levelLabels[level] ?? 'LOG';
    final color = _levelColors[level] ?? '';
    final output = StringBuffer();
    output.write('$color[$timestamp][$label] $message$_resetColor');
    if (error != null) {
      output.write(' | Error: $error');
    }
    if (stackTrace != null) {
      output.write('\n$stackTrace');
    }
    dPrint(output.toString());
  }

  static void debug(String message) => log(message, level: D4LogLevel.debug);
  static void info(String message) => log(message, level: D4LogLevel.info);
  static void warn(String message) => log(message, level: D4LogLevel.warning);
  static void error(String message, {Object? error, StackTrace? stackTrace}) =>
      log(message, level: D4LogLevel.error, error: error, stackTrace: stackTrace);

  static bool _shouldLog(D4LogLevel level) {
    if (!debugEnabled) return false;
    return level.index >= minLevel.index;
  }

  static void setDebug(bool enabled) {
    debugEnabled = enabled;
  }

  static void setMinLevel(D4LogLevel level) {
    minLevel = level;
  }
}
