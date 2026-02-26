// D4rt test: GNRC05 - Generic static factory
// Verifies generic named constructors (serving as static factories) work.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Maybe<T> has Maybe.some(T) and Maybe.none() — generic factories
  var some = Maybe.some('hello');
  if (!some.hasValue) {
    errors.add('Maybe.some("hello").hasValue expected true');
  }
  if (some.value != 'hello') {
    errors.add('Maybe.some("hello").value expected "hello", got "${some.value}"');
  }

  var none = Maybe<String>.none();
  if (none.hasValue) {
    errors.add('Maybe.none().hasValue expected false');
  }
  // getOrElse with default
  var fallback = none.getOrElse('default');
  if (fallback != 'default') {
    errors.add('Maybe.none().getOrElse("default") expected "default", got "$fallback"');
  }

  // Result<T,E> has Result.success(T) and Result.failure(E)
  var success = Result.success(42);
  if (!success.isSuccess) {
    errors.add('Result.success(42).isSuccess expected true');
  }
  // Use fold to access value
  var val = success.fold((v) => v, (e) => -1);
  if (val != 42) {
    errors.add('Result.success(42).fold expected 42, got $val');
  }

  var failure = Result<int, String>.failure('error');
  if (failure.isSuccess) {
    errors.add('Result.failure.isSuccess expected false');
  }
  var errMsg = failure.fold((v) => 'unexpected', (e) => e);
  if (errMsg != 'error') {
    errors.add('Result.failure.fold expected "error", got "$errMsg"');
  }

  if (errors.isEmpty) {
    print('GNRC05_PASSED');
  } else {
    print('GNRC05_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
