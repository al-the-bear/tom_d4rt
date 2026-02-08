// D4rt test script: Enhanced enum fields in dart_overview
// Tests Season, HttpStatus, and other enhanced enums with custom fields.
// Expected: FAILS until GEN-041 is fixed.

import 'package:dart_overview/dart_overview.dart';

void main() {
  // Simple enum — should work
  print('Day.monday name: ${Day.monday.name}');
  print('Day.monday index: ${Day.monday.index}');

  // Enhanced enum: Season has months and avgTemperature
  print('Season.spring months: ${Season.spring.months}');
  print('Season.summer avgTemperature: ${Season.summer.avgTemperature}');

  // Enhanced enum: HttpStatus has code, message, isSuccess, isError
  print('HttpStatus.ok code: ${HttpStatus.ok.code}');
  print('HttpStatus.ok message: ${HttpStatus.ok.message}');
  print('HttpStatus.ok isSuccess: ${HttpStatus.ok.isSuccess}');
  print('HttpStatus.notFound code: ${HttpStatus.notFound.code}');
  print('HttpStatus.notFound isError: ${HttpStatus.notFound.isError}');

  // Enhanced enum: Operation has symbol and execute method
  print('Operation.add symbol: ${Operation.add.symbol}');
  var result = Operation.add.execute(10.0, 3.0);
  print('Operation.add execute(10, 3): $result');

  // Enhanced enum: LogLevel has severity field
  print('LogLevel.debug severity: ${LogLevel.debug.severity}');
  print('LogLevel.error severity: ${LogLevel.error.severity}');

  print('ALL_ENHANCED_ENUM_TESTS_PASSED');
}
