// Runner for the D4rt user-bridges sample.
//
// Identical in shape to the advanced (generator) sample's runner: it registers
// the generated bridges, then interprets a script. Nothing extra is needed for
// the user bridges — the generator folded them into the same registration
// class, so a single `UserBridgesSampleBridges.register(d4rt)` installs both the
// auto-generated members and the hand-written overrides.
//
//   run_example.dart <example-name> [args...]   # run example/<name>/main.dart
//   <something> | run_example.dart              # run a single script from stdin
//
// Folder mode loads every `.dart` file under the example folder (subfolders
// included) into a source map keyed by each file's absolute `file://` URI, so
// relative imports between script files — `import 'sub/helper.dart';` included —
// resolve in-memory. Stdin mode loads the caller's working directory the same
// way, so a piped script can import sibling files too. The bridged native
// library is reached via its own package URI:
// `package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart`.
import 'dart:io';

import 'package:tom_d4rt/d4rt.dart';

// The generated registration class. Produced by `dart run
// tom_d4rt_generator:d4rtgen` from buildkit.yaml — never hand-edited.
// See run_generator.md for how (and when) to regenerate it.
import 'package:d4rt_userbridges_sample/dartscript.b.dart';

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

void _execute({
  required String source,
  required List<String> scriptArgs,
  required String label,
  String? library,
  Map<String, String>? sources,
}) {
  final d4rt = D4rt();

  // Installs both generated bridges and the hand-written user-bridge overrides.
  UserBridgesSampleBridges.register(d4rt);

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

/// Recursively read every `.dart` file under [dir] into a source map keyed by
/// each file's absolute `file://` URI, so relative imports (subfolders too)
/// resolve against the entry library's `file://` URI.
Map<String, String> _loadDartSources(Directory dir) {
  final sources = <String, String>{};
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      sources[entity.absolute.uri.toString()] = entity.readAsStringSync();
    }
  }
  return sources;
}

/// The caller's original working directory (exported as `TOM_D4RT_CALLER_CWD`
/// by the shell wrappers before they `cd` into the package root).
Directory _callerDir() {
  final cwd = Platform.environment['TOM_D4RT_CALLER_CWD'];
  return Directory(cwd == null || cwd.isEmpty ? Directory.current.path : cwd);
}

String _readAllStdin() {
  final buffer = StringBuffer();
  String? line;
  while ((line = stdin.readLineSync()) != null) {
    buffer.writeln(line);
  }
  return buffer.toString();
}
