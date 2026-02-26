// D4rt test: TOP09 - Enhanced enum fields
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Season enhanced enum fields
  var spring = Season.spring;
  if (spring.months.length != 3) {
    errors.add('Season.spring.months.length expected 3, got ${spring.months.length}');
  }
  if (spring.months[0] != 'March') {
    errors.add('Season.spring.months[0] expected "March", got "${spring.months[0]}"');
  }
  if (spring.avgTemperature != 15) {
    errors.add('Season.spring.avgTemperature expected 15, got ${spring.avgTemperature}');
  }

  // Test HttpStatus enhanced enum fields
  var ok = HttpStatus.ok;
  if (ok.code != 200) {
    errors.add('HttpStatus.ok.code expected 200, got ${ok.code}');
  }
  if (ok.message != 'OK') {
    errors.add('HttpStatus.ok.message expected "OK", got "${ok.message}"');
  }

  // Test another HttpStatus
  var notFound = HttpStatus.notFound;
  if (notFound.code != 404) {
    errors.add('HttpStatus.notFound.code expected 404, got ${notFound.code}');
  }
  if (notFound.message != 'Not Found') {
    errors.add('HttpStatus.notFound.message expected "Not Found", got "${notFound.message}"');
  }

  if (errors.isEmpty) {
    print('TOP09_PASSED');
  } else {
    print('TOP09_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
