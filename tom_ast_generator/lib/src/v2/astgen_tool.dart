/// Astgen v2 — Tool definition using tom_build_base v2.
library;

import 'package:tom_build_base/tom_build_base_v2.dart';

import '../version.versioner.dart';

// =============================================================================
// Tool-specific Options
// =============================================================================

/// Tool-specific options for astgen.
const astgenOptions = <OptionDefinition>[
  OptionDefinition.flag(
    name: 'show',
    description: 'With --list, show buildkit.yaml configuration for each project',
  ),
];

// =============================================================================
// Tool Definition
// =============================================================================

/// Astgen tool definition.
final astgenTool = ToolDefinition(
  name: 'astgen',
  description: 'Converts Dart source files to serialized AST YAML files',
  version: AstgenVersionInfo.version,
  mode: ToolMode.singleCommand,
  worksWithNatures: {DartProjectFolder},
  features: const NavigationFeatures(
    projectTraversal: true,
    gitTraversal: false,
    recursiveScan: true,
    interactiveMode: false,
    dryRun: true,
    jsonOutput: false,
    verbose: true,
  ),
  globalOptions: astgenOptions,
  helpFooter: '''
Configuration:
  Reads from buildkit.yaml file with the following structure:

  astgen:
    convert:
      - entrypoints: lib/*.runner.dart
        output: project:tom_runtime/asset
        root: .

Output:
  Generated files have the extension .ast.yaml
  Example: my_tool.dart -> my_tool.ast.yaml

Documentation:
  See doc/astgen_build_yaml.md for full configuration options
''',
);
