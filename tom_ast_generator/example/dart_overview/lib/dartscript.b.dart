// D4rt Bridge - Generated file, do not edit
// Dartscript registration for dart_overview
<<<<<<< Updated upstream
// Generated: 2026-02-14T12:48:56.976331
=======
// Generated: 2026-03-12T17:02:50.229994
>>>>>>> Stashed changes

/// D4rt Bridge Registration for dart_overview
library;

<<<<<<< Updated upstream
import 'package:tom_d4rt_exec/d4rt.dart';
import 'src/d4rt_bridges/dart_overview_bridges.b.dart' as all_bridges;
=======
import 'package:tom_d4rt/d4rt.dart';
import 'src\d4rt_bridges\dart_overview_bridges.b.dart' as all_bridges;
>>>>>>> Stashed changes

/// Combined bridge registration for dart_overview.
class DartOverviewBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    all_bridges.AllBridge.registerBridges(
      d4rt,
      'package:dart_overview/dart_overview.dart',
    );
    all_bridges.AllBridge.registerBridges(
      d4rt,
      'lib/dart_overview.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in all_bridges.AllBridge.subPackageBarrels()) {
      all_bridges.AllBridge.registerBridges(d4rt, barrel);
    }
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(all_bridges.AllBridge.getImportBlock());
    return buffer.toString();
  }
}
