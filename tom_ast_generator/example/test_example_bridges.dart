#!/usr/bin/env dart
/// Test all generated bridge test runners across example projects.
///
/// This script first regenerates bridges for all example projects, then runs
/// the generated `bin/d4rtrun.b.dart` test runner for each, testing:
/// 1. Bridge regeneration (via `generate_example_bridges.dart`)
/// 2. Script execution (`.d4rt` files via `execute()`)
/// 3. Bridge registration validation (`--init-eval`)
/// 4. Standalone example scripts (dart_overview)
///
/// Usage:
///   dart run example/test_example_bridges.dart
///   dart run example/test_example_bridges.dart --verbose
///   dart run example/test_example_bridges.dart --init-eval-only
///   dart run example/test_example_bridges.dart --skip-generation

import 'dart:io';

import 'package:path/path.dart' as p;

/// An example project with its test runner configuration.
class ExampleTestConfig {
  final String name;
  final String directory;
  final String testRunner;
  final List<String> scriptFiles;

  const ExampleTestConfig({
    required this.name,
    required this.directory,
    required this.testRunner,
    required this.scriptFiles,
  });
}

/// A standalone example that runs a Dart script directly (no test runner).
class StandaloneExampleConfig {
  final String name;
  final String directory;
  final String script;
  final List<String> args;

  const StandaloneExampleConfig({
    required this.name,
    required this.directory,
    required this.script,
    this.args = const [],
  });
}

/// All example projects with test runners.
const bridgeExamples = [
  ExampleTestConfig(
    name: 'User Guide',
    directory: 'example/user_guide',
    testRunner: 'bin/d4rtrun.b.dart',
    scriptFiles: ['scripts/user_guide_example.d4rt'],
  ),
  ExampleTestConfig(
    name: 'User Reference',
    directory: 'example/user_reference',
    testRunner: 'bin/d4rtrun.b.dart',
    scriptFiles: ['scripts/user_reference_example.d4rt'],
  ),
  ExampleTestConfig(
    name: 'UserBridge Override',
    directory: 'example/userbridge_override',
    testRunner: 'bin/d4rtrun.b.dart',
    scriptFiles: ['scripts/userbridge_override_example.d4rt'],
  ),
  ExampleTestConfig(
    name: 'UserBridge User Guide',
    directory: 'example/userbridge_user_guide',
    testRunner: 'bin/d4rtrun.b.dart',
    scriptFiles: [
      'test/ubr01_basic_class.dart',
      'test/ubr04_operator.dart',
      'test/ubr05_constructor.dart',
      'test/ubr06_import_prefix.dart',
    ],
  ),
  ExampleTestConfig(
    name: 'Example Project',
    directory: 'example/example_project',
    testRunner: 'bin/d4rtrun.b.dart',
    scriptFiles: [
      'scripts/basic_example.d4rt',
      'scripts/callbacks_example.d4rt',
      'scripts/generic_example.d4rt',
      'scripts/inheritance_example.d4rt',
      'scripts/operators_example.d4rt',
    ],
  ),
];

/// Standalone example scripts (no bridge test runner, run directly).
const standaloneExamples = [
  StandaloneExampleConfig(
    name: 'Dart Overview (D4rt)',
    directory: 'example/dart_overview',
    script: 'lib/run_overview_in_d4rt.dart',
  ),
];

/// Test result for a single test run.
class TestResult {
  final String project;
  final String test;
  final bool passed;
  final int exitCode;
  final String stdout;
  final String stderr;
  final Duration duration;

  const TestResult({
    required this.project,
    required this.test,
    required this.passed,
    required this.exitCode,
    required this.stdout,
    required this.stderr,
    required this.duration,
  });
}

