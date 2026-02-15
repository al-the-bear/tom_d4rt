// D4rt Bridge - Generated file, do not edit
// Dartscript registration for tom_d4rt_dcli
// Generated: 2026-02-15T00:34:22.471073

/// D4rt Bridge Registration for tom_d4rt_dcli
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/bridges/cli_api_bridges.b.dart' as cli_api_bridges;
import 'src/bridges/tom_vscode_scripting_api_bridges.b.dart' as tom_vscode_scripting_api_bridges;
import 'src/bridges/dcli_bridges.b.dart' as dcli_bridges;
import 'src/bridges/dcli_missing_bridges.dart' as dcli_missing;
import 'src/bridges/path_bridges.b.dart' as path_bridges;
import 'src/bridges/tom_chattools_bridges.b.dart' as tom_chattools_bridges;

/// Combined bridge registration for tom_d4rt_dcli.
class TomD4rtDcliBridge {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    cli_api_bridges.CliApiBridge.registerBridges(
      d4rt,
      'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in cli_api_bridges.CliApiBridge.subPackageBarrels()) {
      cli_api_bridges.CliApiBridge.registerBridges(d4rt, barrel);
    }
    tom_vscode_scripting_api_bridges.TomVscodeScriptingApiBridge.registerBridges(
      d4rt,
      'package:tom_vscode_scripting_api/script_globals.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in tom_vscode_scripting_api_bridges.TomVscodeScriptingApiBridge.subPackageBarrels()) {
      tom_vscode_scripting_api_bridges.TomVscodeScriptingApiBridge.registerBridges(d4rt, barrel);
    }
    dcli_bridges.DcliBridge.registerBridges(
      d4rt,
      'package:dcli/dcli.dart',
    );
    // Register missing dcli bridges (lastModified, setLastModifed, symlink, Find)
    dcli_missing.DcliMissingBridges.register(d4rt, 'package:dcli/dcli.dart');
    // Register under sub-package barrels for direct imports
    for (final barrel in dcli_bridges.DcliBridge.subPackageBarrels()) {
      dcli_bridges.DcliBridge.registerBridges(d4rt, barrel);
      dcli_missing.DcliMissingBridges.register(d4rt, barrel);
    }
    path_bridges.PathBridge.registerBridges(
      d4rt,
      'package:path/path.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in path_bridges.PathBridge.subPackageBarrels()) {
      path_bridges.PathBridge.registerBridges(d4rt, barrel);
    }
    tom_chattools_bridges.TomChattoolsBridge.registerBridges(
      d4rt,
      'package:tom_chattools/tom_chattools.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in tom_chattools_bridges.TomChattoolsBridge.subPackageBarrels()) {
      tom_chattools_bridges.TomChattoolsBridge.registerBridges(d4rt, barrel);
    }
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(cli_api_bridges.CliApiBridge.getImportBlock());
    buffer.writeln(tom_vscode_scripting_api_bridges.TomVscodeScriptingApiBridge.getImportBlock());
    buffer.writeln(dcli_bridges.DcliBridge.getImportBlock());
    buffer.writeln(path_bridges.PathBridge.getImportBlock());
    buffer.writeln(tom_chattools_bridges.TomChattoolsBridge.getImportBlock());
    return buffer.toString();
  }
}
