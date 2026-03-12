// D4rt test: TOP12 - Enhanced enum with mixin
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test LogLevel severity values
  if (LogLevel.debug.severity != 0) {
    errors.add('LogLevel.debug.severity expected 0, got ${LogLevel.debug.severity}');
  }
  if (LogLevel.info.severity != 1) {
    errors.add('LogLevel.info.severity expected 1, got ${LogLevel.info.severity}');
  }
  if (LogLevel.warning.severity != 2) {
    errors.add('LogLevel.warning.severity expected 2, got ${LogLevel.warning.severity}');
  }
  if (LogLevel.error.severity != 3) {
    errors.add('LogLevel.error.severity expected 3, got ${LogLevel.error.severity}');
  }

  // Test shouldLog from LoggableMixin
  // error.shouldLog(warning) means: should error-level log when min level is warning? yes (3 >= 2)
  if (!LogLevel.error.shouldLog(LogLevel.warning)) {
    errors.add('LogLevel.error.shouldLog(LogLevel.warning) expected true, got false');
  }
  // debug.shouldLog(warning) means: should debug-level log when min level is warning? no (0 >= 2 is false)
  if (LogLevel.debug.shouldLog(LogLevel.warning)) {
    errors.add('LogLevel.debug.shouldLog(LogLevel.warning) expected false, got true');
  }
  // error.shouldLog(debug) means: should error-level log when min level is debug? yes (3 >= 0)
  if (!LogLevel.error.shouldLog(LogLevel.debug)) {
    errors.add('LogLevel.error.shouldLog(LogLevel.debug) expected true, got false');
  }

  if (errors.isEmpty) {
    print('TOP12_PASSED');
  } else {
    print('TOP12_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
