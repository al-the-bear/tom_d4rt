// D4rt test: INH01 - Single-level extends
// Verifies single-level class inheritance works via bridges.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Cat extends Animal (single level)
  var cat = Cat('Whiskers');
  if (cat.name != 'Whiskers') {
    errors.add('Cat.name expected "Whiskers", got "${cat.name}"');
  }

  // Inherited method from Animal
  var speak = cat.speak();
  if (speak != 'Meow!') {
    errors.add('Cat.speak() expected "Meow!", got "$speak"');
  }

  // BaseAnimal → DogAnimal (another single-level extends)
  var dog = DogAnimal('Rex');
  if (dog.name != 'Rex') {
    errors.add('DogAnimal.name expected "Rex", got "${dog.name}"');
  }

  if (errors.isEmpty) {
    print('INH01_PASSED');
  } else {
    print('INH01_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
