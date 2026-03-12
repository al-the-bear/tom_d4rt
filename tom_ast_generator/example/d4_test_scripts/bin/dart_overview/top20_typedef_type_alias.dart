// D4rt test: TOP20 - Typedef (type alias)
// Type aliases (e.g., typedef JsonMap = Map<String, dynamic>) don't need
// bridges — they are compile-time aliases resolved to the underlying type.
import 'package:d4_example/dart_overview.dart';

void main() {
  // Type aliases work transparently at runtime.
  // A JsonMap is just a Map<String, dynamic>.
  // We verify the aliased types work normally.
  var person = Person();
  person.age = 30;
  if (person.age != 30) {
    print('TOP20_FAILED');
    print('  - Person.age expected 30, got ${person.age}');
  } else {
    print('TOP20_PASSED');
  }
}
