// D4rt test: CTOR07 - Private constructor
// Verifies private constructors are not bridged, but factory/singleton access works.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Logger has private ctor + factory ctor (singleton cache)
  var logger1 = Logger('app');
  if (logger1.name != 'app') {
    errors.add('Logger("app").name expected "app", got "${logger1.name}"');
  }

  // Same name should return same instance (singleton)
  var logger2 = Logger('app');
  if (logger1 != logger2) {
    errors.add('Logger("app") should return same instance (singleton)');
  }

  // Different name → different instance
  var logger3 = Logger('db');
  if (logger3.name != 'db') {
    errors.add('Logger("db").name expected "db", got "${logger3.name}"');
  }

  // Database.instance is a singleton via private constructor
  var db = Database.instance;
  if (db.name != 'MainDB') {
    errors.add('Database.instance.name expected "MainDB", got "${db.name}"');
  }

  if (errors.isEmpty) {
    print('CTOR07_PASSED');
  } else {
    print('CTOR07_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
