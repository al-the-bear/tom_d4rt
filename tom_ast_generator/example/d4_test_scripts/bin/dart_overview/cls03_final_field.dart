// D4rt test: CLS03 - Final fields
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test BankAccount final field
  var ba = BankAccount('ACC-1', 500.0);
  if (ba.accountNumber != 'ACC-1') {
    errors.add('BankAccount.accountNumber expected "ACC-1", got "${ba.accountNumber}"');
  }

  // Test Circle final field
  var circle = Circle(7.5);
  if (circle.radius != 7.5) {
    errors.add('Circle.radius expected 7.5, got ${circle.radius}');
  }

  // Test Box final field
  var box = Box(42);
  if (box.value != 42) {
    errors.add('Box.value expected 42, got ${box.value}');
  }

  if (errors.isEmpty) {
    print('CLS03_PASSED');
  } else {
    print('CLS03_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
