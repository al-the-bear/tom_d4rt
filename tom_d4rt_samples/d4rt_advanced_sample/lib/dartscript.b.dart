// D4rt Bridge - Generated file, do not edit
// Dartscript registration for d4rt_advanced_sample
// Generated: 2026-06-17T19:03:54.538709

/// D4rt Bridge Registration for d4rt_advanced_sample
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/geometry_bridges.b.dart' as geometry_bridges;
import 'src/d4rt_bridges/relaxers.b.dart' as relaxer_factories;

/// Combined bridge registration for d4rt_advanced_sample.
class AdvancedSampleBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    geometry_bridges.GeometryBridge.registerBridges(
      d4rt,
      'package:d4rt_advanced_sample/d4rt_advanced_sample.dart',
    );
    geometry_bridges.GeometryBridge.registerBridges(
      d4rt,
      'lib/d4rt_advanced_sample.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in geometry_bridges.GeometryBridge.subPackageBarrels()) {
      geometry_bridges.GeometryBridge.registerBridges(d4rt, barrel);
    }

    // RC-2: Register generic constructor factories
    relaxer_factories.registerGenericConstructors();
    // GEN-079: Register relaxer wrapper factories
    relaxer_factories.registerRelaxers();
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(geometry_bridges.GeometryBridge.getImportBlock());
    return buffer.toString();
  }
}
