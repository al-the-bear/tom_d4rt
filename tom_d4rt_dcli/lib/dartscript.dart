/// D4rt Bridge Registration for tom_d4rt_dcli
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/bridges/dcli_bridges.dart' as dcli_bridges;

/// Combined bridge registration for tom_d4rt_dcli.
class TomD4rtDcliBridge {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    dcli_bridges.DcliBridge.registerBridges(
      d4rt,
      'package:dcli/dcli.dart',
    );
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(dcli_bridges.DcliBridge.getImportBlock());
    return buffer.toString();
  }
}
