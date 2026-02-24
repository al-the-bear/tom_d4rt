// D4rt test: INH06 - Method override
// Verifies overridden methods dispatch to the subclass implementation.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Animal has speak() returning 'Some sound'
  var animal = Animal('Generic');
  var animalSpeak = animal.speak();
  if (animalSpeak != 'Some sound') {
    errors.add('Animal.speak() expected "Some sound", got "$animalSpeak"');
  }

  // Cat overrides speak() to return 'Meow!'
  var cat = Cat('Whiskers');
  var catSpeak = cat.speak();
  if (catSpeak != 'Meow!') {
    errors.add('Cat.speak() expected "Meow!", got "$catSpeak"');
  }

  // Both should have eat() from Animal (inherited, not overridden)
  animal.eat();
  cat.eat();

  if (errors.isEmpty) {
    print('INH06_PASSED');
  } else {
    print('INH06_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
