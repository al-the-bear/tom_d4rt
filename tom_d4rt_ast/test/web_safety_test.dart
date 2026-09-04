// DFUB12: the public `d4rt.dart` barrel must be importable from web.
//
// `d4rt.dart`'s own header promises that "any consumer that only needs to run
// pre-compiled AstBundles (e.g. a Flutter app, including on web) can depend on
// it without pulling in dart:io". This test is what makes that sentence true
// rather than aspirational.
//
// WHY A STATIC IMPORT-GRAPH WALK AND NOT A COMPILE:
// neither `dart compile js` nor `dart compile wasm` rejects a `dart:io` import
// at compile time on the current SDK — both happily produce output for a
// program that imports `dart:io` and only fail at runtime. So "it compiles for
// web" is not a check that can fail, and cannot serve as a regression guard.
// What actually decides whether pub.dev grants the `web` platform badge — and
// whether `flutter build web` works — is the transitive import graph, with
// conditional imports resolved down their `dart.library.html` branch. That is
// exactly what this test walks.
//
// The guard is deliberately at the barrel, not at individual files: files like
// `stdlib/io/file.dart` legitimately import `dart:io` and are unreachable on
// web because `ast_module_loader.dart` swaps in `stdlib_web.dart`. Only
// reachability from the public entry point matters.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('DFUB12: web safety of the public barrels', () {
    test('F-DFUB12-1: dart:io is unreachable from d4rt.dart on web '
        '[2026-07-27]', () {
      final graph = _WebImportGraph.from('lib/d4rt.dart');

      expect(
        graph.dartIoImporters,
        isEmpty,
        reason:
            'These libraries are reachable from package:tom_d4rt_ast/'
            'd4rt.dart when conditional imports resolve to their web branch, '
            'and they import dart:io unconditionally. Put the dart:io usage '
            'behind an `if (dart.library.html)` conditional import (see '
            'utils/file_access/ and security/current_directory_io.dart for the '
            'established shape).\n'
            'Offenders:\n${graph.describeOffenders()}',
      );
    });

    test('F-DFUB12-2: dart:io is unreachable from EVERY public library on web '
        '[2026-07-27]', () {
      // pub.dev grants the `web` platform badge only if *no* public library
      // reaches dart:io — it does not let one clean entry point vouch for the
      // package. So the guard enumerates lib/*.dart rather than naming the two
      // barrels we happened to fix, which also means a new public library
      // cannot regress web support without failing here.
      final publicLibraries =
          Directory('lib')
              .listSync()
              .whereType<File>()
              .map((f) => f.path.replaceAll(r'\', '/'))
              .where((p) => p.endsWith('.dart'))
              .toList()
            ..sort();

      expect(
        publicLibraries,
        isNotEmpty,
        reason: 'the test must be run from the package root',
      );

      final offendersByLibrary = <String, String>{};
      for (final library in publicLibraries) {
        final graph = _WebImportGraph.from(library);
        if (graph.dartIoImporters.isNotEmpty) {
          offendersByLibrary[library] = graph.describeOffenders();
        }
      }

      expect(
        offendersByLibrary,
        isEmpty,
        reason: offendersByLibrary.entries
            .map((e) => '${e.key}:\n${e.value}')
            .join('\n'),
      );
    });

    test('F-DFUB12-3: the walk actually resolves conditional imports to the '
        'web branch [2026-07-27]', () {
      // A self-check on the harness. If conditional resolution silently broke
      // (e.g. the regex stopped matching), every graph would look web-clean
      // and F-DFUB12-1/2 would pass vacuously. The io stdlib is the canonical
      // case: reachable on native, swapped out on web.
      final native = _WebImportGraph.from('lib/runtime.dart', web: false);
      expect(
        native.dartIoImporters,
        isNotEmpty,
        reason:
            'On the NATIVE branch the io stdlib must be reachable — if it '
            'is not, the walk is not following imports at all and the web '
            'assertions prove nothing.',
      );
      expect(
        native.dartIoImporters.any((f) => f.contains('stdlib/io/')),
        isTrue,
        reason:
            'stdlib/io/* is the library that must differ between the two '
            'branches',
      );
    });
  });
}

