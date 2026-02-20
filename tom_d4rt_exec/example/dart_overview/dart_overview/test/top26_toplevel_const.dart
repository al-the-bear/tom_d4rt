// D4rt test: TOP26 - Top-level const
// Verifies top-level const values are accessible via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Read top-level const String
  if (apiUrl != 'https://api.example.com') {
    errors.add('apiUrl expected "https://api.example.com", got "$apiUrl"');
  }

  // Read top-level const int
  if (maxConnections != 10) {
    errors.add('maxConnections expected 10, got $maxConnections');
  }

  if (errors.isEmpty) {
    print('TOP26_PASSED');
  } else {
    print('TOP26_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
