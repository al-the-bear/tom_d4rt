// D4rt test: CTOR03 - Named constructors
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test User.guest() named constructor
  var guest = User.guest();
  if (guest.name != 'Guest') {
    errors.add('User.guest().name expected "Guest", got "${guest.name}"');
  }
  if (guest.email != 'guest@example.com') {
    errors.add('User.guest().email expected "guest@example.com", got "${guest.email}"');
  }

  // Test Maybe.some() named constructor
  var some = Maybe.some(42);
  if (some.hasValue != true) {
    errors.add('Maybe.some(42).hasValue expected true, got ${some.hasValue}');
  }
  if (some.value != 42) {
    errors.add('Maybe.some(42).value expected 42, got ${some.value}');
  }

  // Test Maybe.none() named constructor
  var none = Maybe.none();
  if (none.hasValue != false) {
    errors.add('Maybe.none().hasValue expected false, got ${none.hasValue}');
  }

  // Test Result.success() named constructor
  var success = Result.success(100);
  if (success.isSuccess != true) {
    errors.add('Result.success(100).isSuccess expected true, got ${success.isSuccess}');
  }

  // Test Result.failure() named constructor
  var failure = Result.failure('error');
  if (failure.isSuccess != false) {
    errors.add('Result.failure("error").isSuccess expected false, got ${failure.isSuccess}');
  }

  if (errors.isEmpty) {
    print('CTOR03_PASSED');
  } else {
    print('CTOR03_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
