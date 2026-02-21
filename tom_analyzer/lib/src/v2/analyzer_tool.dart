/// Tom Analyzer v2 — Tool definition using tom_build_base v2.
library;

import 'package:tom_build_base/tom_build_base_v2.dart';

import '../version.versioner.dart';

// =============================================================================
// Tool-specific Options
// =============================================================================

/// Tool-specific options for tom_analyzer.
const analyzerOptions = <OptionDefinition>[
  OptionDefinition.option(
    name: 'barrel',
    description: 'Barrel file to analyze (overrides config)',
    valueName: 'path',
  ),
  OptionDefinition.option(
    name: 'output',
    description: 'Output file path',
    valueName: 'path',
  ),
  OptionDefinition.option(
    name: 'format',
    abbr: 'f',
    description: 'Output format: yaml or json (default: yaml)',
    valueName: 'fmt',
  ),
];

// =============================================================================
// Tool Definition
// =============================================================================

/// Tom Analyzer tool definition.
final analyzerTool = ToolDefinition(
  name: 'tom_analyzer',
  description: 'Dart code analysis tool',
  version: AnalyzerVersionInfo.version,
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
  globalOptions: analyzerOptions,
  helpFooter: '''
Configuration:
  Reads from buildkit.yaml file with the following structure:

  tom_analyzer:
    barrels:
      - lib/my_package.dart
    output_format: yaml

Related:
  For reflection generation, use tom_reflector:
    dart run tom_analyzer:tom_reflector --help
''',
);
