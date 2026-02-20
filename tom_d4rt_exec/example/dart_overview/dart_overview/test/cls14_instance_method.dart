// D4rt test: CLS14 - Instance methods
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Dog.bark() - just call it, don't check print output
  var dog = Dog('Spot', 2);
  dog.bark();

  // Test BankAccount methods
  var ba = BankAccount('ACC-3', 100.0);

  // deposit
  ba.deposit(50.0);
  if (ba.balance != 150.0) {
    errors.add('BankAccount.balance after deposit(50) expected 150.0, got ${ba.balance}');
  }

  // withdraw success
  var withdrawResult = ba.withdraw(30.0);
  if (withdrawResult != true) {
    errors.add('BankAccount.withdraw(30) expected true, got $withdrawResult');
  }
  if (ba.balance != 120.0) {
    errors.add('BankAccount.balance after withdraw(30) expected 120.0, got ${ba.balance}');
  }

  // withdraw failure (insufficient funds)
  var withdrawFail = ba.withdraw(200.0);
  if (withdrawFail != false) {
    errors.add('BankAccount.withdraw(200) expected false, got $withdrawFail');
  }
  if (ba.balance != 120.0) {
    errors.add('BankAccount.balance after failed withdraw expected 120.0, got ${ba.balance}');
  }

  if (errors.isEmpty) {
    print('CLS14_PASSED');
  } else {
    print('CLS14_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
