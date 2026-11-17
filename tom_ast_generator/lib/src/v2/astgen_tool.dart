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
    description:
        'With --list, show buildkit.yaml configuration for each project',
  ),
  OptionDefinition.flag(
    name: 'resolve',
    description:
        'Resolve each entrypoint with the analyzer first; a file with an '
        'analyzer error is reported and not converted, and the run fails',
  ),
  OptionDefinition.option(
    name: 'dart-sdk',
    valueName: 'path',
    description:
        'With --resolve, the Dart SDK to analyze against (default: DART_SDK, '
        'else the dart or flutter on PATH)',
  ),
  OptionDefinition.option(
    name: 'stubs',
    valueName: 'folder',
    description:
        'With --resolve, a folder of declaration stubs for libraries that '
        'exist only at run time: <folder>/<package>/<path> declares '
        'package:<package>/<path>. Never converted or bundled',
  ),
  OptionDefinition.multi(
    name: 'runtime-library',
    valueName: 'uri',
    description:
        'With --resolve, a library that exists only at run time (bridged or '
        'registered by the host); an import of it without source or stub, and '
        'the names it would supply, are not reported but counted',
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
  versionString: 'AST Generator ${AstgenVersionInfo.versionLong}',
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
