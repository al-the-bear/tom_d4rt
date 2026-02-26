// D4rt test: TOP07 - Mixin class
// Verifies mixin class declarations are bridged.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // LoggerMixin is a mixin class — can be used as both a class and a mixin
  // LoggingService uses LoggerMixin via 'with'
  var service = LoggingService();
  service.performAction();

  // LoggerMixin can also be instantiated directly (it's a mixin class)
  var logger = LoggerMixin();
  logger.log('test message');

  if (errors.isEmpty) {
    print('TOP07_PASSED');
  } else {
    print('TOP07_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
