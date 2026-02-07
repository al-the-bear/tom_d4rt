// D4rt Bridge - Generated file, do not edit
// Delegating barrel for cli_api
// Generated: 2026-02-07T13:11:16.963963

// ignore_for_file: unused_import, deprecated_member_use

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import '../d4rt_library_bridges/package_tom_d4rt_dcli_bridges.b.dart' as pkg_tom_d4rt_dcli;

/// Bridge class for cli_api module.
class CliApiBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      ...pkg_tom_d4rt_dcli.PackageTomD4rtDcliBridge.bridgeClasses(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      ...pkg_tom_d4rt_dcli.PackageTomD4rtDcliBridge.classSourceUris(),
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      ...pkg_tom_d4rt_dcli.PackageTomD4rtDcliBridge.bridgedEnums(),
    ];
  }

  /// Returns all global functions.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      ...pkg_tom_d4rt_dcli.PackageTomD4rtDcliBridge.globalFunctions(),
    };
  }

  /// Register all bridges with the interpreter.
  static void registerBridges(D4rt interpreter, String importPath) {
    pkg_tom_d4rt_dcli.PackageTomD4rtDcliBridge.registerBridges(interpreter, importPath);
  }

  /// Returns the import block for scripts.
  static String getImportBlock() {
    return "import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';\n";
  }
}
