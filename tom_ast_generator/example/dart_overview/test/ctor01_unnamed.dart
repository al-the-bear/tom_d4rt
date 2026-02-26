// D4rt test: CTOR01 - Unnamed constructors
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Dog unnamed constructor
  var dog = Dog('Fido', 4);
  if (dog.name != 'Fido') errors.add('Dog.name expected "Fido", got "${dog.name}"');
  if (dog.age != 4) errors.add('Dog.age expected 4, got ${dog.age}');

  // Test Rectangle unnamed constructor
  var rect = Rectangle(10.0, 5.0);
  if (rect.width != 10.0) errors.add('Rectangle.width expected 10.0, got ${rect.width}');
  if (rect.height != 5.0) errors.add('Rectangle.height expected 5.0, got ${rect.height}');

  // Test BankAccount unnamed constructor
  var ba = BankAccount('X', 0.0);
  if (ba.accountNumber != 'X') errors.add('BankAccount.accountNumber expected "X", got "${ba.accountNumber}"');
  if (ba.balance != 0.0) errors.add('BankAccount.balance expected 0.0, got ${ba.balance}');

  // Test Circle unnamed constructor
  var circle = Circle(1.0);
  if (circle.radius != 1.0) errors.add('Circle.radius expected 1.0, got ${circle.radius}');

  // Test Box unnamed constructor
  var box = Box('test');
  if (box.value != 'test') errors.add('Box.value expected "test", got "${box.value}"');

  // Test Wrapper unnamed constructor
  var wrapper = Wrapper(99);
  if (wrapper.value != 99) errors.add('Wrapper.value expected 99, got ${wrapper.value}');

  // Test Pair unnamed constructor
  var pair = Pair(1, 2);
  if (pair.first != 1) errors.add('Pair.first expected 1, got ${pair.first}');
  if (pair.second != 2) errors.add('Pair.second expected 2, got ${pair.second}');

  if (errors.isEmpty) {
    print('CTOR01_PASSED');
  } else {
    print('CTOR01_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
