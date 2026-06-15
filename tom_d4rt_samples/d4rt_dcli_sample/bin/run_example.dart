// Runner for the D4rt dcli sample.
//
// Builds on the advanced sample's runner. Two registration steps now run before
// every script:
//   1. DcliSampleBridges.register  — this project's generated log-analysis
//      bridges (LogParser, LogStats, LogEntry, LogLevel).
//   2. TomD4rtDcliBridge.register  — the dcli package's ready-made bridges
//      (top-level read/write/find/createDir/delete, the `'cmd'.run` extension,
//      Env, Ask, Confirm, ...). These ship inside tom_d4rt_dcli; we do not
//      generate them here.
//
//   run_example.dart <example-name> [args...]   # run example/<name>/main.dart
//   <something> | run_example.dart              # run a single script from stdin
//
// Folder mode loads every `.dart` file in the example folder into a source map
// keyed by `package:example/<file>` so relative imports resolve in-memory, then
// switches the process working directory to that folder. dcli's file functions
// run natively, so a script can read/write bundled data files with plain
// relative paths (e.g. `'sample.log'.toList()`).
import 'dart:io';

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt_dcli/tom_d4rt_dcli.dart';

// The generated registration class for this project's native library.
// Produced by `dart run tom_d4rt_generator:d4rtgen` — never hand-edited.
import 'package:d4rt_dcli_sample/dartscript.b.dart';

const _packageRoot = 'package:example';

void main(List<String> args) {
  if (args.isEmpty) {
    _runStdin();
    return;
  }
  _runFolder(args.first, args.skip(1).toList());
}

void _runFolder(String name, List<String> scriptArgs) {
  final folder = Directory('example/$name');
  if (!folder.existsSync()) {
    stderr.writeln('Example folder not found: ${folder.path}');
    stderr.writeln('Run from the package root, e.g. `./run_example.sh $name`.');
    exit(64);
  }

  final sources = <String, String>{};
  for (final entity in folder.listSync()) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final fileName = entity.uri.pathSegments.last;
      sources['$_packageRoot/$fileName'] = entity.readAsStringSync();
    }
  }

  final entryUri = '$_packageRoot/main.dart';
  final entrySource = sources[entryUri];
  if (entrySource == null) {
    stderr.writeln('No main.dart in ${folder.path}');
    exit(64);
  }

  // Run from inside the example folder so dcli file functions resolve bundled
  // data files (sample.log, report.txt, ...) with simple relative paths.
  Directory.current = folder.absolute.path;

  _execute(
    source: entrySource,
    library: entryUri,
    sources: sources,
    scriptArgs: scriptArgs,
    label: name,
  );
}

void _runStdin() {
  final source = _readAllStdin();
  if (source.trim().isEmpty) {
    stderr.writeln('Usage: run_example.dart <example-name> [args...]');
    stderr.writeln('   or: echo "<script>" | run_example.dart');
    exit(64);
  }
  _execute(source: source, scriptArgs: const [], label: 'stdin');
}

void _execute({
  required String source,
  required List<String> scriptArgs,
  required String label,
  String? library,
  Map<String, String>? sources,
}) {
  final d4rt = D4rt();

  // This project's native log-analysis library...
  DcliSampleBridges.register(d4rt);
  // ...and the dcli shell-scripting bridges, side by side in one interpreter.
  TomD4rtDcliBridge.register(d4rt);

  try {
    final result = d4rt.execute(
      source: source,
      library: library,
      sources: sources,
      positionalArgs: [scriptArgs],
    );
    if (result != null) {
      stdout.writeln('=> $result');
    }
  } catch (e, st) {
    stderr.writeln('Error running "$label": $e');
    stderr.writeln(st);
    exit(70);
  }
}

String _readAllStdin() {
  final buffer = StringBuffer();
  String? line;
  while ((line = stdin.readLineSync()) != null) {
    buffer.writeln(line);
  }
  return buffer.toString();
}
