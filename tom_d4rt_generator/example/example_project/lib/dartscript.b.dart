// D4rt Bridge - Generated file, do not edit
// Dartscript registration for d4rt_generator_example
// Generated: 2026-09-17T23:04:08.452886 by tom_d4rt_generator 1.26.2

/// D4rt Bridge Registration for d4rt_generator_example
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/example_bridges.b.dart' as all_bridges;
import 'src/d4rt_bridges/relaxers.b.dart' as relaxer_factories;

/// Combined bridge registration for d4rt_generator_example.
class D4rtGeneratorExampleBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    all_bridges.AllBridge.registerBridges(
      d4rt,
      'package:d4rt_generator_example/test_classes.dart',
    );
    all_bridges.AllBridge.registerBridges(
      d4rt,
      'lib/test_classes.dart',
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
