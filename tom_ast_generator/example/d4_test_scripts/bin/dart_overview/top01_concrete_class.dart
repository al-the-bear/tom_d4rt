// D4rt test: TOP01 - Concrete class with explicit constructor
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Dog with explicit constructor
  var dog = Dog('Rex', 5);
  if (dog.name != 'Rex') errors.add('Dog.name expected "Rex", got "${dog.name}"');
  if (dog.age != 5) errors.add('Dog.age expected 5, got ${dog.age}');

  // Test Circle with explicit constructor
  var circle = Circle(3.0);
  if (circle.radius != 3.0) errors.add('Circle.radius expected 3.0, got ${circle.radius}');

  if (errors.isEmpty) {
    print('TOP01_PASSED');
  } else {
    print('TOP01_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
