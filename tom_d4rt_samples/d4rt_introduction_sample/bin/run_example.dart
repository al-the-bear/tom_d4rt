// Runner for the D4rt introduction sample.
//
// Two modes:
//
//   1. Folder mode:  run_example.dart <example-name> [script-args...]
//        Loads *every* `.dart` file in `example/<example-name>/` into a
//        in-memory source map, keyed by a synthetic `package:` URI, and
//        executes `main.dart`'s `main()`. Relative imports between the files
//        (e.g. `import 'parser.dart';`) resolve inside that map — which is how
//        the pure interpreter does multi-file execution: it never touches the
//        filesystem itself, it just looks URIs up in the map you give it.
//
//   2. Stdin mode:   <something> | run_example.dart
//        With no example name, reads a single self-contained script from stdin
//        and executes it. A stdin script has no sibling files, so it must not
//        use relative imports.
//
// Everything the scripts need (`print`, collections, classes, enums, async,
// pattern matching, ...) is built into the interpreter — no bridges required.
import 'dart:io';

import 'package:tom_d4rt/d4rt.dart';

/// Synthetic package the example files are mounted under. Relative imports
/// between the files resolve against this, so `import 'parser.dart';` in
/// `package:example/main.dart` becomes `package:example/parser.dart`.
const _packageRoot = 'package:example';

void main(List<String> args) {
  if (args.isEmpty) {
    _runStdin();
    return;
  }

  final exampleName = args.first;
  final scriptArgs = args.skip(1).toList();
  _runFolder(exampleName, scriptArgs);
}

/// Load `example/<name>/*.dart` into a source map and run its `main()`.
void _runFolder(String name, List<String> scriptArgs) {
  final folder = Directory('example/$name');
  if (!folder.existsSync()) {
    stderr.writeln('Example folder not found: ${folder.path}');
    stderr.writeln('Run from the package root, e.g. `./run_example.sh $name`.');
    exit(64); // EX_USAGE
  }

  // Mount every .dart file in the folder under the synthetic package.
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

  _execute(
    source: entrySource,
    library: entryUri,
    sources: sources,
    scriptArgs: scriptArgs,
    label: name,
  );
}

/// Read a single script from stdin and run it (no sibling files / imports).
void _runStdin() {
  final source = _readAllStdin();
  if (source.trim().isEmpty) {
    stderr.writeln('Usage: run_example.dart <example-name> [args...]');
    stderr.writeln('   or: echo "<script>" | run_example.dart');
    exit(64);
  }
  _execute(source: source, scriptArgs: const [], label: 'stdin');
}

/// Shared execution path. A fresh interpreter per run keeps examples isolated.
void _execute({
  required String source,
  required List<String> scriptArgs,
  required String label,
  String? library,
  Map<String, String>? sources,
}) {
  final d4rt = D4rt();
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
    exit(70); // EX_SOFTWARE
  }
}

/// Read all of stdin as a single string.
String _readAllStdin() {
  final buffer = StringBuffer();
  String? line;
  while ((line = stdin.readLineSync()) != null) {
    buffer.writeln(line);
  }
  return buffer.toString();
}
