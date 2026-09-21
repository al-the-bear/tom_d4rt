#!/usr/bin/env dart
// Census: which of the copier's ~154 `_convert*` methods has a test suite
// never executed, and which analyzer node types does it not handle at all.
//
// WHY BY NODE FAMILY RATHER THAN BY FILE. `_coveredElsewhere` in exec's
// conformance guard names fourteen script suites that rest on an `ast:` twin,
// and the obvious reading is that porting those fourteen closes the copier's
// gap. It does not. Those files have no particular relationship to the copy
// surface — they are the ones that happen to have twins. What the copier's
// correctness depends on is which NODE TYPES it has transcribed, because a
// node whose fields are copied wrongly yields a mirror tree that interprets
// consistently and wrongly.
//
// THREE WAYS THE COPIER CAN BE WRONG, and this census sees two of them:
//
//   1. UNHANDLED NODE TYPE. `convert()` is an if-chain over `node is
//      analyzer.X`; anything reaching the end becomes `_SUnknownNode`, which
//      serialises as `{"nodeType": "Unknown", "originalType": "..."}`. That
//      placeholder is an exact oracle -- `--probe` reads it.
//   2. HANDLED BUT NEVER EXERCISED. A `_convert*` method no test has run is
//      transcription nobody has checked. `--coverage` reads it.
//   3. HANDLED, EXERCISED, AND A FIELD SILENTLY NOT COPIED. sce49's
//      conditional-import `configurations` is this: `ImportDirective` is
//      handled, its method runs, and the field is dropped. NEITHER half of
//      this census can see it -- coverage says the line ran, and the node is
//      not Unknown. Only a fidelity test comparing field by field finds it.
//      `directive_mirror_fidelity_test.dart` is that kind of test. This tool
//      does not replace it and must not be read as covering it.
//
// USAGE
//   dart tool/census_copier.dart --coverage <dir> [--package-config <path>]
//       <dir> from `dart test --coverage`; the package config is the one of
//       the package whose tests were run -- REQUIRED when the coverage was
//       collected for another package (exec, say) or written outside its tree,
//       because a hit-map names `package:` URIs and nothing else says which
//       copy of the package they meant.
//   dart tool/census_copier.dart --probe            # node types that go Unknown
//   dart tool/census_copier.dart                    # static: dispatch chain vs analyzer

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:tom_ast_generator/src/converter/ast_converter.dart';

/// Every `_convert<Name>` method declared in the converter, with its line span.
///
/// The span is what lets a coverage hit-map be read as "this method ran": the
/// hit-map is line-keyed, so a method is executed when any line between its
/// declaration and the next one has a non-zero hit count.
Map<String, ({int start, int end})> _convertMethods(String source) {
  final lines = source.split('\n');
  final decl = RegExp(
    r'^\s{2}[A-Za-z][A-Za-z0-9<>?,\s\.]*\s(_convert[A-Za-z]+)\(',
  );
  final found = <String, int>{};
  for (var i = 0; i < lines.length; i++) {
    final m = decl.firstMatch(lines[i]);
    if (m != null) found.putIfAbsent(m.group(1)!, () => i + 1);
  }
  final starts = found.entries.toList()
    ..sort((a, b) => a.value.compareTo(b.value));
  final out = <String, ({int start, int end})>{};
  for (var i = 0; i < starts.length; i++) {
    final end = i + 1 < starts.length ? starts[i + 1].value - 1 : lines.length;
    out[starts[i].key] = (start: starts[i].value, end: end);
  }
  return out;
}

/// Line -> hits for `ast_converter.dart`, summed across every hit-map in [dir].
///
/// `dart test --coverage` writes one file per test suite, so a method is
/// exercised if ANY suite reached it; the sum is taken rather than any single
/// file being trusted.
({Map<int, int> hits, String? source}) _coverageFor(
  Directory dir,
  String needle,
) {
  final hits = <int, int>{};
  String? source;
  for (final f in dir.listSync(recursive: true).whereType<File>()) {
    if (!f.path.endsWith('.json')) continue;
    final Map<String, dynamic> decoded;
    try {
      decoded = jsonDecode(f.readAsStringSync()) as Map<String, dynamic>;
    } on FormatException {
      continue; // a suite killed mid-write leaves a truncated file
    }
    for (final entry in (decoded['coverage'] as List? ?? const [])) {
      final e = entry as Map<String, dynamic>;
      final src = e['source'] as String? ?? '';
      if (!src.contains(needle)) continue;
      source ??= src;
      final h = e['hits'] as List? ?? const [];
      for (var i = 0; i + 1 < h.length; i += 2) {
        hits[h[i] as int] = (hits[h[i] as int] ?? 0) + (h[i + 1] as int);
      }
    }
  }
  return (hits: hits, source: source);
}

