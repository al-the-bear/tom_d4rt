// D4rt Bridge - Generated file, do not edit
// Dartscript registration for tom_dartscript_bridges
// Generated: 2026-02-15T00:34:41.796100

/// D4rt Bridge Registration for tom_dartscript_bridges
library;

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt_dcli/dartscript.b.dart' as imported_0;
import 'src/tom_basics/tom_basics_bridges.b.dart' as tom_basics_bridges;
import 'src/tom_reflection/tom_reflection_bridges.b.dart' as tom_reflection_bridges;
import 'src/tom_process_monitor/tom_process_monitor_bridges.b.dart' as tom_process_monitor_bridges;
import 'src/tom_core_kernel/tom_core_kernel_bridges.b.dart' as tom_core_kernel_bridges;
import 'src/tom_build/tom_build_bridges.b.dart' as tom_build_bridges;
import 'src/tom_core_server/tom_core_server_bridges.b.dart' as tom_core_server_bridges;
import 'src/tom_dist_ledger/tom_dist_ledger_bridges.b.dart' as tom_dist_ledger_bridges;

/// Combined bridge registration for tom_dartscript_bridges.
class TomDartscriptBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    // Register imported bridges
    imported_0.TomD4rtDcliBridge.register(d4rt);

    // Register local bridges
    tom_basics_bridges.TomBasicsBridge.registerBridges(
      d4rt,
      'package:tom_basics/tom_basics.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in tom_basics_bridges.TomBasicsBridge.subPackageBarrels()) {
      tom_basics_bridges.TomBasicsBridge.registerBridges(d4rt, barrel);
    }
    tom_reflection_bridges.TomReflectionBridge.registerBridges(
      d4rt,
      'package:tom_reflection/tom_reflection.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in tom_reflection_bridges.TomReflectionBridge.subPackageBarrels()) {
      tom_reflection_bridges.TomReflectionBridge.registerBridges(d4rt, barrel);
    }
    tom_process_monitor_bridges.TomProcessMonitorBridge.registerBridges(
      d4rt,
      'package:tom_process_monitor/tom_process_monitor.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in tom_process_monitor_bridges.TomProcessMonitorBridge.subPackageBarrels()) {
      tom_process_monitor_bridges.TomProcessMonitorBridge.registerBridges(d4rt, barrel);
    }
    tom_core_kernel_bridges.TomCoreKernelBridge.registerBridges(
      d4rt,
      'package:tom_core_kernel/tom_core_kernel.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in tom_core_kernel_bridges.TomCoreKernelBridge.subPackageBarrels()) {
      tom_core_kernel_bridges.TomCoreKernelBridge.registerBridges(d4rt, barrel);
    }
    tom_build_bridges.TomBuildBridge.registerBridges(
      d4rt,
      'package:tom_build/tom_build.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in tom_build_bridges.TomBuildBridge.subPackageBarrels()) {
      tom_build_bridges.TomBuildBridge.registerBridges(d4rt, barrel);
    }
    tom_core_server_bridges.TomCoreServerBridge.registerBridges(
      d4rt,
      'package:tom_core_server/tom_core_server.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in tom_core_server_bridges.TomCoreServerBridge.subPackageBarrels()) {
      tom_core_server_bridges.TomCoreServerBridge.registerBridges(d4rt, barrel);
    }
    tom_dist_ledger_bridges.TomDistLedgerBridge.registerBridges(
      d4rt,
      'package:tom_dist_ledger/tom_dist_ledger.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in tom_dist_ledger_bridges.TomDistLedgerBridge.subPackageBarrels()) {
      tom_dist_ledger_bridges.TomDistLedgerBridge.registerBridges(d4rt, barrel);
    }
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(imported_0.TomD4rtDcliBridge.getImportBlock());
    buffer.writeln(tom_basics_bridges.TomBasicsBridge.getImportBlock());
    buffer.writeln(tom_reflection_bridges.TomReflectionBridge.getImportBlock());
    buffer.writeln(tom_process_monitor_bridges.TomProcessMonitorBridge.getImportBlock());
    buffer.writeln(tom_core_kernel_bridges.TomCoreKernelBridge.getImportBlock());
    buffer.writeln(tom_build_bridges.TomBuildBridge.getImportBlock());
    buffer.writeln(tom_core_server_bridges.TomCoreServerBridge.getImportBlock());
    buffer.writeln(tom_dist_ledger_bridges.TomDistLedgerBridge.getImportBlock());
    return buffer.toString();
  }
}
