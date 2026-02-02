// D4rt Bridge - Generated file, do not edit
// Delegating barrel for dcli
// Generated: 2026-02-01T21:32:38.540772

// ignore_for_file: unused_import

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import '../d4rt_library_bridges/package_crypto_bridges.dart' as pkg_crypto;
import '../d4rt_library_bridges/package_dcli_bridges.dart' as pkg_dcli;
import '../d4rt_library_bridges/package_dcli_core_bridges.dart' as pkg_dcli_core;
import '../d4rt_library_bridges/package_dcli_terminal_bridges.dart' as pkg_dcli_terminal;

/// Bridge class for dcli module.
class DcliBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      ...pkg_crypto.PackageCryptoBridge.bridgeClasses(),
      ...pkg_dcli.PackageDcliBridge.bridgeClasses(),
      ...pkg_dcli_core.PackageDcliCoreBridge.bridgeClasses(),
      ...pkg_dcli_terminal.PackageDcliTerminalBridge.bridgeClasses(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      ...pkg_crypto.PackageCryptoBridge.classSourceUris(),
      ...pkg_dcli.PackageDcliBridge.classSourceUris(),
      ...pkg_dcli_core.PackageDcliCoreBridge.classSourceUris(),
      ...pkg_dcli_terminal.PackageDcliTerminalBridge.classSourceUris(),
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      ...pkg_crypto.PackageCryptoBridge.bridgedEnums(),
      ...pkg_dcli.PackageDcliBridge.bridgedEnums(),
      ...pkg_dcli_core.PackageDcliCoreBridge.bridgedEnums(),
      ...pkg_dcli_terminal.PackageDcliTerminalBridge.bridgedEnums(),
    ];
  }

  /// Returns all global functions.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      ...pkg_crypto.PackageCryptoBridge.globalFunctions(),
      ...pkg_dcli.PackageDcliBridge.globalFunctions(),
      ...pkg_dcli_core.PackageDcliCoreBridge.globalFunctions(),
      ...pkg_dcli_terminal.PackageDcliTerminalBridge.globalFunctions(),
    };
  }

  /// Register all bridges with the interpreter.
  static void registerBridges(D4rt interpreter, String importPath) {
    pkg_crypto.PackageCryptoBridge.registerBridges(interpreter, importPath);
    pkg_dcli.PackageDcliBridge.registerBridges(interpreter, importPath);
    pkg_dcli_core.PackageDcliCoreBridge.registerBridges(interpreter, importPath);
    pkg_dcli_terminal.PackageDcliTerminalBridge.registerBridges(interpreter, importPath);
  }

  /// Returns the import block for scripts.
  static String getImportBlock() {
    return "import 'package:dcli/dcli.dart';\n";
  }
}
