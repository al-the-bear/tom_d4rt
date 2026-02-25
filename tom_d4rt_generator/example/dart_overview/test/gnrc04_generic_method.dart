// D4rt test: GNRC04 - Generic methods
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Wrapper.transform
  var wrapper = Wrapper(10);
  var transformed = wrapper.transform((x) => x.toString());
  if (transformed.value != '10') {
    errors.add('Wrapper(10).transform(toString) expected "10", got "${transformed.value}"');
  }

  // Test Maybe.map
  var maybe = Maybe.some(5);
  var mapped = maybe.map((x) => x * 2);
  if (mapped.value != 10) {
    errors.add('Maybe.some(5).map(x*2) expected 10, got ${mapped.value}');
  }

  // Test Maybe.map on none
  var none = Maybe.none();
  var mappedNone = none.map((x) => x * 2);
  if (mappedNone.hasValue != false) {
    errors.add('Maybe.none().map() expected hasValue=false, got ${mappedNone.hasValue}');
  }

  if (errors.isEmpty) {
    print('GNRC04_PASSED');
  } else {
    print('GNRC04_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
