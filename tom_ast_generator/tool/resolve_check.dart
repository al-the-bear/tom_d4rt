// The resolving check over many scripts of one project (ghissues68).
//
//   dart run tool/resolve_check.dart --project <root> [options] <path>...
//
// Resolves every `*.dart` file under each <path> (a folder, searched
// recursively, or a file) with the analyzer, in the project at <root> (its
// `.dart_tool/package_config.json` supplies the packages), and prints each
// analyzer error with file, line and code. One analysis context serves every
// file, so the analyzer's start is paid once. Exits 1 when any error is left,
// 0 otherwise, 2 on a usage error.
//
// Options:
//   --project <root>          the project the scripts belong to (required)
//   --dart-sdk <path>         the Dart SDK (default: DART_SDK, else the dart
//                             or flutter on PATH)
//   --runtime-library <uri>   a library that exists only at run time; its
//                             missing import and the names it would supply
//                             are counted, not reported (repeatable)
//   --stubs <folder>          declaration stubs: <folder>/<package>/<path>
//                             declares package:<package>/<path>
//
// The twins' corpus check (`tom_d4rt_flutter_ast/test/run_corpus_check.sh`)
// runs it over the corpus scripts in the companion app.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_ast_generator/tom_ast_generator.dart';

Future<void> main(List<String> args) async {
  String? project;
  String? sdk;
  String? stubsFolder;
  final runtimeOnly = <String>{};
  final paths = <String>[];
  for (var i = 0; i < args.length; i++) {
    String value() {
      if (i + 1 >= args.length) _usage('${args[i]} needs a value');
      return args[++i];
    }

    switch (args[i]) {
      case '--project':
        project = value();
      case '--dart-sdk':
        sdk = value();
      case '--runtime-library':
        runtimeOnly.add(value());
      case '--stubs':
        stubsFolder = value();
      case final arg when arg.startsWith('--'):
        _usage('unknown option $arg');
      case final arg:
        paths.add(arg);
    }
  }
  if (project == null) _usage('--project is required');
  if (paths.isEmpty) _usage('no path to check');
  for (final path in paths) {
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      _usage('no such file or folder: $path');
    }
  }

  final files = <String>[
    for (final path in paths)
      if (FileSystemEntity.isDirectorySync(path))
        ...Directory(path)
            .listSync(recursive: true)
            .whereType<File>()
            .map((f) => f.path)
            .where((f) => f.endsWith('.dart'))
            .toList()
          ..sort()
      else
        path,
  ];

  final stubs = <String, String>{
    if (stubsFolder != null)
      for (final file
          in Directory(stubsFolder)
              .listSync(recursive: true)
              .whereType<File>()
              .where((f) => f.path.endsWith('.dart')))
        'package:${p.split(p.relative(file.path, from: stubsFolder)).join('/')}':
            file.readAsStringSync(),
  };

  final resolver = AstResolver(sdkPath: sdk);
  final stopwatch = Stopwatch()..start();
  var errorCount = 0;
  var filteredCount = 0;
  final failedFiles = <String>[];
  try {
    print(
      'Resolving ${files.length} file(s) in $project '
      '(Dart SDK ${resolver.dartSdk})',
    );
    for (final file in files) {
      final report = await resolver.checkFiles(
        [file],
        projectRoot: project,
        stubs: stubs,
        runtimeOnlyLibraries: runtimeOnly,
      );
      filteredCount += report.filteredCount;
      if (!report.passed) {
        failedFiles.add(file);
        errorCount += report.errors.length;
        for (final error in report.errors) {
          print('  $error');
        }
      }
    }
  } finally {
    await resolver.dispose();
  }
  print(
    '${errorCount == 0 ? 'PASSED' : 'FAILED'}: ${files.length} file(s), '
    '$errorCount error(s) in ${failedFiles.length} file(s), '
    '$filteredCount filtered (runtime-only libraries without source or stub), '
    '${stopwatch.elapsed.inSeconds} s',
  );
  exitCode = errorCount == 0 ? 0 : 1;
}

Never _usage(String message) {
  stderr.writeln('resolve_check: $message');
  stderr.writeln(
    'usage: dart run tool/resolve_check.dart --project <root> '
    '[--dart-sdk <path>] [--runtime-library <uri>]... [--stubs <folder>] '
    '<path>...',
  );
  exit(2);
}
