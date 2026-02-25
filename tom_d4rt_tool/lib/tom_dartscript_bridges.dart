/// Tom DartScript Bridges
///
/// Consolidated barrel export for all D4rt bridges and their source packages.
/// Import this file to get access to all bridged classes and the registration
/// class for D4rt interpreter setup.
///
/// ## Usage
///
/// ```dart
/// import 'package:tom_dartscript_bridges/tom_dartscript_bridges.dart';
///
/// void main() {
///   final interpreter = D4rt();
///   TomDartscriptBridges.register(interpreter);
///   // Now all bridges are registered
/// }
/// ```
library;

// Bridge registration
export 'dartscript.b.dart';

// CLI entry point
export 'src/cli/d4rt_repl.dart';

// D4rt runtime and base REPL
export 'package:tom_d4rt/tom_d4rt.dart';
export 'package:tom_d4rt_dcli/tom_d4rt_dcli.dart';

// Source packages - re-export main barrels so consumers don't need direct deps
export 'package:tom_core_kernel/tom_core_kernel.dart';
export 'package:tom_core_server/tom_core_server.dart';
export 'package:tom_build/tom_build.dart';
export 'package:tom_dist_ledger/tom_dist_ledger.dart';
export 'package:tom_process_monitor/tom_process_monitor.dart';
