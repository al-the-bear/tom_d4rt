// D4rt test: GNRC01 - Generic with single type parameter
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Box<int>
  var intBox = Box(42);
  if (intBox.value != 42) {
    errors.add('Box(42).value expected 42, got ${intBox.value}');
  }

  // Test Box<String>
  var strBox = Box('hello');
  if (strBox.value != 'hello') {
    errors.add('Box("hello").value expected "hello", got "${strBox.value}"');
  }

  // Test Wrapper<double>
  var wrapper = Wrapper(3.14);
  if (wrapper.value != 3.14) {
    errors.add('Wrapper(3.14).value expected 3.14, got ${wrapper.value}');
  }

  // Test Maybe.some<String>
  var maybe = Maybe.some('test');
  if (maybe.value != 'test') {
    errors.add('Maybe.some("test").value expected "test", got "${maybe.value}"');
  }

  if (errors.isEmpty) {
    print('GNRC01_PASSED');
  } else {
    print('GNRC01_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