/// Transitive import/export/part graph of a Dart library, resolved the way a
/// compiler for one platform would resolve it.
class _WebImportGraph {
  _WebImportGraph._(this.dartIoImporters, this._parents);

  /// Library files that import `dart:io` and are reachable from the entry
  /// point. Paths are relative to the package root.
  final List<String> dartIoImporters;

  final Map<String, String> _parents;

  static _WebImportGraph from(String entry, {bool web = true}) {
    final seen = <String>{};
    final parents = <String, String>{};
    final offenders = <String>[];
    final queue = <String>[entry];

    while (queue.isNotEmpty) {
      final current = queue.removeLast();
      if (!seen.add(current)) continue;
      // `dart:`/`package:` leaves are not walked — only this package's own
      // sources can be resolved from disk, and a third-party package's
      // platform support is its own problem (and is checked by pub.dev).
      if (current.startsWith('dart:') || current.startsWith('package:')) {
        continue;
      }

      final directives = _directivesOf(current, web: web);
      if (directives.any((d) => d == 'dart:io' || d.startsWith('dart:io/'))) {
        offenders.add(current);
      }
      for (final directive in directives) {
        final resolved = _resolve(current, directive);
        if (!seen.contains(resolved)) {
          parents[resolved] = current;
          queue.add(resolved);
        }
      }
    }

    offenders.sort();
    return _WebImportGraph._(offenders, parents);
  }

  String describeOffenders() {
    if (dartIoImporters.isEmpty) return '(none)';
    final buffer = StringBuffer();
    for (final offender in dartIoImporters) {
      buffer.writeln('  - $offender');
      var node = offender;
      final chain = <String>[];
      while (_parents.containsKey(node) && chain.length < 6) {
        node = _parents[node]!;
        chain.add(node);
      }
      buffer.writeln('      reached via: ${chain.join(' <- ')}');
    }
    return buffer.toString();
  }

  /// `import`/`export` with any number of `if (cond) 'uri'` configurations,
  /// plus `part` directives.
  static final RegExp _importExport = RegExp(
    r"^\s*(?:import|export)\s+'([^']+)'"
    r"((?:\s*if\s*\([^)]*\)\s*'[^']+')*)",
    multiLine: true,
  );
  static final RegExp _configuration = RegExp(
    r"if\s*\(\s*([^)]*?)\s*\)\s*'([^']+)'",
  );
  static final RegExp _part = RegExp(r"^\s*part\s+'([^']+)'", multiLine: true);
  static final RegExp _lineComment = RegExp(r'^\s*//.*$', multiLine: true);

  static List<String> _directivesOf(String path, {required bool web}) {
    final file = File(path);
    if (!file.existsSync()) return const [];
    // Strip line comments so a commented-out or documented `import 'dart:io'`
    // in a doc comment is not mistaken for a real directive.
    final source = file.readAsStringSync().replaceAll(_lineComment, '');

    final result = <String>[];
    for (final match in _importExport.allMatches(source)) {
      var chosen = match.group(1)!;
      if (web) {
        for (final config in _configuration.allMatches(match.group(2) ?? '')) {
          if (config.group(1) == 'dart.library.html') {
            chosen = config.group(2)!;
            break;
          }
        }
      }
      result.add(chosen);
    }
    for (final match in _part.allMatches(source)) {
      result.add(match.group(1)!);
    }
    return result;
  }

  static String _resolve(String from, String uri) {
    if (uri.startsWith('dart:')) return uri;
    const selfPackage = 'package:tom_d4rt_ast/';
    if (uri.startsWith(selfPackage)) {
      return 'lib/${uri.substring(selfPackage.length)}';
    }
    if (uri.startsWith('package:')) return uri;
    final dir = from.contains('/')
        ? from.substring(0, from.lastIndexOf('/'))
        : '.';
    return _normalize('$dir/$uri');
  }

  static String _normalize(String path) {
    final parts = <String>[];
    for (final segment in path.split('/')) {
      if (segment == '.' || segment.isEmpty) continue;
      if (segment == '..') {
        if (parts.isNotEmpty && parts.last != '..') {
          parts.removeLast();
          continue;
        }
      }
      parts.add(segment);
    }
    return parts.join('/');
  }
}
