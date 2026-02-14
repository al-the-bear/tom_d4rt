// D4rt Bridge - Generated file, do not edit
// Dartscript registration for d4_example
// Generated: 2026-02-14T08:38:32.855703

/// D4rt Bridge Registration for d4_example
library;

import 'package:tom_d4rt/d4rt.dart';
import 'src/d4rt_bridges/core_extensions.b.dart' as core_extensions_bridges;
import 'src/d4rt_bridges/example_project.b.dart' as example_project_bridges;
import 'src/d4rt_bridges/user_guide.b.dart' as user_guide_bridges;
import 'src/d4rt_bridges/user_reference.b.dart' as user_reference_bridges;
import 'src/d4rt_bridges/userbridge_override.b.dart' as userbridge_override_bridges;
import 'src/d4rt_bridges/userbridge_user_guide.b.dart' as userbridge_user_guide_bridges;
import 'src/d4rt_bridges/dart_overview.b.dart' as dart_overview_bridges;
import 'src/d4rt_bridges/path_bridges.b.dart' as path_bridges;
import 'src/d4rt_bridges/dcli_bridges.b.dart' as dcli_bridges;

/// Combined bridge registration for d4_example.
class D4ExampleBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();

    core_extensions_bridges.CoreExtensionsBridge.registerBridges(
      d4rt,
      'package:d4_example/test_extensions.dart',
    );
    core_extensions_bridges.CoreExtensionsBridge.registerBridges(
      d4rt,
      'lib/test_extensions.dart',
    );
    example_project_bridges.ExampleProjectBridge.registerBridges(
      d4rt,
      'package:d4_example/example_project.dart',
    );
    example_project_bridges.ExampleProjectBridge.registerBridges(
      d4rt,
      'lib/example_project.dart',
    );
    user_guide_bridges.UserGuideBridge.registerBridges(
      d4rt,
      'package:d4_example/user_guide.dart',
    );
    user_guide_bridges.UserGuideBridge.registerBridges(
      d4rt,
      'lib/user_guide.dart',
    );
    user_reference_bridges.UserReferenceBridge.registerBridges(
      d4rt,
      'package:d4_example/user_reference.dart',
    );
    user_reference_bridges.UserReferenceBridge.registerBridges(
      d4rt,
      'lib/user_reference.dart',
    );
    userbridge_override_bridges.UserbridgeOverrideBridge.registerBridges(
      d4rt,
      'package:d4_example/userbridge_override.dart',
    );
    userbridge_override_bridges.UserbridgeOverrideBridge.registerBridges(
      d4rt,
      'lib/userbridge_override.dart',
    );
    userbridge_user_guide_bridges.UserbridgeUserGuideBridge.registerBridges(
      d4rt,
      'package:d4_example/userbridge_user_guide.dart',
    );
    userbridge_user_guide_bridges.UserbridgeUserGuideBridge.registerBridges(
      d4rt,
      'lib/userbridge_user_guide.dart',
    );
    dart_overview_bridges.DartOverviewBridge.registerBridges(
      d4rt,
      'package:d4_example/dart_overview.dart',
    );
    dart_overview_bridges.DartOverviewBridge.registerBridges(
      d4rt,
      'lib/dart_overview.dart',
    );
    path_bridges.PathBridge.registerBridges(
      d4rt,
      'package:path/path.dart',
    );
    dcli_bridges.DcliBridge.registerBridges(
      d4rt,
      'package:dcli/dcli.dart',
    );
  }

  /// Get import block for all modules.
  static String getImportBlock() {
    final buffer = StringBuffer();
    buffer.writeln(core_extensions_bridges.CoreExtensionsBridge.getImportBlock());
    buffer.writeln(example_project_bridges.ExampleProjectBridge.getImportBlock());
    buffer.writeln(user_guide_bridges.UserGuideBridge.getImportBlock());
    buffer.writeln(user_reference_bridges.UserReferenceBridge.getImportBlock());
    buffer.writeln(userbridge_override_bridges.UserbridgeOverrideBridge.getImportBlock());
    buffer.writeln(userbridge_user_guide_bridges.UserbridgeUserGuideBridge.getImportBlock());
    buffer.writeln(dart_overview_bridges.DartOverviewBridge.getImportBlock());
    buffer.writeln(path_bridges.PathBridge.getImportBlock());
    buffer.writeln(dcli_bridges.DcliBridge.getImportBlock());
    return buffer.toString();
  }
}
