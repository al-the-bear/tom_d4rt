// D4rt test: CTOR04 - Factory-like constructors
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test User.fromMap named constructor (factory-like)
  var user = User.fromMap({'name': 'Bob', 'email': 'bob@test.com'});
  if (user.name != 'Bob') {
    errors.add('User.fromMap name expected "Bob", got "${user.name}"');
  }
  if (user.email != 'bob@test.com') {
    errors.add('User.fromMap email expected "bob@test.com", got "${user.email}"');
  }

  // Test with different values
  var user2 = User.fromMap({'name': 'Charlie', 'email': 'charlie@example.com'});
  if (user2.name != 'Charlie') {
    errors.add('User.fromMap name expected "Charlie", got "${user2.name}"');
  }
  if (user2.email != 'charlie@example.com') {
    errors.add('User.fromMap email expected "charlie@example.com", got "${user2.email}"');
  }

  if (errors.isEmpty) {
    print('CTOR04_PASSED');
  } else {
    print('CTOR04_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
