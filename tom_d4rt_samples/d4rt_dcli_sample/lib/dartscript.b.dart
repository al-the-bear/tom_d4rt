// D4rt Bridge - Generated file, do not edit
// Dartscript registration for d4rt_dcli_sample
// Generated: 2026-06-15T13:46:43.360941

/// D4rt Bridge Registration for d4rt_dcli_sample
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/loglib_bridges.b.dart' as loglib_bridges;
import 'src/d4rt_bridges/relaxers.b.dart' as relaxer_factories;

/// Combined bridge registration for d4rt_dcli_sample.
class DcliSampleBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    loglib_bridges.LoglibBridge.registerBridges(
      d4rt,
      'package:d4rt_dcli_sample/d4rt_dcli_sample.dart',
    );
    loglib_bridges.LoglibBridge.registerBridges(
      d4rt,
      'lib/d4rt_dcli_sample.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in loglib_bridges.LoglibBridge.subPackageBarrels()) {
      loglib_bridges.LoglibBridge.registerBridges(d4rt, barrel);
    }

    // RC-2: Register generic constructor factories
    relaxer_factories.registerGenericConstructors();
    // GEN-079: Register relaxer wrapper factories
    relaxer_factories.registerRelaxers();
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(loglib_bridges.LoglibBridge.getImportBlock());
    return buffer.toString();
  }
}
