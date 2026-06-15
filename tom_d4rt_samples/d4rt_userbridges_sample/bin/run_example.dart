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
// Folder mode loads every `.dart` file in the example folder into a source map
// keyed by `package:example/<file>`, so relative imports between script files
// resolve in-memory. The bridged native library is reached via its own package
// URI: `package:d4rt_userbridges_sample/d4rt_userbridges_sample.dart`.
import 'dart:io';

import 'package:tom_d4rt/d4rt.dart';

// The generated registration class. Produced by `dart run
// tom_d4rt_generator:d4rtgen` from buildkit.yaml — never hand-edited.
import 'package:d4rt_userbridges_sample/dartscript.b.dart';

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

String _readAllStdin() {
  final buffer = StringBuffer();
  String? line;
  while ((line = stdin.readLineSync()) != null) {
    buffer.writeln(line);
  }
  return buffer.toString();
}
