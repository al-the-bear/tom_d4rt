// D4rt Bridge - Generated file, do not edit
// Dartscript registration for d4_example
// Generated: 2026-02-11T16:24:01.786202

/// D4rt Bridge Registration for d4_example
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/core_extensions.b.dart' as core_extensions_bridges;
import 'src/d4rt_bridges/path_bridges.b.dart' as path_bridges;
import 'src/d4rt_bridges/dcli_bridges.b.dart' as dcli_bridges;

/// Combined bridge registration for d4_example.
class D4ExampleBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    core_extensions_bridges.CoreExtensionsBridge.registerBridges(
      d4rt,
      'package:d4_example/test_extensions.dart',
    );
    core_extensions_bridges.CoreExtensionsBridge.registerBridges(
      d4rt,
      'lib/test_extensions.dart',
    );
    path_bridges.PathBridge.registerBridges(
      d4rt,
      'package:path/path.dart',
    );
    dcli_bridges.DcliBridge.registerBridges(
      d4rt,
      'package:dcli/dcli.dart',
    );
    dcli_bridges.DcliBridge.registerBridges(
      d4rt,
      'package:dcli_core/dcli_core.dart',
    );
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(core_extensions_bridges.CoreExtensionsBridge.getImportBlock());
    buffer.writeln(path_bridges.PathBridge.getImportBlock());
    buffer.writeln(dcli_bridges.DcliBridge.getImportBlock());
    return buffer.toString();
  }
}
