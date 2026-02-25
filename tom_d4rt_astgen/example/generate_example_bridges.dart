#!/usr/bin/env dart
/// Generate bridges for all example projects.
///
/// This script runs the D4rt bridge generator CLI (`bin/d4rtgen.dart`) for
/// each example project that has a `buildkit.yaml` configuration file.
///
/// Usage:
///   dart run example/generate_example_bridges.dart
///   dart run example/generate_example_bridges.dart --verbose
///   dart run example/generate_example_bridges.dart --list
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// An example project with bridge generation configuration.
class ExampleBridgeConfig {
  final String name;
  final String directory;
  final String configFile;

  const ExampleBridgeConfig({
    required this.name,
    required this.directory,
    this.configFile = 'buildkit.yaml',
  });
}

/// All example projects that have bridge generation configs.
const exampleProjects = [
  ExampleBridgeConfig(
    name: 'User Guide',
    directory: 'example/user_guide',
  ),
  ExampleBridgeConfig(
    name: 'User Reference',
    directory: 'example/user_reference',
  ),
  ExampleBridgeConfig(
    name: 'UserBridge Override',
    directory: 'example/userbridge_override',
  ),
  ExampleBridgeConfig(
    name: 'Example Project',
    directory: 'example/example_project',
  ),
];

/// Result of generating bridges for one project.
class GenerationResult {
  final String project;
  final bool passed;
  final int exitCode;
  final String stdout;
  final String stderr;
  final Duration duration;

  const GenerationResult({
    required this.project,
    required this.passed,
    required this.exitCode,
    required this.stdout,
    required this.stderr,
    required this.duration,
  });
}

Future<void> main(List<String> args) async {
  final verbose = args.contains('--verbose') || args.contains('-v');
  final listOnly = args.contains('--list') || args.contains('-l');

  print('╔══════════════════════════════════════════════════════════════╗');
  print('║     D4rt Bridge Generator - Generate Example Bridges       ║');
  print('╚══════════════════════════════════════════════════════════════╝');
  print('');

  // Get the package root directory
  final scriptPath = Platform.script.toFilePath();
  final packageRoot = Directory(scriptPath).parent.parent.path;
  print('Package root: $packageRoot');
  print('');

  // Verify the generator CLI exists
  final generatorCli = p.join(packageRoot, 'bin', 'd4rtgen.dart');
  if (!File(generatorCli).existsSync()) {
    stderr.writeln('Error: Generator CLI not found at $generatorCli');
    exit(1);
  }

  // If --list, just show which projects would be processed
  if (listOnly) {
    print('Example projects with bridge configs:');
    for (final project in exampleProjects) {
      final configPath =
          p.join(packageRoot, project.directory, project.configFile);
      final exists = File(configPath).existsSync();
      final icon = exists ? '✓' : '✗';
      print('  $icon ${project.name} (${project.directory})');
    }
    return;
  }

  final results = <GenerationResult>[];

  for (final project in exampleProjects) {
    final configPath =
        p.join(packageRoot, project.directory, project.configFile);

    if (!File(configPath).existsSync()) {
      print('⚠  ${project.name}: config not found at ${project.configFile}');
      results.add(GenerationResult(
        project: project.name,
        passed: false,
        exitCode: -1,
        stdout: '',
        stderr: 'Config not found: $configPath',
        duration: Duration.zero,
      ));
      continue;
    }

    print('━━━ ${project.name} ━━━');

    // Run pub get first to ensure dependencies are resolved
    final pubGetResult = await Process.run(
      'dart',
      ['pub', 'get'],
      workingDirectory: p.join(packageRoot, project.directory),
    );
    if (pubGetResult.exitCode != 0) {
      print('  ✗ pub get failed');
      if (verbose) {
        _printOutput(
            pubGetResult.stdout.toString(), pubGetResult.stderr.toString());
      }
      results.add(GenerationResult(
        project: project.name,
        passed: false,
        exitCode: pubGetResult.exitCode,
        stdout: pubGetResult.stdout.toString(),
        stderr: pubGetResult.stderr.toString(),
        duration: Duration.zero,
      ));
      continue;
    }

    // Run the generator CLI with --config pointing to the project's config
    final sw = Stopwatch()..start();
    final result = await Process.run(
      'dart',
      [
        'run',
        generatorCli,
        '--config',
        configPath,
        if (verbose) '--verbose',
      ],
      workingDirectory: packageRoot,
    );
    sw.stop();

    final passed = result.exitCode == 0;
    results.add(GenerationResult(
      project: project.name,
      passed: passed,
      exitCode: result.exitCode,
      stdout: result.stdout.toString(),
      stderr: result.stderr.toString(),
      duration: sw.elapsed,
    ));

    final icon = passed ? '✓' : '✗';
    print('  $icon Generated  (${sw.elapsed.inMilliseconds}ms)');
    if (verbose || !passed) {
      _printOutput(result.stdout.toString(), result.stderr.toString());
    }
    print('');
  }

  // Summary
  final passed = results.where((r) => r.passed).length;
  final failed = results.where((r) => !r.passed).length;
  final total = results.length;
  final totalTime =
      results.fold<Duration>(Duration.zero, (sum, r) => sum + r.duration);

  print('══════════════════════════════════════════════════════════════');
  print('');
  print(
      'Summary: $passed/$total generated  ($failed failed)  ${totalTime.inSeconds}s');
  print('');

  if (failed > 0) {
    print('Failed:');
    for (final r in results.where((r) => !r.passed)) {
      print('  ✗ ${r.project}');
      if (r.stderr.isNotEmpty) {
        final firstLine = r.stderr.split('\n').first.trim();
        print('    $firstLine');
      }
    }
    print('');
  }

  exit(failed > 0 ? 1 : 0);
}

void _printOutput(String stdout, String stderr) {
  if (stdout.isNotEmpty) {
    for (final line in stdout.split('\n')) {
      if (line.trim().isNotEmpty) {
        print('    $line');
      }
    }
  }
  if (stderr.isNotEmpty) {
    for (final line in stderr.split('\n')) {
      if (line.trim().isNotEmpty) {
        print('    ⚠ $line');
      }
    }
  }
}
