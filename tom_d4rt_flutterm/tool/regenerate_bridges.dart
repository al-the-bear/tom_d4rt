// ignore_for_file: avoid_print
/// Regenerate all Flutter Material bridges using the d4rtgen API.
///
/// Run from the tom_d4rt_flutterm project root:
///   dart run tool/regenerate_bridges.dart
library;

import 'dart:io';

import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() async {
  final projectPath = Directory.current.path;
  final configPath = '$projectPath/buildkit.yaml';

  print('Regenerating bridges for: $projectPath');
  print('Config: $configPath');
  print('');

  final stopwatch = Stopwatch()..start();

  final result = await generateBridges(
    configPath: configPath,
    projectPath: projectPath,
  );

  stopwatch.stop();

  print('');
  print('=== Generation Complete ===');
  print('Total classes: ${result.totalClasses}');
  print('Total modules: ${result.totalModules}');
  print('Output files: ${result.outputFiles.length}');
  for (final f in result.outputFiles) {
    print('  - $f');
  }
  if (result.errors.isNotEmpty) {
    print('Errors:');
    for (final e in result.errors) {
      print('  ERROR: $e');
    }
  }
  print('Time: ${stopwatch.elapsed}');
  print('Success: ${result.isSuccess}');

  if (!result.isSuccess) {
    exitCode = 1;
  }
}
