// D4rt Bridge - Generated file, do not edit
// Dartscript registration for user_reference_example
// Generated: 2026-02-08T11:14:22.204551

/// D4rt Bridge Registration for user_reference_example
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/user_reference_bridges.b.dart' as all_bridges;

/// Combined bridge registration for user_reference_example.
class UserReferenceExampleBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    all_bridges.AllBridge.registerBridges(
      d4rt,
      'package:user_reference_example/user_reference_example.dart',
    );
    all_bridges.AllBridge.registerBridges(
      d4rt,
      'lib/user_reference_example.dart',
    );
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(all_bridges.AllBridge.getImportBlock());
    return buffer.toString();
  }
}
