// D4rt test: TYPE04 - Nullable return
// Verifies functions returning nullable types work correctly.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // firstOrNull<T>(List<T>) returns T?
  var r1 = firstOrNull(<String>[]);
  if (r1 != null) {
    errors.add('firstOrNull(<String>[]) expected null, got $r1');
  }

  var r2 = firstOrNull(['hello', 'world']);
  if (r2 != 'hello') {
    errors.add('firstOrNull(["hello","world"]) expected "hello", got $r2');
  }

  // currentUser is String? — can be null
  var savedUser = currentUser;
  currentUser = null;
  var r3 = currentUser;
  if (r3 != null) {
    errors.add('currentUser after null assignment expected null, got $r3');
  }

  currentUser = 'Test';
  var r4 = currentUser;
  if (r4 != 'Test') {
    errors.add('currentUser after "Test" assignment expected "Test", got $r4');
  }

  // Restore
  currentUser = savedUser;

  if (errors.isEmpty) {
    print('TYPE04_PASSED');
  } else {
    print('TYPE04_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
