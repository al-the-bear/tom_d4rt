// D4rt test: TOP25 - Top-level variable (var/final)
// Verifies top-level variables are readable and writable via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Read top-level var
  if (appName != 'Dart Globals Demo') {
    errors.add('appName expected "Dart Globals Demo", got "$appName"');
  }

  // Read mutable top-level var
  var origRetries = maxRetries;
  if (origRetries != 3) {
    errors.add('maxRetries expected 3, got $origRetries');
  }

  // Write top-level var
  maxRetries = 5;
  if (maxRetries != 5) {
    errors.add('maxRetries after set to 5, got $maxRetries');
  }
  maxRetries = origRetries; // restore

  if (errors.isEmpty) {
    print('TOP25_PASSED');
  } else {
    print('TOP25_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
