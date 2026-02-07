// D4rt Bridge - Generated file, do not edit
// Dartscript registration for tom_d4rt_dcli
// Generated: 2026-02-07T07:43:04.198024

/// D4rt Bridge Registration for tom_d4rt_dcli
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/bridges/cli_api_bridges.b.dart' as cli_api_bridges;
import 'src/bridges/tom_vscode_scripting_api_bridges.b.dart' as tom_vscode_scripting_api_bridges;
import 'src/bridges/dcli_bridges.b.dart' as dcli_bridges;

/// Combined bridge registration for tom_d4rt_dcli.
class TomD4rtDcliBridge {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    cli_api_bridges.CliApiBridge.registerBridges(
      d4rt,
      'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart',
    );
    tom_vscode_scripting_api_bridges.TomVscodeScriptingApiBridge.registerBridges(
      d4rt,
      'package:tom_vscode_scripting_api/script_globals.dart',
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
    buffer.writeln(cli_api_bridges.CliApiBridge.getImportBlock());
    buffer.writeln(tom_vscode_scripting_api_bridges.TomVscodeScriptingApiBridge.getImportBlock());
    buffer.writeln(dcli_bridges.DcliBridge.getImportBlock());
    return buffer.toString();
  }
}
