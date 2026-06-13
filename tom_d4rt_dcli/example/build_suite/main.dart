#!/usr/bin/env dcli
/// Build-suite — extended multi-file DCli sample.
///
/// A miniature build/automation tool that generates a throw-away Dart
/// project in a temp directory and runs a sequence of build tasks over it.
/// It is the CLI analog of the Flutter "extended sample" apps: real
/// multi-file structure, classes and functions split across files, and the
/// DCli shell + filesystem bridges driving the work.
///
/// Files:
///   * `main.dart`   — argument parsing + dispatch (this file)
///   * `tasks.dart`  — the `BuildTask` hierarchy + `TaskRunner`
///   * `logger.dart` — coloured, step-numbered output via DCli colour bridges
///
/// Run it:
///   dcli example/build_suite/main.dart            # default target: all
///   dcli example/build_suite/main.dart analyze
///   dart run example/build_suite/main.dart clean
///
/// Or wire it into a BuildKit pipeline — see `buildkit.yaml` in this folder.
library;

import 'dart:io';

import 'package:dcli/dcli.dart';

import 'logger.dart';
import 'tasks.dart';

const _knownTargets = ['all', 'clean', 'generate', 'analyze'];

void main(List<String> args) {
  final target = args.isEmpty ? 'all' : args.first;
  final log = BuildLogger();

  print(blue('tom_d4rt_dcli build-suite', bold: true));
  print(grey('target: $target', level: 0.6));

  final tasks = tasksForTarget(target);
  if (tasks.isEmpty) {
    log.err('unknown target "$target"');
    log.info('known targets: ${_knownTargets.join(', ')}');
    exit(2);
  }

  // Build into an isolated temp project so the sample never touches the
  // surrounding workspace; clean it up unconditionally on exit.
  final projectDir = createTempDir();
  int exitCode;
  try {
    final ctx = BuildContext(projectDir);
    log.step('Workspace');
    log.info('scratch project: $projectDir');

    TaskRunner(tasks).runAll(ctx, log);
    exitCode = log.summary();
  } finally {
    if (exists(projectDir)) deleteDir(projectDir, recursive: true);
  }

  exit(exitCode);
}
