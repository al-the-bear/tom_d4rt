/// D4rtgen v2 — Tool definition using tom_build_base v2.
library;

import 'package:tom_build_base/tom_build_base_v2.dart';

import '../version.versioner.dart';

// =============================================================================
// Tool-specific Options
// =============================================================================

/// Tool-specific options for d4rtgen.
const d4rtgenOptions = <OptionDefinition>[
  OptionDefinition.flag(
    name: 'show',
    description:
        'With --list, show buildkit.yaml d4rtgen configuration for each project',
  ),
  OptionDefinition.flag(
    name: 'dump-config',
    description: 'Print effective merged configuration as JSON (no action)',
  ),
];

// =============================================================================
// Tool Definition
// =============================================================================

/// D4rtgen tool definition.
final d4rtgenTool = ToolDefinition(
  name: 'd4rtgen',
  description: 'Generates D4rt bridges from configuration files',
  version: D4rtGenVersionInfo.versionShort,
  mode: ToolMode.singleCommand,
  worksWithNatures: {DartProjectFolder},
  features: const NavigationFeatures(
    projectTraversal: true,
    gitTraversal: false,
    recursiveScan: true,
    interactiveMode: false,
    dryRun: false,
    jsonOutput: false,
    verbose: true,
  ),
  globalOptions: d4rtgenOptions,
  helpFooter: '''
Configuration File (buildkit.yaml):
  Each project must have a buildkit.yaml file with a d4rtgen: section.

    # buildkit.yaml
    d4rtgen:
      name: my_project
      helpersImport: package:tom_d4rt/tom_d4rt.dart
      generateBarrel: true
      barrelPath: lib/d4rt_bridges.b.dart
      modules:
        - name: my_module
          barrelFiles:
            - package:my_project/my_module.dart
          outputPath: lib/src/bridges/my_module_bridges.b.dart

Project Detection:
  A D4rt project is a directory with:
    - pubspec.yaml, AND
    - buildkit.yaml with a d4rtgen: section
''',
);
