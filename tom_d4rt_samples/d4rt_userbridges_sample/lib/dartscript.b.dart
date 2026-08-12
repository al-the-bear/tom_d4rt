// D4rt Bridge - Generated file, do not edit
// Dartscript registration for d4rt_userbridges_sample
// Generated: 2026-08-12T06:44:50.263766

/// D4rt Bridge Registration for d4rt_userbridges_sample
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/ledger_bridges.b.dart' as ledger_bridges;
import 'src/d4rt_bridges/relaxers.b.dart' as relaxer_factories;

/// Combined bridge registration for d4rt_userbridges_sample.
class UserBridgesSampleBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    ledger_bridges.LedgerBridge.registerBridges(
      d4rt,
      'package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart',
    );
    ledger_bridges.LedgerBridge.registerBridges(
      d4rt,
      'lib/d4rt_userbridges_sample.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in ledger_bridges.LedgerBridge.subPackageBarrels()) {
      ledger_bridges.LedgerBridge.registerBridges(d4rt, barrel);
    }

    // RC-2: Register generic constructor factories
    relaxer_factories.registerGenericConstructors();
    // GEN-079: Register relaxer wrapper factories
    relaxer_factories.registerRelaxers();
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(ledger_bridges.LedgerBridge.getImportBlock());
    return buffer.toString();
  }
}