Future<void> main(List<String> args) async {
  final verbose = args.contains('--verbose') || args.contains('-v');
  final initEvalOnly = args.contains('--init-eval-only');
  final skipGeneration = args.contains('--skip-generation');

  print('╔══════════════════════════════════════════════════════════════╗');
  print('║       D4rt Bridge Generator - Example Bridge Tester        ║');
  print('╚══════════════════════════════════════════════════════════════╝');
  print('');

  // Get the package root directory
  final scriptPath = Platform.script.toFilePath();
  final packageRoot = Directory(scriptPath).parent.parent.path;
  print('Package root: $packageRoot');
  print('');

  final results = <TestResult>[];

  // Step 0: Regenerate bridges (unless --skip-generation)
  if (!skipGeneration) {
    print('━━━ Bridge Generation ━━━');
    final generatorScript =
        p.join(packageRoot, 'example', 'generate_example_bridges.dart');
    if (File(generatorScript).existsSync()) {
      final sw = Stopwatch()..start();
      final result = await Process.run(
        'dart',
        [
          'run',
          generatorScript,
          if (verbose) '--verbose',
        ],
        workingDirectory: packageRoot,
      );
      sw.stop();

      final passed = result.exitCode == 0;
      results.add(TestResult(
        project: 'Bridge Generation',
        test: 'generate all',
        passed: passed,
        exitCode: result.exitCode,
        stdout: result.stdout.toString(),
        stderr: result.stderr.toString(),
        duration: sw.elapsed,
      ));

      final icon = passed ? '✓' : '✗';
      print('  $icon generate_example_bridges.dart  (${sw.elapsed.inMilliseconds}ms)');
      if (verbose || !passed) {
        _printOutput(result.stdout.toString(), result.stderr.toString(), passed);
      }

      if (!passed) {
        print('');
        print('⚠  Bridge generation failed. Continuing with existing bridges...');
      }
    } else {
      print('  ⚠  generate_example_bridges.dart not found, skipping generation');
    }
    print('');
  }

  // Step 1: Test bridge example projects (with test runners)
  for (final example in bridgeExamples) {
    final exampleDir = p.join(packageRoot, example.directory);
    final testRunner = p.join(exampleDir, example.testRunner);

    if (!File(testRunner).existsSync()) {
      print('⚠  ${example.name}: test runner not found at ${example.testRunner}');
      results.add(TestResult(
        project: example.name,
        test: 'test runner exists',
        passed: false,
        exitCode: -1,
        stdout: '',
        stderr: 'Test runner not found: $testRunner',
        duration: Duration.zero,
      ));
      continue;
    }

    // 1. Run --init-eval validation
    print('━━━ ${example.name} ━━━');
    {
      final sw = Stopwatch()..start();
      final result = await Process.run(
        'dart',
        ['run', example.testRunner, '--init-eval'],
        workingDirectory: exampleDir,
      );
      sw.stop();

      final passed = result.exitCode == 0;
      results.add(TestResult(
        project: example.name,
        test: '--init-eval',
        passed: passed,
        exitCode: result.exitCode,
        stdout: result.stdout.toString(),
        stderr: result.stderr.toString(),
        duration: sw.elapsed,
      ));

      final icon = passed ? '✓' : '✗';
      print('  $icon --init-eval  (${sw.elapsed.inMilliseconds}ms)');
      if (verbose || !passed) {
        _printOutput(result.stdout.toString(), result.stderr.toString(), passed);
      }
    }

    // 2. Run script files (unless --init-eval-only)
    if (!initEvalOnly) {
      for (final scriptFile in example.scriptFiles) {
        final scriptPath = p.join(exampleDir, scriptFile);
        if (!File(scriptPath).existsSync()) {
          results.add(TestResult(
            project: example.name,
            test: scriptFile,
            passed: false,
            exitCode: -1,
            stdout: '',
            stderr: 'Script not found: $scriptPath',
            duration: Duration.zero,
          ));
          print('  ✗ $scriptFile  (file not found)');
          continue;
        }

        final sw = Stopwatch()..start();
        final result = await Process.run(
          'dart',
          ['run', example.testRunner, scriptFile],
          workingDirectory: exampleDir,
        );
        sw.stop();

        final passed = result.exitCode == 0;
        results.add(TestResult(
          project: example.name,
          test: scriptFile,
          passed: passed,
          exitCode: result.exitCode,
          stdout: result.stdout.toString(),
          stderr: result.stderr.toString(),
          duration: sw.elapsed,
        ));

        final icon = passed ? '✓' : '✗';
        print('  $icon $scriptFile  (${sw.elapsed.inMilliseconds}ms)');
        if (verbose || !passed) {
          _printOutput(result.stdout.toString(), result.stderr.toString(), passed);
        }
      }
    }

    print('');
  }

  // Step 2: Test standalone examples (no bridge test runner)
  if (!initEvalOnly) {
    for (final example in standaloneExamples) {
      final exampleDir = p.join(packageRoot, example.directory);
      final script = p.join(exampleDir, example.script);

      if (!Directory(exampleDir).existsSync()) {
        print('⚠  ${example.name}: directory not found at ${example.directory}');
        results.add(TestResult(
          project: example.name,
          test: example.script,
          passed: false,
          exitCode: -1,
          stdout: '',
          stderr: 'Directory not found: $exampleDir',
          duration: Duration.zero,
        ));
        continue;
      }

      if (!File(script).existsSync()) {
        print('⚠  ${example.name}: script not found at ${example.script}');
        results.add(TestResult(
          project: example.name,
          test: example.script,
          passed: false,
          exitCode: -1,
          stdout: '',
          stderr: 'Script not found: $script',
          duration: Duration.zero,
        ));
        continue;
      }

      print('━━━ ${example.name} ━━━');
      final sw = Stopwatch()..start();
      final result = await Process.run(
        'dart',
        ['run', example.script, ...example.args],
        workingDirectory: exampleDir,
      );
      sw.stop();

      final passed = result.exitCode == 0;
      results.add(TestResult(
        project: example.name,
        test: example.script,
        passed: passed,
        exitCode: result.exitCode,
        stdout: result.stdout.toString(),
        stderr: result.stderr.toString(),
        duration: sw.elapsed,
      ));

      final icon = passed ? '✓' : '✗';
      print('  $icon ${example.script}  (${sw.elapsed.inMilliseconds}ms)');
      if (verbose || !passed) {
        _printOutput(result.stdout.toString(), result.stderr.toString(), passed);
      }
      print('');
    }
  }

  // Summary
  final passed = results.where((r) => r.passed).length;
  final failed = results.where((r) => !r.passed).length;
  final total = results.length;
  final totalTime =
      results.fold<Duration>(Duration.zero, (sum, r) => sum + r.duration);

  print('══════════════════════════════════════════════════════════════');
  print('');
  print('Summary: $passed/$total passed  ($failed failed)  ${totalTime.inSeconds}s');
  print('');

  if (failed > 0) {
    print('Failed tests:');
    for (final r in results.where((r) => !r.passed)) {
      print('  ✗ ${r.project}: ${r.test}');
      if (r.stderr.isNotEmpty) {
        final firstLine = r.stderr.split('\n').first.trim();
        print('    $firstLine');
      }
    }
    print('');
  }

  exit(failed > 0 ? 1 : 0);
}

void _printOutput(String stdout, String stderr, bool passed) {
  if (stdout.isNotEmpty) {
    for (final line in stdout.split('\n')) {
      if (line.trim().isNotEmpty) {
        print('    $line');
      }
    }
  }
  if (stderr.isNotEmpty && !passed) {
    for (final line in stderr.split('\n')) {
      if (line.trim().isNotEmpty) {
        print('    ⚠ $line');
      }
    }
  }
}