/// Node types that reach the `_SUnknownNode` fallback for [source].
Set<String> _unknownTypes(String source) {
  final unit = parseString(content: source, throwIfDiagnostics: false).unit;
  final mirror = AstConverter().convertCompilationUnit(unit);
  final seen = <String>{};
  void walk(Object? node) {
    if (node is Map) {
      if (node['nodeType'] == 'Unknown')
        seen.add(node['originalType'] as String);
      node.values.forEach(walk);
    } else if (node is List) {
      node.forEach(walk);
    }
  }

  walk(mirror.toJson());
  return seen;
}

/// One snippet per language construct, used to find unhandled node types.
///
/// Deliberately small and readable rather than exhaustive: a probe that fails
/// to parse proves nothing, so each entry is valid Dart for the SDK in use.
const Map<String, String> _probes = {
  'class type alias': 'class A {} mixin M {} class B = A with M;',
  'extension override': 'extension E on int { int get d => 1; } m() => E(1).d;',
  'pattern for-loop':
      'm(List<(int, int)> l) { for (var (a, b) in l) print(a + b); }',
  'catch clause parameter':
      'm() { try {} on Exception catch (e, s) { print("\$e\$s"); } }',
  'enum with constructor':
      'enum E { a(1), b(2); const E(this.v); final int v; }',
  'record type annotation': '(int, {String s}) m() => (1, s: "x");',
  'record pattern': 'm(Object o) { if (o case (int a, int b)) print(a + b); }',
  'switch expression': 'm(int x) => switch (x) { 1 => "a", _ => "b" };',
  'if-case': 'm(Object o) { if (o case String s) print(s); }',
  'extension type': 'extension type Id(int i) { int get v => i; }',
  'sealed class': 'sealed class S {} class A extends S {} class B extends S {}',
  'generic function type': 'm(T Function<T>(T) f) => f(1);',
  'conditional import': "import 'a.dart' if (dart.library.io) 'b.dart'; m() {}",
  'export with combinators': "export 'a.dart' show A hide B; m() {}",
  'part directive': "part 'a.dart'; m() {}",
  'library directive': 'library foo; m() {}',
  'spread and control-flow collection':
      'm(List l, bool b) => [...l, if (b) 1, for (var x in l) x];',
  'cascade': 'm(List l) => l..add(1)..add(2);',
  'named args and defaults': 'm({int a = 1, required int b}) => a + b;',
  'super parameter': 'class A { A(int x); } class B extends A { B(super.x); }',
  'late final and covariant':
      'class A { late final int x = 1; void m(covariant num n) {} }',
  'typedef (new form)': 'typedef F = int Function(int); m(F f) => f(1);',
  'typedef (old form)': 'typedef int F(int x); m(F f) => f(1);',
  'operator and factory':
      'class A { factory A() => A._(); A._(); A operator +(A o) => this; }',
  'async generator': 'Stream<int> m() async* { yield 1; yield* m(); }',
  'sync generator': 'Iterable<int> m() sync* { yield 1; }',
  'assert with message': 'm(int x) { assert(x > 0, "positive"); }',
  'labeled break and continue': 'm() { outer: for (;;) { break outer; } }',
  'string interpolation and adjacent': r'm(int x) => "a$x" "b";',
  'symbol and type literals': 'm() => [#foo, int];',
  'is/as/throw/rethrow':
      'm(Object o) { try { throw o is int ? o as int : 0; } catch (_) { rethrow; } }',
  'native clause': 'class A { void m() native "impl"; }',
  'dot shorthand': 'enum E { a } E m() { E e = .a; return e; }',
};

/// Resolve a coverage `source` URI to a file on disk.
///
/// A hit-map records `package:tom_ast_generator/src/...`, never a path: the
/// VM reports what the isolate loaded. Resolving it needs the package config
/// of the package whose tests were run, which is the coverage directory's
/// owner -- so the config is looked for beside it, then upward.
File _resolve(String source, Directory coverageDir, String? configPath) {
  final uri = Uri.parse(source);
  if (uri.scheme == 'file') return File.fromUri(uri);
  if (uri.scheme != 'package') return File(source);
  final package = uri.pathSegments.first;
  final rest = uri.pathSegments.skip(1).join('/');
  final candidates = <File>[
    if (configPath != null) File(configPath),
    for (var d = coverageDir.absolute; d.parent.path != d.path; d = d.parent)
      File('${d.path}/.dart_tool/package_config.json'),
  ];
  for (final config in candidates) {
    if (!config.existsSync()) continue;
    final d = config.parent.parent;
    final decoded =
        jsonDecode(config.readAsStringSync()) as Map<String, dynamic>;
    for (final entry in (decoded['packages'] as List)) {
      final p = entry as Map<String, dynamic>;
      if (p['name'] != package) continue;
      // A trailing slash is load-bearing: `Uri.resolve` against a path that
      // does not end in one discards its last segment, which silently turned
      // `.../tom_ast_generator-0.1.7/lib/...` into `.../pub.dev/lib/...`.
      var rootText = p['rootUri'] as String;
      if (!rootText.endsWith('/')) rootText = '$rootText/';
      final rootUri = Uri.parse(rootText);
      final root = rootUri.hasScheme
          ? rootUri
          : Uri.directory('${d.path}/.dart_tool').resolveUri(rootUri);
      var packageUri = p['packageUri'] as String? ?? 'lib/';
      if (!packageUri.endsWith('/')) packageUri = '$packageUri/';
      return File.fromUri(root.resolve(packageUri).resolve(rest));
    }
  }
  return File(source);
}

