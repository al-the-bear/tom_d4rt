/// D4rtgen v2 — Command executor.
///
/// Wraps the existing bridge generation logic to work with the v2
/// ToolRunner framework.
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import '../verification/generated_output_analysis.dart';
import 'package:tom_build_base/tom_build_base.dart'
    show TomBuildConfig, hasTomBuildConfig, findWorkspaceRoot;
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:tom_d4rt_generator/src/build_config_loader.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';
import 'package:yaml/yaml.dart';

const _toolKey = 'd4rtgen';

// =============================================================================
// D4rtgen Executor
// =============================================================================

/// Default executor for the d4rtgen tool (single-command).
class D4rtgenExecutor extends CommandExecutor {
  @override
  Future<ItemResult> execute(CommandContext context, CliArgs args) async {
    // Skip projects without d4rtgen config
    if (!hasTomBuildConfig(context.path, _toolKey)) {
      return ItemResult.success(path: context.path, name: context.name);
    }

    // Handle --list mode
    if (args.listOnly) {
      final workspaceRoot = findWorkspaceRoot(context.executionRoot);
      final relativePath = p.relative(context.path, from: workspaceRoot);
      print('  $relativePath');

      if (args.extraOptions['show'] == true) {
        _printBuildYamlSection(context.path, workspaceRoot);
      }
      return ItemResult.success(path: context.path, name: context.name);
    }

    // Handle --dump-config mode
    if (args.dumpConfig) {
      final workspaceRoot = findWorkspaceRoot(context.executionRoot);
      final relativePath = p.relative(context.path, from: workspaceRoot);
      print('# $relativePath');
      _printEffectiveConfig(context.path);
      print('');
      return ItemResult.success(path: context.path, name: context.name);
    }

    // `--dry-run` / `-n`: run the generation for real, into a scratch tree,
    // and report what it wrote. See [_dryRun].
    if (args.dryRun) return _dryRun(context, args);

    try {
      final written = await _processProjectDirect(
        context.path,
        verbose: args.verbose,
      );

      if (args.extraOptions['verify-output'] == true) {
        final failure = await _verifyOutput(context, written);
        if (failure != null) return failure;
      }

      return ItemResult.success(path: context.path, name: context.name);
    } catch (e, st) {
      stderr.writeln('Error processing ${context.path}: $e');
      if (args.verbose) stderr.writeln(st);
      return ItemResult.failure(
        path: context.path,
        name: context.name,
        error: '$e',
      );
    }
  }
}

/// `d4rtgen --verify-output`: analyse what was just written, and fail on it.
///
/// SCD13 (scd13_ahcm). GEN-121 gates the generator's own output inside its test
/// suite, which protects the generator but not a consumer: `tom_dist_ledger`
/// regenerating its bridges got no signal that the output was malformed,
/// because its `analysis_options.yaml` excludes the generated directory. Both
/// GEN-119 and GEN-120 shipped through that gap and were found by hand.
///
/// The severity policy is not defined here — it is
/// [verifyGeneratedOutput], shared with the GEN-121 gate, so the tool and the
/// test cannot disagree about what a bad emission is.
///
/// Returns null when the output is acceptable, or the failure to report.
Future<ItemResult?> _verifyOutput(
  CommandContext context,
  List<String> written,
) async {
  final workspaceRoot = findWorkspaceRoot(context.executionRoot);
  final label = p.relative(context.path, from: workspaceRoot);

  final OutputVerification verification;
  try {
    verification = await verifyGeneratedOutput(generatedFiles: written);
  } on AnalyzeInvocationException catch (e) {
    // A verification that could not run is not a pass. Say so.
    stderr.writeln('  VERIFY: could not analyse $label.\n$e');
    return ItemResult.failure(
      path: context.path,
      name: context.name,
      error: 'verify-output could not run dart analyze',
    );
  }

  print(verification.describe(label: label));
  if (verification.ok) return null;

  return ItemResult.failure(
    path: context.path,
    name: context.name,
    error:
        'verify-output: ${verification.fatal.length} analyzer problem(s) in '
        'generated files',
  );
}

/// `d4rtgen --dry-run`: every file a run would write, and how it differs from
/// what the project has — with nothing written.
///
/// SCD5 (scd5_ahcm): tom_build_base parses `-n` for every tool, and this
/// executor used to ignore it, so a dry run regenerated every `*.b.dart` in
/// place. Checking the flag at each of the generator's six write sites would
/// leave the next write site to be forgotten. Instead the ordinary generation
/// runs unchanged inside the scratch overlay ([previewGeneration]), which
/// catches every write wherever it is made, and the report is read off what
/// the overlay caught.
Future<ItemResult> _dryRun(CommandContext context, CliArgs args) async {
  final workspaceRoot = findWorkspaceRoot(context.executionRoot);
  final relativePath = p.relative(context.path, from: workspaceRoot);
  try {
    final preview = await previewGeneration(
      packageRoot: context.path,
      purpose: 'dry_run',
      generate: () =>
          _processProjectDirect(context.path, verbose: args.verbose),
    );
    final width = PreviewedChange.values
        .map((change) => change.label.length)
        .reduce((a, b) => a > b ? a : b);
    print(
      '[DRY RUN] $relativePath: a run would write '
      '${preview.writes.length} file(s); nothing was written.',
    );
    for (final write in preview.writes) {
      print('  ${write.change.label.padRight(width)}  ${write.path}');
    }

    // Files the package commits that this run does NOT write. A dry run that
    // lists only what it would write cannot show these, and that blindness is
    // how a package keeps generated output no generation produces any more.
    // Reported, never deleted: whether an orphan is dead output or a file
    // another tool owns is the reader's call.
    final scan = findOrphanedBridges(
      packageRoot: context.path,
      produced: preview.writes.map((w) => w.path),
    );
    if (scan.skipped != null) {
      print('  orphan scan skipped: ${scan.skipped}');
    } else if (scan.orphaned.isNotEmpty) {
      print(
        '  ${scan.orphaned.length} committed generated file(s) that no run '
        'writes; d4rtgen never deletes them:',
      );
      for (final orphan in scan.orphaned) {
        print('  ${'orphaned'.padRight(width)}  ${orphan.path}');
      }
    }
    return ItemResult.success(path: context.path, name: context.name);
  } catch (e, st) {
    stderr.writeln('Error processing ${context.path} (dry run): $e');
    if (args.verbose) stderr.writeln(st);
    return ItemResult.failure(
      path: context.path,
      name: context.name,
      error: '$e',
    );
  }
}

