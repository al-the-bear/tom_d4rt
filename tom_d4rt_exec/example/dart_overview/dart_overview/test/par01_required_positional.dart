// D4rt test: PAR01 - Required positional parameters
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Dog(name, age)
  var dog = Dog('A', 1);
  if (dog.name != 'A') errors.add('Dog.name expected "A", got "${dog.name}"');
  if (dog.age != 1) errors.add('Dog.age expected 1, got ${dog.age}');

  // Test Rectangle(width, height)
  var rect = Rectangle(2.0, 3.0);
  if (rect.width != 2.0) errors.add('Rectangle.width expected 2.0, got ${rect.width}');
  if (rect.height != 3.0) errors.add('Rectangle.height expected 3.0, got ${rect.height}');

  // Test BankAccount(accountNumber, balance)
  var ba = BankAccount('B', 50.0);
  if (ba.accountNumber != 'B') errors.add('BankAccount.accountNumber expected "B", got "${ba.accountNumber}"');
  if (ba.balance != 50.0) errors.add('BankAccount.balance expected 50.0, got ${ba.balance}');

  // Test Circle(radius)
  var circle = Circle(4.0);
  if (circle.radius != 4.0) errors.add('Circle.radius expected 4.0, got ${circle.radius}');

  // Test User(name, email)
  var user = User('C', 'c@d.com');
  if (user.name != 'C') errors.add('User.name expected "C", got "${user.name}"');
  if (user.email != 'c@d.com') errors.add('User.email expected "c@d.com", got "${user.email}"');

  if (errors.isEmpty) {
    print('PAR01_PASSED');
  } else {
    print('PAR01_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
