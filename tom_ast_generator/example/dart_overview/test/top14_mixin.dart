// D4rt test: TOP14 - Mixin
// Verifies mixin members are accessible on classes that use them.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Musician uses 'with Musical' mixin
  var musician = Musician('Alice');
  if (musician.name != 'Alice') {
    errors.add('Musician.name expected "Alice", got "${musician.name}"');
  }
  // Musical mixin provides playInstrument()
  musician.playInstrument();

  // Entertainer uses 'with Musical, Dancing' (two mixins)
  var entertainer = Entertainer('Bob');
  if (entertainer.name != 'Bob') {
    errors.add('Entertainer.name expected "Bob", got "${entertainer.name}"');
  }
  entertainer.playInstrument();
  entertainer.dance();
  entertainer.perform();

  if (errors.isEmpty) {
    print('TOP14_PASSED');
  } else {
    print('TOP14_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
