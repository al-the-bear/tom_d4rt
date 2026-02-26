// D4rt test: TOP27 - Top-level getter
// Verifies explicit top-level getters are callable via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // 'now' is a top-level getter returning DateTime
  // ignore: unused_local_variable
  var time = now;

  // 'connectionCount' is a top-level getter returning int
  // ignore: unused_local_variable
  var count = connectionCount;

  // 'cachedValue' is a top-level getter returning String
  // ignore: unused_local_variable
  var cached = cachedValue;

  if (errors.isEmpty) {
    print('TOP27_PASSED');
  } else {
    print('TOP27_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
