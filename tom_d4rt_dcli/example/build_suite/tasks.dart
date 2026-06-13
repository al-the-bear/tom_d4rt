/// Build-suite tasks.
///
/// Defines the task hierarchy executed by the build suite. Each task is a
/// small, single-responsibility unit; [TaskRunner] sequences them and stops
/// on the first hard failure. Demonstrates an abstract base class plus
/// concrete subclasses spread across files, and use of the DCli shell and
/// filesystem bridges from script code.
library;

import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;

import 'logger.dart';

/// Shared context handed to every task: the scratch project directory the
/// suite builds into.
class BuildContext {
  BuildContext(this.projectDir);

  /// Root of the throw-away project this suite generates and operates on.
  final String projectDir;

  String get libDir => p.join(projectDir, 'lib');
  String get buildDir => p.join(projectDir, 'build');
}

/// A single build step. Returning `false` aborts the remaining pipeline.
abstract class BuildTask {
  String get name;

  bool run(BuildContext ctx, BuildLogger log);
}

/// Verifies the toolchain via DCli's shell bridges (`which`, `.firstLine`).
class EnvCheckTask extends BuildTask {
  @override
  String get name => 'Environment check';

  @override
  bool run(BuildContext ctx, BuildLogger log) {
    log.step('Checking environment');
    final dart = which('dart').path;
    if (dart == null) {
      log.err('dart executable not found on PATH');
      return false;
    }
    log.ok('dart on PATH: $dart');
    final version = 'dart --version'.firstLine ?? 'unknown';
    log.info(version);
    return true;
  }
}

/// Removes any prior build output so the run starts from a clean slate.
class CleanTask extends BuildTask {
  @override
  String get name => 'Clean';

  @override
  bool run(BuildContext ctx, BuildLogger log) {
    log.step('Cleaning build output');
    if (exists(ctx.buildDir)) {
      deleteDir(ctx.buildDir, recursive: true);
      log.ok('removed ${p.basename(ctx.buildDir)}/');
    } else {
      log.info('nothing to clean');
    }
    return true;
  }
}

/// Writes a tiny multi-file Dart library into the scratch project so later
/// tasks have something to operate on.
class GenerateTask extends BuildTask {
  @override
  String get name => 'Generate sources';

  @override
  bool run(BuildContext ctx, BuildLogger log) {
    log.step('Generating sources');
    createDir(ctx.libDir, recursive: true);

    final sources = <String, String>{
      'greeter.dart': "String greet(String who) => 'Hello, \$who!';\n",
      'math.dart': 'int add(int a, int b) => a + b;\n'
          'int mul(int a, int b) => a * b;\n',
    };
    sources.forEach((file, body) {
      final path = p.join(ctx.libDir, file);
      path.write(body);
      log.ok('wrote lib/$file (${body.split('\n').length - 1} lines)');
    });
    return true;
  }
}

/// "Analyses" the generated sources by counting declarations — a stand-in
/// for `dart analyze` that needs no real package resolution. Demonstrates
/// the DCli `find`/`read` filesystem bridges.
class AnalyzeTask extends BuildTask {
  @override
  String get name => 'Analyze';

  @override
  bool run(BuildContext ctx, BuildLogger log) {
    log.step('Analyzing sources');
    final dartFiles = find('*.dart', workingDirectory: ctx.libDir).toList();
    if (dartFiles.isEmpty) {
      log.warn('no Dart sources found — did generate run?');
      return true;
    }
    var declarations = 0;
    for (final file in dartFiles) {
      final hits = read(file)
          .toList()
          .where((line) => line.contains('=>') || line.contains('class '))
          .length;
      declarations += hits;
      log.info('${p.basename(file)}: $hits declaration(s)');
    }
    log.ok('analyzed ${dartFiles.length} file(s), $declarations declaration(s)');
    return true;
  }
}

/// Bundles the sources into the build directory and records a manifest.
class PackageTask extends BuildTask {
  @override
  String get name => 'Package';

  @override
  bool run(BuildContext ctx, BuildLogger log) {
    log.step('Packaging');
    createDir(ctx.buildDir, recursive: true);
    final manifest = p.join(ctx.buildDir, 'manifest.txt');
    final files = find('*.dart', workingDirectory: ctx.libDir).toList();
    final entries = files
        .map((f) => '${p.basename(f)}\t${File(f).statSync().size} bytes')
        .join('\n');
    manifest.write('# build manifest\n$entries\n');
    log.ok('wrote ${p.relative(manifest, from: ctx.projectDir)}');
    return true;
  }
}

/// Sequences a list of [BuildTask]s, halting on the first that returns false.
class TaskRunner {
  TaskRunner(this.tasks);

  final List<BuildTask> tasks;

  /// Runs every task in order. Returns `true` only if all tasks succeeded.
  bool runAll(BuildContext ctx, BuildLogger log) {
    for (final task in tasks) {
      if (!task.run(ctx, log)) {
        log.err('aborted at task: ${task.name}');
        return false;
      }
    }
    return true;
  }
}

/// Maps a CLI target name to the task list it should run.
List<BuildTask> tasksForTarget(String target) {
  switch (target) {
    case 'clean':
      return [CleanTask()];
    case 'generate':
      return [GenerateTask()];
    case 'analyze':
      return [GenerateTask(), AnalyzeTask()];
    case 'all':
      return [
        EnvCheckTask(),
        CleanTask(),
        GenerateTask(),
        AnalyzeTask(),
        PackageTask(),
      ];
    default:
      return const [];
  }
}
