// D4rt test: TOP18 - Extension type
// Extension types are not bridged by the generator (not supported).
// Extension types are compile-time wrappers with zero runtime cost,
// so they don't have a runtime representation to bridge.
import 'package:d4_example/dart_overview.dart';

void main() {
  // Extension types (e.g., UserId, EmailAddress) are not bridgeable
  // because they are erased at runtime.
  // We verify basic types still work.
  var counter = Counter.instanceCount;
  if (counter < 0) {
    print('TOP18_FAILED');
    print('  - Counter.instanceCount should be non-negative');
  } else {
    print('TOP18_PASSED');
  }
}