void main(List<String> args) {
  final root = File('lib/src/converter/ast_converter.dart');
  if (!root.existsSync()) {
    stderr.writeln('run from the tom_ast_generator package root');
    exit(2);
  }
  final source = root.readAsStringSync();
  final methods = _convertMethods(source);
  final handled = RegExp(
    r'node is analyzer\.([A-Za-z]+)',
  ).allMatches(source).map((m) => m.group(1)!).toSet();

  stdout.writeln('copier census');
  stdout.writeln(
    '  ${methods.length} _convert* methods, '
    '${handled.length} dispatch arms',
  );

  if (args.contains('--probe')) {
    stdout.writeln('\nUNHANDLED NODE TYPES (reach _SUnknownNode)');
    var any = false;
    for (final entry in _probes.entries) {
      final Set<String> unknown;
      try {
        unknown = _unknownTypes(entry.value);
      } catch (e) {
        stdout.writeln('  ${entry.key}: PROBE FAILED ($e)');
        any = true;
        continue;
      }
      if (unknown.isEmpty) continue;
      any = true;
      stdout.writeln(
        '  ${entry.key}: ${(unknown.toList()..sort()).join(', ')}',
      );
    }
    if (!any)
      stdout.writeln('  none -- every probe converted without a placeholder');
  }

  final covIndex = args.indexOf('--coverage');
  if (covIndex >= 0 && covIndex + 1 < args.length) {
    final dir = Directory(args[covIndex + 1]);
    if (!dir.existsSync()) {
      stderr.writeln('no such coverage directory: ${dir.path}');
      exit(2);
    }
    final measured = _coverageFor(dir, 'ast_converter.dart');
    final hits = measured.hits;
    if (hits.isEmpty) {
      stderr.writeln(
        '\nNO COVERAGE FOUND for ast_converter.dart in ${dir.path}.\n'
        'That is a measurement failure, not a result of zero: a run that '
        'resolved the copier from a different root, or one killed before it '
        'wrote, looks exactly like a copier nothing exercises.',
      );
      exit(2);
    }
    // SPANS MUST COME FROM THE FILE THE COVERAGE MEASURED, not from the
    // working tree. A hit-map is line-keyed, and exec resolves the copier from
    // the pub cache -- so reading spans from an edited working tree maps hits
    // onto shifted line numbers and reports methods as never-run that ran, and
    // vice versa. The first run of this tool did exactly that and listed
    // `_convertLibraryIdentifier`, a method that did not exist in the copy
    // under test.
    final cfgIndex = args.indexOf('--package-config');
    final measuredFile = _resolve(
      measured.source!,
      dir,
      cfgIndex >= 0 && cfgIndex + 1 < args.length ? args[cfgIndex + 1] : null,
    );
    final measuredMethods = measuredFile.existsSync()
        ? _convertMethods(measuredFile.readAsStringSync())
        : methods;
    if (measuredFile.path != root.absolute.path) {
      stdout.writeln('\n  measured: ${measuredFile.path}');
      stdout.writeln('  (${measuredMethods.length} methods in that copy)');
    }
    final never = <String>[];
    for (final e in measuredMethods.entries) {
      final ran = hits.entries.any(
        (h) => h.key >= e.value.start && h.key <= e.value.end && h.value > 0,
      );
      if (!ran) never.add(e.key);
    }
    stdout.writeln(
      '\nNEVER EXECUTED (${never.length} of ${measuredMethods.length})',
    );
    for (final n in never..sort()) {
      stdout.writeln('  $n');
    }
    stdout.writeln(
      '\n${measuredMethods.length - never.length} of '
      '${measuredMethods.length} methods ran; ${hits.length} lines reached.',
    );
  }
}
