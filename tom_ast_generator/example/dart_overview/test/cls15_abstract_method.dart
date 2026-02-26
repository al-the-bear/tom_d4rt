// D4rt test: CLS15 - Abstract method
// Verifies abstract methods work through concrete subclass bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Vehicle is abstract with abstract method move()
  // Motorcycle is a concrete subclass that implements move()
  var moto = Motorcycle();
  var result = moto.move();
  if (result != 'Motorcycle is riding') {
    errors.add('Motorcycle.move() expected "Motorcycle is riding", got "$result"');
  }

  // Car is another concrete subclass
  var car = Car();
  var carResult = car.move();
  if (carResult != 'Car is driving') {
    errors.add('Car.move() expected "Car is driving", got "$carResult"');
  }

  if (errors.isEmpty) {
    print('CLS15_PASSED');
  } else {
    print('CLS15_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
