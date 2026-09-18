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
  // SCE51: on by default. scd13_ahcm shipped it opt-in and said not to choose
  // the default before the semantics had been exercised on real consumers.
  // The sweep that followed ran every d4rtgen consumer in the workspace — all
  // 13 verified clean — and measured the cost warm-to-warm on the largest of
  // them at 52.2s against 52.4s unverified. Generation parses with the
  // analyzer already, so the summary cache the verify step needs is warm by
  // the time it runs.
  //
  // A gate nobody enables is not a gate, and the population it was built for —
  // a consumer regenerating bridges who has never heard of the flag — is
  // exactly the one that would not pass it. The objection that made default-on
  // risky is gone by construction: every diagnostic is scoped to the files the
  // run just wrote, so a consumer's own pre-existing problems cannot fail its
  // regeneration.
  OptionDefinition.flag(
    name: 'verify-output',
    description:
        'After generating, run dart analyze over the generated files and fail '
        'on any error',
    defaultValue: 'true',
    negatable: true,
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
  versionString: 'D4rt Bridge Generator ${D4rtGenVersionInfo.versionLong}',
  mode: ToolMode.singleCommand,
  worksWithNatures: {DartProjectFolder},
  features: const NavigationFeatures(
    projectTraversal: true,
    gitTraversal: false,
    recursiveScan: true,
    interactiveMode: false,
    // Honoured by the executor: generation runs into a scratch tree and the
    // run reports what it would write (see `_dryRun`).
    dryRun: true,
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
