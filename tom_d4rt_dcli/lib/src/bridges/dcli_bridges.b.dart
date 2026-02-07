// D4rt Bridge - Generated file, do not edit
// Delegating barrel for dcli
// Generated: 2026-02-07T08:37:01.017982

// ignore_for_file: unused_import, deprecated_member_use

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import '../d4rt_library_bridges/package_dcli_bridges.b.dart' as pkg_dcli;
import '../d4rt_library_bridges/package_dcli_core_bridges.b.dart' as pkg_dcli_core;

/// Bridge class for dcli module.
class DcliBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      ...pkg_dcli.PackageDcliBridge.bridgeClasses(),
      ...pkg_dcli_core.PackageDcliCoreBridge.bridgeClasses(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      ...pkg_dcli.PackageDcliBridge.classSourceUris(),
      ...pkg_dcli_core.PackageDcliCoreBridge.classSourceUris(),
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      ...pkg_dcli.PackageDcliBridge.bridgedEnums(),
      ...pkg_dcli_core.PackageDcliCoreBridge.bridgedEnums(),
    ];
  }

  /// Returns all global functions.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      ...pkg_dcli.PackageDcliBridge.globalFunctions(),
      ...pkg_dcli_core.PackageDcliCoreBridge.globalFunctions(),
    };
  }

  /// Register all bridges with the interpreter.
  static void registerBridges(D4rt interpreter, String importPath) {
    pkg_dcli.PackageDcliBridge.registerBridges(interpreter, importPath);
    pkg_dcli_core.PackageDcliCoreBridge.registerBridges(interpreter, importPath);
  }

  /// Returns the import block for scripts.
  static String getImportBlock() {
    return "import 'package:dcli/dcli.dart';\n";
  }
}
