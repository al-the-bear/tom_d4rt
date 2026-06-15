// Runner for the D4rt introduction sample.
//
// Two modes:
//
//   1. Folder mode:  run_example.dart <example-name> [script-args...]
//        Loads *every* `.dart` file under `example/<example-name>/` —
//        subfolders included — into an in-memory source map, keyed by each
//        file's absolute `file://` URI, and executes `main.dart`'s `main()`.
//        Relative imports between the files (e.g. `import 'parser.dart';` or
//        `import 'sub/helper.dart';`) resolve inside that map: the interpreter
//        does `entryLibraryUri.resolve(importString)` and looks the result up
//        in the map. It never touches the filesystem itself.
//
//   2. Stdin mode:   <something> | run_example.dart
//        With no example name, reads a script from stdin and executes it. The
//        script may still use relative imports to sibling files: every `.dart`
//        file under the caller's original working directory is loaded
//        (recursively, same as folder mode) and the stdin script is mounted
//        alongside them under a synthetic `file://` URI in that directory.
//
// Everything the scripts need (`print`, collections, classes, enums, async,
// pattern matching, ...) is built into the interpreter — no bridges required.
import 'dart:io';

import 'package:tom_d4rt/d4rt.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    _runStdin();
    return;
  }

  final exampleName = args.first;
  final scriptArgs = args.skip(1).toList();
  _runFolder(exampleName, scriptArgs);
}

/// Load `example/<name>/**.dart` into a source map and run its `main()`.
void _runFolder(String name, List<String> scriptArgs) {
  final folder = Directory('example/$name');
  if (!folder.existsSync()) {
    stderr.writeln('Example folder not found: ${folder.path}');
    stderr.writeln('Run from the package root, e.g. `./run_example.sh $name`.');
    exit(64); // EX_USAGE
  }

  final sources = _loadDartSources(folder);
  final entryUri = folder.absolute.uri.resolve('main.dart').toString();
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

/// Read a script from stdin and run it. Sibling `.dart` files under the
/// caller's original working directory are loaded too, so the piped script can
/// use relative imports just like a folder example.
void _runStdin() {
  final source = _readAllStdin();
  if (source.trim().isEmpty) {
    stderr.writeln('Usage: run_example.dart <example-name> [args...]');
    stderr.writeln('   or: echo "<script>" | run_example.dart');
    exit(64);
  }

  final callerDir = _callerDir();
  final sources =
      callerDir.existsSync() ? _loadDartSources(callerDir) : <String, String>{};
  final entryUri = callerDir.absolute.uri.resolve('__stdin__.dart').toString();
  sources[entryUri] = source;

  _execute(
    source: source,
    library: entryUri,
    sources: sources,
    scriptArgs: const [],
    label: 'stdin',
  );
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

/// Recursively read every `.dart` file under [dir] into a source map keyed by
/// each file's absolute `file://` URI. Because the entry library is also an
/// absolute `file://` URI, relative imports (including ones reaching into
/// subfolders) resolve against these keys.
Map<String, String> _loadDartSources(Directory dir) {
  final sources = <String, String>{};
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      sources[entity.absolute.uri.toString()] = entity.readAsStringSync();
    }
  }
  return sources;
}

/// The caller's original working directory. The shell wrappers export it as
/// `TOM_D4RT_CALLER_CWD` before they `cd` into the package root, so stdin mode
/// can find the user's sibling files rather than the package root's.
Directory _callerDir() {
  final cwd = Platform.environment['TOM_D4RT_CALLER_CWD'];
  return Directory(cwd == null || cwd.isEmpty ? Directory.current.path : cwd);
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
