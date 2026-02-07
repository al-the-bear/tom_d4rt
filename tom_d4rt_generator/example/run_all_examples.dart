#!/usr/bin/env dart
// Run all bridge generator examples.
//
// This script generates bridges for each example project and runs them.
//
// Usage:
//   dart run example/run_all_examples.dart
//   dart run example/run_all_examples.dart --generate-only
//   dart run example/run_all_examples.dart --run-only

import 'dart:io';

/// Example project configuration.
class ExampleProject {
  final String name;
  final String directory;
  final String configFile;
  final String runScript;

  const ExampleProject({
    required this.name,
    required this.directory,
    required this.configFile,
    required this.runScript,
  });
}

/// List of example projects.
const examples = [
  ExampleProject(
    name: 'User Guide',
    directory: 'example/user_guide',
    configFile: 'd4rt_bridging.json',
    runScript: 'bin/run_example.dart',
  ),
  ExampleProject(
    name: 'UserBridge Override',
    directory: 'example/userbridge_override',
    configFile: 'd4rt_bridging.json',
    runScript: 'bin/run_example.dart',
  ),
  ExampleProject(
    name: 'User Reference',
    directory: 'example/user_reference',
    configFile: 'd4rt_bridging.json',
    runScript: 'bin/run_example.dart',
  ),
];

Future<void> main(List<String> args) async {
  final generateOnly = args.contains('--generate-only');
  final runOnly = args.contains('--run-only');

  print('╔══════════════════════════════════════════════════════════════╗');
  print('║           D4rt Bridge Generator - Example Runner             ║');
  print('╚══════════════════════════════════════════════════════════════╝');
  print('');

  // Get the package root directory
  final scriptPath = Platform.script.toFilePath();
  final packageRoot = Directory(scriptPath).parent.parent.path;

  print('Package root: $packageRoot');
  print('');

  // Ensure we're in the right directory
  Directory.current = Directory(packageRoot);

  var successCount = 0;
  var failCount = 0;

  for (final example in examples) {
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('Example: ${example.name}');
    print('Directory: ${example.directory}');
    print('');

    final exampleDir = Directory('$packageRoot/${example.directory}');
    if (!exampleDir.existsSync()) {
      print('  ❌ Directory not found: ${exampleDir.path}');
      failCount++;
      continue;
    }

    // Run pub get first
    print('  📦 Running pub get...');
    final pubGetResult = await Process.run(
      'dart',
      ['pub', 'get'],
      workingDirectory: exampleDir.path,
    );
    if (pubGetResult.exitCode != 0) {
      print('  ❌ pub get failed:');
      print(pubGetResult.stderr);
      failCount++;
      continue;
    }
    print('  ✓ Dependencies resolved');

    // Generate bridges (unless --run-only)
    if (!runOnly) {
      print('  🔧 Generating bridges...');
      final generateResult = await Process.run(
        'dart',
        [
          'run',
          'tom_d4rt_generator:d4rt_gen',
          '--config',
          example.configFile,
        ],
        workingDirectory: exampleDir.path,
      );

      if (generateResult.exitCode != 0) {
        print('  ⚠️  Bridge generation had issues:');
        print(generateResult.stderr);
        // Continue anyway - the example might still run without bridges
      } else {
        print('  ✓ Bridges generated');
      }
    }

    // Run the example (unless --generate-only)
    if (!generateOnly) {
      print('  🚀 Running example...');
      final runResult = await Process.run(
        'dart',
        ['run', example.runScript],
        workingDirectory: exampleDir.path,
      );

      if (runResult.exitCode != 0) {
        print('  ❌ Example failed:');
        print(runResult.stderr);
        failCount++;
      } else {
        print('  ✓ Example completed successfully');
        print('');
        // Print example output indented
        final output = runResult.stdout.toString().trim();
        if (output.isNotEmpty) {
          for (final line in output.split('\n')) {
            print('    $line');
          }
        }
        successCount++;
      }
    } else {
      successCount++;
    }

    print('');
  }

  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('');
  print('Summary:');
  print('  ✓ Successful: $successCount');
  if (failCount > 0) {
    print('  ❌ Failed: $failCount');
  }
  print('');

  exit(failCount > 0 ? 1 : 0);
}
