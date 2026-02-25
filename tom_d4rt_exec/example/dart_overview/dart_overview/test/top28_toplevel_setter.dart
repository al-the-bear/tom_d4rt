// D4rt test: TOP28 - Top-level setter
// Verifies top-level getter/setter pairs are accessible via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // logLevel is a getter/setter pair in globals (uses LogSeverity enum)
  // Read the current level
  var current = logLevel;
  if (current != LogSeverity.info) {
    errors.add('logLevel initial expected LogSeverity.info, got $current');
  }

  // Write a new level
  logLevel = LogSeverity.debug;
  var after = logLevel;
  if (after != LogSeverity.debug) {
    errors.add('logLevel after set to debug expected LogSeverity.debug, got $after');
  }

  // Restore
  logLevel = LogSeverity.info;

  if (errors.isEmpty) {
    print('TOP28_PASSED');
  } else {
    print('TOP28_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
