// D4rt Bridge - Generated file, do not edit
// Dartscript registration for d4rt_generator_example
<<<<<<< Updated upstream
// Generated: 2026-02-14T00:51:09.158721
=======
// Generated: 2026-03-12T17:02:52.824804
>>>>>>> Stashed changes

/// D4rt Bridge Registration for d4rt_generator_example
library;

<<<<<<< Updated upstream
import 'package:tom_d4rt_exec/d4rt.dart';
import 'src/d4rt_bridges/example_bridges.b.dart' as all_bridges;
=======
import 'package:tom_d4rt/d4rt.dart';
import 'src\d4rt_bridges\example_bridges.b.dart' as all_bridges;
>>>>>>> Stashed changes

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
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(all_bridges.AllBridge.getImportBlock());
    return buffer.toString();
  }
}