// =============================================================================
// Processing Logic (moved from bin/d4rtgen.dart)
// =============================================================================

/// Process a single project directory directly.
Future<List<String>> _processProjectDirect(
  String projectPath, {
  required bool verbose,
}) async {
  if (verbose) {
    print('Processing project: $projectPath');
  }

  // Load from buildkit.yaml d4rtgen: section
  final config = BuildConfigLoader.loadFromTomBuildYaml(projectPath);

  if (config != null) {
    if (verbose) {
      print('  Using configuration from buildkit.yaml');
    }
    // One pipeline. The CLI used to orchestrate generation itself, which is
    // how it drifted from `generateBridges` -- the pipeline every consumer's
    // freshness gate certifies committed bridges against. The executor now
    // contributes only CLI concerns (discovery, --list, --dump-config,
    // --dry-run, --verify-output, output) and delegates the generation.
    //
    // `runPubGet: false`: resolving the package is a write, and the CLI may be
    // inspecting a package rather than building it (--dry-run runs this same
    // path inside the scratch overlay). An unresolved package fails loudly
    // below instead.
    final result = await generateBridges(
      config: config,
      projectPath: projectPath,
      verbose: verbose,
      runPubGet: false,
    );
    for (final error in result.errors) {
      print('  ERROR: $error');
    }
    if (verbose) {
      print('  Complete');
      print('');
    }
    return result.outputFiles;
  }

  throw Exception(
    'No d4rtgen configuration found in $projectPath/buildkit.yaml',
  );
}

/// Print the effective merged configuration as JSON (--dump-config option).
void _printEffectiveConfig(String projectPath) {
  final config = BuildConfigLoader.loadFromTomBuildYaml(projectPath);

  if (config == null) {
    print('  (no d4rtgen configuration found)');
    return;
  }

  // Convert to JSON and pretty-print
  final jsonEncoder = JsonEncoder.withIndent('  ');
  final jsonString = jsonEncoder.convert(config.toJson());

  // Print with proper indentation
  for (final line in jsonString.split('\n')) {
    print(line);
  }
}

/// Print the buildkit.yaml d4rtgen section for a project (--show option).
void _printBuildYamlSection(String projectPath, String workspaceRoot) {
  final buildkitYamlPath = p.join(projectPath, TomBuildConfig.projectFilename);
  final buildkitYamlFile = File(buildkitYamlPath);

  if (!buildkitYamlFile.existsSync()) {
    print('    (no buildkit.yaml)');
    return;
  }

  try {
    final content = buildkitYamlFile.readAsStringSync();
    final rootYaml = loadYaml(content) as YamlMap?;
    if (rootYaml == null) {
      print('    (empty buildkit.yaml)');
      return;
    }

    final d4rtgenSection = rootYaml['d4rtgen'] as YamlMap?;
    if (d4rtgenSection == null) {
      print('    (no d4rtgen section in buildkit.yaml)');
      return;
    }

    // Print the d4rtgen section as YAML
    print('    d4rtgen:');
    _printYamlNode(d4rtgenSection, indent: 6);
  } catch (e) {
    print('    (error reading buildkit.yaml: $e)');
  }
}

/// Print a YAML node with proper indentation.
void _printYamlNode(dynamic node, {int indent = 0}) {
  final prefix = ' ' * indent;

  if (node is YamlMap) {
    for (final entry in node.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is YamlMap || value is YamlList) {
        print('$prefix$key:');
        _printYamlNode(value, indent: indent + 2);
      } else {
        print('$prefix$key: $value');
      }
    }
  } else if (node is YamlList) {
    for (final item in node) {
      if (item is YamlMap) {
        final entries = item.entries.toList();
        if (entries.isNotEmpty) {
          final first = entries.first;
          if (first.value is YamlMap || first.value is YamlList) {
            print('$prefix- ${first.key}:');
            _printYamlNode(first.value, indent: indent + 4);
          } else {
            print('$prefix- ${first.key}: ${first.value}');
          }
          for (var i = 1; i < entries.length; i++) {
            final entry = entries[i];
            if (entry.value is YamlMap || entry.value is YamlList) {
              print('$prefix  ${entry.key}:');
              _printYamlNode(entry.value, indent: indent + 4);
            } else {
              print('$prefix  ${entry.key}: ${entry.value}');
            }
          }
        }
      } else if (item is YamlList) {
        print('$prefix-');
        _printYamlNode(item, indent: indent + 2);
      } else {
        print('$prefix- $item');
      }
    }
  } else {
    print('$prefix$node');
  }
}

// =============================================================================
// Factory
// =============================================================================

/// Create executor map for the d4rtgen tool.
Map<String, CommandExecutor> createD4rtgenExecutors() {
  return {'default': D4rtgenExecutor()};
}
