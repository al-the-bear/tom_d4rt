// D4rt test: CLS16 - toString override
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test User.toString()
  var user = User('Alice', 'alice@example.com');
  var userStr = user.toString();
  if (userStr != 'User(Alice, alice@example.com)') {
    errors.add('User.toString() expected "User(Alice, alice@example.com)", got "$userStr"');
  }

  // Test Pair.toString()
  var pair = Pair('hello', 42);
  var pairStr = pair.toString();
  if (pairStr != 'Pair(hello, 42)') {
    errors.add('Pair.toString() expected "Pair(hello, 42)", got "$pairStr"');
  }

  if (errors.isEmpty) {
    print('CLS16_PASSED');
  } else {
    print('CLS16_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
