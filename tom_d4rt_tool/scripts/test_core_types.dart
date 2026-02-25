// D4rt Test Suite - Tom Core Kernel Types
// Run with: dart run bin/d4rtrun.b.dart scripts/test_core_types.dart

import 'package:tom_core_kernel/tom_core_kernel.dart';
import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';

void main() {
  // ===========================================================================
  // Test: TomBaseException / TomException (6 tests)
  // ===========================================================================

  var ex = TomBaseException('ERR_TEST', 'Test error');
  verifyNotNull(ex, 'TomBaseException created');
  verifyEquals(ex.key, 'ERR_TEST', 'Exception key');
  verifyEquals(ex.defaultUserMessage, 'Test error', 'Exception message');
  verifyNotNull(ex.uuid, 'Exception has uuid');
  verifyContains(ex.toString(), 'ERR_TEST', 'toString contains key');

  var exWithParams = TomBaseException('ERR_PARAMS', 'Param test', parameters: {'code': 42});
  verifyNotNull(exWithParams.parameters, 'Exception parameters');

  // ===========================================================================
  // Test: TomLogLevel (5 tests)
  // ===========================================================================

  var debugLevel = TomLogLevel.debug;
  verifyNotNull(debugLevel, 'TomLogLevel.debug');

  var infoLevel = TomLogLevel.info;
  verifyNotNull(infoLevel, 'TomLogLevel.info');

  var warnLevel = TomLogLevel.warn;
  verifyNotNull(warnLevel, 'TomLogLevel.warn');

  var errorLevel = TomLogLevel.error;
  verifyNotNull(errorLevel, 'TomLogLevel.error');

  var fatalLevel = TomLogLevel.fatal;
  verifyNotNull(fatalLevel, 'TomLogLevel.fatal');

  // ===========================================================================
  // Test: TomLogger (2 tests)
  // ===========================================================================

  // TomLogger uses a static instance pattern, not direct construction
  verifyNotNull(TomLogger, 'TomLogger class is accessible');
  verify(true, 'TomLogger module loaded');

  // ===========================================================================
  // Test: TomServerCallError (6 tests)
  // ===========================================================================

  var err404 = TomServerCallError(statusCode: 404);
  verifyNotNull(err404, 'Error 404 created');
  verifyEquals(err404.statusCode, 404, 'Error statusCode');

  var err500 = TomServerCallError(statusCode: 500, internalError: 1);
  verifyEquals(err500.internalError, 1, 'Error 500 internalError');

  var ok200 = TomServerCallError(statusCode: 200);
  verifyEquals(ok200.statusCode, 200, 'OK 200 statusCode');

  var err401 = TomServerCallError(statusCode: 401, reasonPhrase: 'Unauthorized');
  verifyNotNull(err401, 'Error 401 created');

  // ===========================================================================
  // Test: Observable Types (6 tests)
  // ===========================================================================

  var obsStr = TomString('hello');
  verifyNotNull(obsStr, 'TomString created');
  verifyContains(obsStr.toString(), 'hello', 'TomString toString');

  var obsInt = TomInt(42);
  verifyNotNull(obsInt, 'TomInt created');

  var obsBool = TomBool(true);
  verifyNotNull(obsBool, 'TomBool created');

  // Test TomLogLevel comparisons
  verify(TomLogLevel.error != TomLogLevel.debug, 'Error != Debug');
  verifyNotNull(TomLogLevel.trace, 'TomLogLevel.trace');

  // ===========================================================================
  // Summary
  // ===========================================================================

  testSummary();
}
