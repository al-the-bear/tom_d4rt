// D4rt test: TOP08 - Simple enum basics
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Day enum
  if (Day.monday.name != 'monday') {
    errors.add('Day.monday.name expected "monday", got "${Day.monday.name}"');
  }
  if (Day.monday.index != 0) {
    errors.add('Day.monday.index expected 0, got ${Day.monday.index}');
  }
  if (Day.values.length != 7) {
    errors.add('Day.values.length expected 7, got ${Day.values.length}');
  }

  // Test Priority enum
  if (Priority.high.name != 'high') {
    errors.add('Priority.high.name expected "high", got "${Priority.high.name}"');
  }

  // Test Role enum
  if (Role.admin.name != 'admin') {
    errors.add('Role.admin.name expected "admin", got "${Role.admin.name}"');
  }

  if (errors.isEmpty) {
    print('TOP08_PASSED');
  } else {
    print('TOP08_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
