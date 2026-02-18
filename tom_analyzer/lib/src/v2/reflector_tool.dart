/// Tom Reflector v2 — Tool definition using tom_build_base v2.
library;

import 'package:tom_build_base/tom_build_base_v2.dart';

import '../version.versioner.dart';

// =============================================================================
// Tool-specific Options
// =============================================================================

/// Tool-specific options for tom_reflector.
const reflectorOptions = <OptionDefinition>[
  OptionDefinition.multi(
    name: 'entry',
    abbr: 'e',
    description: 'Entry point file(s) to analyze (can repeat, comma-separated)',
    valueName: 'file',
  ),
  OptionDefinition.option(
    name: 'barrel',
    description: 'Barrel file (legacy mode)',
    valueName: 'path',
  ),
  OptionDefinition.option(
    name: 'output',
    description: 'Output file path',
    valueName: 'path',
  ),
];

// =============================================================================
// Tool Definition
// =============================================================================

/// Tom Reflector tool definition.
final reflectorTool = ToolDefinition(
  name: 'tom_reflector',
  description: 'Dart code reflection generation tool',
  version: AnalyzerVersionInfo.version,
  mode: ToolMode.singleCommand,
  features: const NavigationFeatures(
    projectTraversal: true,
    gitTraversal: false,
    recursiveScan: true,
    interactiveMode: false,
    dryRun: false,
    jsonOutput: false,
    verbose: true,
  ),
  globalOptions: reflectorOptions,
  helpFooter: '''
Configuration:
  Reads from buildkit.yaml file with the following structure:

  tom_reflector:
    barrels:
      - lib/my_package.dart

Related:
  For code analysis, use tom_analyzer:
    dart run tom_analyzer --help
''',
);
