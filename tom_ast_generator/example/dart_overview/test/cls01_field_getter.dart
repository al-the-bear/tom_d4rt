// D4rt test: CLS01 - Instance field getters
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Dog field getters
  var dog = Dog('Max', 3);
  if (dog.name != 'Max') {
    errors.add('Dog.name expected "Max", got "${dog.name}"');
  }
  if (dog.age != 3) {
    errors.add('Dog.age expected 3, got ${dog.age}');
  }

  // Test Circle field getter
  var circle = Circle(5.0);
  if (circle.radius != 5.0) {
    errors.add('Circle.radius expected 5.0, got ${circle.radius}');
  }

  // Test BankAccount field getter
  var ba = BankAccount('123', 100.0);
  if (ba.accountNumber != '123') {
    errors.add('BankAccount.accountNumber expected "123", got "${ba.accountNumber}"');
  }

  if (errors.isEmpty) {
    print('CLS01_PASSED');
  } else {
    print('CLS01_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
