// D4rt test: TOP02 - Abstract class
// Verifies abstract classes are bridged and concrete subclasses are constructible.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Vehicle is abstract — can't instantiate directly.
  // Its concrete subclass Motorcycle should be constructible.
  var moto = Motorcycle();
  var moveResult = moto.move();
  if (moveResult != 'Motorcycle is riding') {
    errors.add('Motorcycle.move() expected "Motorcycle is riding", got "$moveResult"');
  }

  // Car also extends abstract Vehicle
  var car = Car();
  var carMove = car.move();
  if (carMove != 'Car is driving') {
    errors.add('Car.move() expected "Car is driving", got "$carMove"');
  }

  if (errors.isEmpty) {
    print('TOP02_PASSED');
  } else {
    print('TOP02_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
