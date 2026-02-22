// D4rt Bridge - Generated file, do not edit
// Dartscript registration for d4_example
// Generated: 2026-02-21T15:07:57.982

/// D4rt Bridge Registration for d4_example
library;

import 'package:tom_d4rt_exec/d4rt.dart';
import 'src/d4rt_bridges/core_extensions.b.dart' as core_extensions_bridges;
import 'src/d4rt_bridges/example_project.b.dart' as example_project_bridges;
import 'src/d4rt_bridges/user_guide.b.dart' as user_guide_bridges;
import 'src/d4rt_bridges/user_reference.b.dart' as user_reference_bridges;
import 'src/d4rt_bridges/userbridge_override.b.dart' as userbridge_override_bridges;
import 'src/d4rt_bridges/userbridge_user_guide.b.dart' as userbridge_user_guide_bridges;
import 'src/d4rt_bridges/dart_overview.b.dart' as dart_overview_bridges;
import 'src/d4rt_bridges/path_bridges.b.dart' as path_bridges;
import 'src/d4rt_bridges/dcli_bridges.b.dart' as dcli_bridges;
import 'src/d4rt_bridges/test_part_of_files.b.dart' as test_part_of_files_bridges;
import 'src/d4rt_bridges/test_callback_types.b.dart' as test_callback_types_bridges;

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
    // Register under sub-package barrels for direct imports
    for (final barrel in core_extensions_bridges.CoreExtensionsBridge.subPackageBarrels()) {
      core_extensions_bridges.CoreExtensionsBridge.registerBridges(d4rt, barrel);
    }
    example_project_bridges.ExampleProjectBridge.registerBridges(
      d4rt,
      'package:d4_example/example_project.dart',
    );
    example_project_bridges.ExampleProjectBridge.registerBridges(
      d4rt,
      'lib/example_project.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in example_project_bridges.ExampleProjectBridge.subPackageBarrels()) {
      example_project_bridges.ExampleProjectBridge.registerBridges(d4rt, barrel);
    }
    user_guide_bridges.UserGuideBridge.registerBridges(
      d4rt,
      'package:d4_example/user_guide.dart',
    );
    user_guide_bridges.UserGuideBridge.registerBridges(
      d4rt,
      'lib/user_guide.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in user_guide_bridges.UserGuideBridge.subPackageBarrels()) {
      user_guide_bridges.UserGuideBridge.registerBridges(d4rt, barrel);
    }
    user_reference_bridges.UserReferenceBridge.registerBridges(
      d4rt,
      'package:d4_example/user_reference.dart',
    );
    user_reference_bridges.UserReferenceBridge.registerBridges(
      d4rt,
      'lib/user_reference.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in user_reference_bridges.UserReferenceBridge.subPackageBarrels()) {
      user_reference_bridges.UserReferenceBridge.registerBridges(d4rt, barrel);
    }
    userbridge_override_bridges.UserbridgeOverrideBridge.registerBridges(
      d4rt,
      'package:d4_example/userbridge_override.dart',
    );
    userbridge_override_bridges.UserbridgeOverrideBridge.registerBridges(
      d4rt,
      'lib/userbridge_override.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in userbridge_override_bridges.UserbridgeOverrideBridge.subPackageBarrels()) {
      userbridge_override_bridges.UserbridgeOverrideBridge.registerBridges(d4rt, barrel);
    }
    userbridge_user_guide_bridges.UserbridgeUserGuideBridge.registerBridges(
      d4rt,
      'package:d4_example/userbridge_user_guide.dart',
    );
    userbridge_user_guide_bridges.UserbridgeUserGuideBridge.registerBridges(
      d4rt,
      'lib/userbridge_user_guide.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in userbridge_user_guide_bridges.UserbridgeUserGuideBridge.subPackageBarrels()) {
      userbridge_user_guide_bridges.UserbridgeUserGuideBridge.registerBridges(d4rt, barrel);
    }
    dart_overview_bridges.DartOverviewBridge.registerBridges(
      d4rt,
      'package:d4_example/dart_overview.dart',
    );
    dart_overview_bridges.DartOverviewBridge.registerBridges(
      d4rt,
      'lib/dart_overview.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in dart_overview_bridges.DartOverviewBridge.subPackageBarrels()) {
      dart_overview_bridges.DartOverviewBridge.registerBridges(d4rt, barrel);
    }
    path_bridges.PathBridge.registerBridges(
      d4rt,
      'package:path/path.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in path_bridges.PathBridge.subPackageBarrels()) {
      path_bridges.PathBridge.registerBridges(d4rt, barrel);
    }
    dcli_bridges.DcliBridge.registerBridges(
      d4rt,
      'package:dcli/dcli.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in dcli_bridges.DcliBridge.subPackageBarrels()) {
      dcli_bridges.DcliBridge.registerBridges(d4rt, barrel);
    }
    test_part_of_files_bridges.TestPartOfFilesBridge.registerBridges(
      d4rt,
      'package:d4_example/test_part_of_files.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in test_part_of_files_bridges.TestPartOfFilesBridge.subPackageBarrels()) {
      test_part_of_files_bridges.TestPartOfFilesBridge.registerBridges(d4rt, barrel);
    }
    test_callback_types_bridges.TestCallbackTypesBridge.registerBridges(
      d4rt,
      'package:d4_example/test_callback_types.dart',
    );
    // Register under sub-package barrels for direct imports
    for (final barrel in test_callback_types_bridges.TestCallbackTypesBridge.subPackageBarrels()) {
      test_callback_types_bridges.TestCallbackTypesBridge.registerBridges(d4rt, barrel);
    }
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
    buffer.writeln(test_part_of_files_bridges.TestPartOfFilesBridge.getImportBlock());
    buffer.writeln(test_callback_types_bridges.TestCallbackTypesBridge.getImportBlock());
    return buffer.toString();
  }
}
