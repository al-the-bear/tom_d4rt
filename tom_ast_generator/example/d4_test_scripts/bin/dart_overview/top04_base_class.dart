// D4rt test: TOP04 - Base class
// Verifies base class and its subclass are bridged.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // BaseAnimal is a base class
  var animal = BaseAnimal('Rex');
  if (animal.name != 'Rex') {
    errors.add('BaseAnimal.name expected "Rex", got "${animal.name}"');
  }

  // DogAnimal extends BaseAnimal (base)
  var dog = DogAnimal('Buddy');
  if (dog.name != 'Buddy') {
    errors.add('DogAnimal.name expected "Buddy", got "${dog.name}"');
  }

  if (errors.isEmpty) {
    print('TOP04_PASSED');
  } else {
    print('TOP04_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
