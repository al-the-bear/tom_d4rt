// D4rt test: TOP06 - Final class
// Verifies final classes are bridged and constructible.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  var config = AppConfig('production', false);
  if (config.environment != 'production') {
    errors.add('AppConfig.environment expected "production", got "${config.environment}"');
  }
  if (config.debug != false) {
    errors.add('AppConfig.debug expected false, got ${config.debug}');
  }

  var setting = config.getSetting();
  if (setting != 'Environment: production') {
    errors.add('AppConfig.getSetting() expected "Environment: production", got "$setting"');
  }

  if (errors.isEmpty) {
    print('TOP06_PASSED');
  } else {
    print('TOP06_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
