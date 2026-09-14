import 'dart:io';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:tom_d4rt/src/static_name_report.dart';

/// Names every script may assume: dart:core plus the flutter bridge surface,
/// harvested from the generated bridges rather than hand-listed.
Set<String> harvestGlobals() {
  final names = <String>{
    'print',
    'int',
    'double',
    'num',
    'String',
    'bool',
    'List',
    'Map',
    'Set',
    'Iterable',
    'Object',
    'dynamic',
    'void',
    'Function',
    'Future',
    'Stream',
    'Duration',
    'DateTime',
    'RegExp',
    'StringBuffer',
    'Uri',
    'BigInt',
    'Comparable',
    'Symbol',
    'Type',
    'Record',
    'Null',
    'Never',
    'Enum',
    'identical',
    'identityHashCode',
    'main',
  };
  final bridgeDir = Directory('../tom_d4rt_flutter_ast/lib/src/bridges');
  if (bridgeDir.existsSync()) {
    // Classes AND the top-level functions / variables / getters a bridge
    // registers. Harvesting only `name:` (the BridgedClass form) missed every
    // `debugPrint`, `kDebugMode` and `defaultTargetPlatform` in the corpus.
    final res = [
      RegExp(r"name: '([A-Za-z_][A-Za-z0-9_]*)'"),
      RegExp(r"registerGlobal\w*\('([A-Za-z_][A-Za-z0-9_]*)'"),
      RegExp(r"registerTopLevel\w*\('([A-Za-z_][A-Za-z0-9_]*)'"),
      RegExp(r"registerBridgedFunction\('([A-Za-z_][A-Za-z0-9_]*)'"),
      // Top-level functions are registered from a map whose KEYS are the
      // names (`interpreter.registertopLevelFunction(entry.key, ...)`), so the
      // names appear only as map keys: `'applyBoxFit': (visitor, ...) {`.
      RegExp(r"'([A-Za-z_][A-Za-z0-9_]*)': \(visitor,"),
      // `typedef MaterialStateProperty<T> = WidgetStateProperty<T>` aliases.
      RegExp(r"typedef ([A-Za-z_][A-Za-z0-9_]*)"),
      RegExp(r"'([A-Za-z_][A-Za-z0-9_]*)': '[A-Za-z_][A-Za-z0-9_]*'"),
    ];
    for (final f in bridgeDir.listSync().whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      final src = f.readAsStringSync();
      for (final re in res) {
        for (final m in re.allMatches(src)) {
          names.add(m.group(1)!);
        }
      }
    }
  }
  // dart:core / dart:math / dart:async names the stdlib registers.
  final stdlib = Directory('lib/src/stdlib');
  if (stdlib.existsSync()) {
    final res = [
      RegExp(r"name: '([A-Za-z_][A-Za-z0-9_]*)'"),
      // `environment.define('pi', pi)` — dart:math constants and the like.
      RegExp(r"\.define\('([A-Za-z_][A-Za-z0-9_]*)'"),
      RegExp(r"'([A-Za-z_][A-Za-z0-9_]*)': \(visitor,"),
    ];
    for (final f in stdlib.listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      final src = f.readAsStringSync();
      for (final re in res) {
        for (final m in re.allMatches(src)) {
          names.add(m.group(1)!);
        }
      }
    }
  }
  return names;
}

void main(List<String> args) {
  final root = args.isEmpty
      ? '../tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts'
      : args[0];
  final globals = harvestGlobals();
  stderr.writeln('harvested ${globals.length} global names');

  var files = 0, suppressed = 0, clean = 0, dirty = 0;
  final hits = <String, int>{};
  final examples = <String, String>{};
  var openClassTotal = 0;

  for (final f in Directory(root).listSync(recursive: true).whereType<File>()) {
    if (!f.path.endsWith('.dart')) continue;
    files++;
    late final String src;
    try {
      src = f.readAsStringSync();
    } catch (_) {
      continue;
    }
    final result = parseString(
      content: src,
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    );
    // The caller owns the import decision. `dart:*` and `package:flutter/*`
    // names are in the harvested set; anything else (a relative import of a
    // sibling script) brings names this sweep cannot see.
    final unaccounted = result.unit.directives
        .whereType<ImportDirective>()
        .map((d) => d.uri.stringValue ?? '')
        .where(
          (u) => !u.startsWith('dart:') && !u.startsWith('package:flutter/'),
        )
        .toList();
    final report = reportUnresolvedNames(
      result.unit,
      globals,
      hasUnresolvedImports: unaccounted.isNotEmpty,
    );
    openClassTotal += report.openClasses.length;
    if (report.suppressed) {
      suppressed++;
      continue;
    }
    if (report.isClean) {
      clean++;
    } else {
      dirty++;
      for (final u in report.unresolved) {
        hits[u.name] = (hits[u.name] ?? 0) + 1;
        examples.putIfAbsent(u.name, () => '${f.path}: $u');
      }
    }
  }

  print(
    'files=$files suppressed(imports)=$suppressed clean=$clean dirty=$dirty',
  );
  print('openClasses(skipped bodies)=$openClassTotal');
  print('distinct unresolved names=${hits.length}');
  final sorted = hits.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  for (final e in sorted.take(40)) {
    print('  ${e.value.toString().padLeft(5)}  ${e.key}');
    print('         e.g. ${examples[e.key]}');
  }
}
