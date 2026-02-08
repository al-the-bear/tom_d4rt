// D4rt Bridge - Generated file, do not edit
// Dartscript registration for dart_overview
// Generated: 2026-02-08T12:02:54.890100

/// D4rt Bridge Registration for dart_overview
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/dart_overview_bridges.b.dart' as all_bridges;

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
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(all_bridges.AllBridge.getImportBlock());
    return buffer.toString();
  }
}
