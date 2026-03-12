// D4rt test: INH04 - Mixin with
// Verifies classes using 'with' have mixed-in members accessible.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Musician uses 'with Musical'
  var musician = Musician('Alice');
  musician.playInstrument(); // from Musical mixin

  // ProfessionalDancer uses 'with Dancing'
  var dancer = ProfessionalDancer('Bob');
  dancer.dance(); // from Dancing mixin

  // Entertainer uses 'with Musical, Dancing' (two mixins)
  var entertainer = Entertainer('Carol');
  entertainer.playInstrument(); // from Musical
  entertainer.dance(); // from Dancing
  entertainer.perform(); // own method

  // ConsoleLogger uses 'with Logging'
  var logger = ConsoleLogger();
  logger.info('test info message');
  logger.warning('test warning');

  if (errors.isEmpty) {
    print('INH04_PASSED');
  } else {
    print('INH04_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
