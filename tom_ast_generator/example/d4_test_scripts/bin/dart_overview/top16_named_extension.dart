// D4rt test: TOP16 - Named extension
// Extensions are not bridged by the generator (not supported).
// This test documents that limitation — extensions on bridged types
// are not available in D4rt scripts.
import 'package:d4_example/dart_overview.dart';

void main() {
  // Named extensions cannot be tested via bridges because
  // the generator does not create bridge wrappers for extensions.
  // Extension methods are compile-time resolved and do not exist
  // as instance methods at runtime.

  // We verify basic types still work — just no extension methods.
  var person = Person();
  person.name = 'Alice';
  person.age = 25;
  if (person.name != 'Alice') {
    print('TOP16_FAILED');
    print('  - Person.name expected "Alice", got "${person.name}"');
  } else {
    // PASSED indicates the test ran — not that extensions are bridged.
    // Coverage should mark this as "not supported".
    print('TOP16_PASSED');
  }
}
