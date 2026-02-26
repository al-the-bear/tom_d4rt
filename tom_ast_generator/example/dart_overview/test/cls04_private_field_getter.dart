// D4rt test: CLS04 - Private fields with public getters
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test BankAccount private _balance with public getter
  var ba = BankAccount('ACC-2', 250.0);
  if (ba.balance != 250.0) {
    errors.add('BankAccount.balance expected 250.0, got ${ba.balance}');
  }

  // Verify balance updates after deposit
  ba.deposit(100.0);
  if (ba.balance != 350.0) {
    errors.add('BankAccount.balance after deposit(100) expected 350.0, got ${ba.balance}');
  }

  if (errors.isEmpty) {
    print('CLS04_PASSED');
  } else {
    print('CLS04_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
