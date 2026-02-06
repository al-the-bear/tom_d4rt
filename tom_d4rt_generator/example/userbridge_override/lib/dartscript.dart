// D4rt Bridge - Generated file, do not edit
// Dartscript registration for userbridge_override_example
// Generated: 2026-02-06T19:20:51.544367

/// D4rt Bridge Registration for userbridge_override_example
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/userbridge_bridges.dart' as all_bridges;

/// Combined bridge registration for userbridge_override_example.
class UserbridgeOverrideExampleBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    all_bridges.AllBridge.registerBridges(
      d4rt,
      'package:userbridge_override_example/userbridge_override_example.dart',
    );
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(all_bridges.AllBridge.getImportBlock());
    return buffer.toString();
  }
}
