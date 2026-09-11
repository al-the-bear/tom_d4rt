// D4rt Bridge - Generated file, do not edit
// Dartscript registration for user_guide_example
// Generated: 2026-09-11T10:25:58.040026

/// D4rt Bridge Registration for user_guide_example
library;

import 'package:tom_d4rt_exec/d4rt.dart';
import 'src/d4rt_bridges/user_guide_bridges.b.dart' as all_bridges;
import 'src/d4rt_bridges/relaxers.b.dart' as relaxer_factories;

/// Combined bridge registration for user_guide_example.
class UserGuideExampleBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    all_bridges.AllBridge.registerBridges(
      d4rt,
      'package:user_guide_example/user_guide_example.dart',
    );
    all_bridges.AllBridge.registerBridges(
      d4rt,
      'lib/user_guide_example.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in all_bridges.AllBridge.subPackageBarrels()) {
      all_bridges.AllBridge.registerBridges(d4rt, barrel);
    }

    // RC-2: Register generic constructor factories
    relaxer_factories.registerGenericConstructors();
    // GEN-079: Register relaxer wrapper factories
    relaxer_factories.registerRelaxers();
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(all_bridges.AllBridge.getImportBlock());
    return buffer.toString();
  }
}
