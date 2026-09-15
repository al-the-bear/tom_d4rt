// REPO-WIDE GUARD (tom_d4rt) — both stdlib trees route every error-handler adapter through the one helper, and declare the same sites.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
// SCC22's source-level half — the three guards that READ the stdlib trees
// rather than running a script.
//
// SPLIT OUT OF `scc22_io_error_handler_arity_test.dart` BY SCD157, following the
// form SCD79 used for SCC25's twin. The reason is about where each half can
// live, not about what either asserts.
//
// The fourteen behavioural cases drive real sockets and HTTP responses through
// a permissioned script, and they pass in `tom_d4rt_exec` too — measured
// against published `tom_d4rt_ast` 0.65.0, 14 of 17. These three cannot: they
// resolve `lib/src/stdlib` and `../tom_d4rt_ast/lib/src/runtime/stdlib`
// RELATIVE TO THE PACKAGE THEY RUN IN, and from exec that is exec's own `lib`,
// which carries no stdlib adapters at all. Ported, they would fail against a
// subject they were never written about — which is SCD158's subject in general
// and this file's reason to exist in particular.
//
// WHY NOT A `_divergentBaseline` ENTRY, which is what SCD157 originally priced.
// Such an entry is keyed by PATH, so it exempts its file from drift wholesale —
// SCD154 narrowed that to a fingerprint of the sanctioned difference, but the
// entry still has to be re-blessed by hand every time the file legitimately
// changes, and it would sit over exactly the fourteen behavioural cases the
// port exists to gain. `conformance_drift_test`'s own `_Divergence.necessary`
// doc recommends the alternative — "where the exec-only coverage is separable,
// prefer splitting it into its own file over claiming this category". Here it
// is the REFERENCE-only coverage that is separable, which is the same move
// mirrored, and it costs one `_uncoveredBaseline` pin on a file whose
// un-portability is a property of what it reads rather than a cost anyone pays.
//
// THE SPLIT WAS MORE SURGERY THAN SCC25'S. That group sat at the end of its
// file; this one sat BETWEEN two behavioural groups, and the eight helpers it
// needs (`_expectedSites`, `_stdlibRoots`, the two patterns, `_sitesIn`,
// `_enclosingTopLevelFunction`, `_stdlibFiles`, `_siteMap`) were declared above
// the behavioural half. Measured before cutting: every use of all eight is
// inside this group, so the move is a lift rather than a duplication.
//
// WHY THE SOURCE GUARDS EXIST AT ALL. The behavioural fourteen pin what three
// reachable adapters do; SCB9's defect was in fifteen, and six of the sites no
// script can reach at all. These three fail when a hardcoded `[error,
// stackTrace]` pair reappears anywhere in either stdlib, when an adapter stops
// routing through `errorHandlerArgs`, and when the two trees stop declaring the
// same sites — none of which any behavioural case can observe.
@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

// ---------------------------------------------------------------------------
// Structural sweep
// ---------------------------------------------------------------------------

/// The adapters that hand an error to a script-supplied handler, by the stdlib
/// file they live in and the `Class.member` they implement.
///
/// This is the whole set SCB9 fixed, not just the io part: a guard that only
/// listed the io sites would go quiet the moment someone reintroduced the bug
/// in `async/`, which is where it was originally reported.
///
/// **SCC25 changed this map deliberately, and shrank it from 15 entries to 7.**
/// SCB9's 15 sites included nine `listen` adapters that were near-copies of one
/// another; SCC25 collapsed all nine into the single `bridgedStreamListen` in
/// `stream_listen.dart`, so they no longer call `errorHandlerArgs` themselves.
/// The nine did not lose their guarantee — they inherit it from the one place
/// that now implements it, which is a stronger arrangement than nine
/// independent copies each asserted separately. What this map protects after
/// SCC25 is the six adapters that are genuinely their own code plus the shared
/// helper; the *shape* of the collapse is pinned separately by F-SCC25-7, which
/// fails if a `listen` adapter starts building its own wrappers again.
const _expectedSites = <String, List<String>>{
  'async/future.dart': ['Future.then', 'Future.catchError', 'Future.onError'],
  'async/stream.dart': ['Stream.handleError', 'StreamSubscription.onError'],
  'io/socket.dart': ['Socket.handleError'],
  'stream_listen.dart': ['bridgedStreamListen'],
};

/// `lib/src/stdlib` in each tree. The two packages always sit side by side in
/// the `tom_d4rt` repo, which is what makes the convergence check in
/// F-SCC22-12 possible at all.
const _stdlibRoots = <String, String>{
  'tom_d4rt': 'lib/src/stdlib',
  'tom_d4rt_ast': '../tom_d4rt_ast/lib/src/runtime/stdlib',
};

final _memberPattern = RegExp(r"^\s*'(\w+)':\s*\(visitor");
final _classPattern = RegExp(r"^\s*name:\s*'(\w+)'");

/// The `Class.member` of every adapter in [file] that calls `errorHandlerArgs`.
///
/// Read structurally rather than by parsing: the bridge definitions are nested
/// map literals, so the enclosing class and member are found by scanning back
/// from the call for the nearest `'member': (visitor` and then the nearest
/// `name: 'Class'`. Both spellings are uniform across every stdlib file in both
/// trees, which is what makes the scan reliable.
List<String> _sitesIn(File file) {
  final lines = file.readAsLinesSync();
  final sites = <String>[];
  for (var i = 0; i < lines.length; i++) {
    if (!lines[i].contains('errorHandlerArgs(')) continue;
    String? member;
    String? className;
    for (var j = i; j >= 0; j--) {
      member ??= _memberPattern.firstMatch(lines[j])?.group(1);
      final cls = _classPattern.firstMatch(lines[j])?.group(1);
      if (cls != null) {
        className = cls;
        break;
      }
    }
    if (className != null) {
      sites.add('$className.${member ?? '<no member>'}');
      continue;
    }
    // No enclosing bridge class: the call is in a shared helper, which since
    // SCC25 is where nine of the fifteen original sites live. Name it by its
    // top-level function so a failure still says *what* stopped calling the
    // helper rather than `<no class>`.
    sites.add(_enclosingTopLevelFunction(lines, i) ?? '<no class>.<no member>');
  }
  return sites;
}

/// The name of the top-level function containing line [from], scanning back for
/// the nearest declaration that starts in column 0 and takes a parameter list.
String? _enclosingTopLevelFunction(List<String> lines, int from) {
  final declaration = RegExp(r'^[\w<>?,\s]*?(\w+)\s*\($');
  for (var i = from; i >= 0; i--) {
    if (lines[i].startsWith(' ') || lines[i].startsWith('//')) continue;
    final match = declaration.firstMatch(lines[i].trimRight());
    if (match != null) return match.group(1);
  }
  return null;
}

/// Every `.dart` file under [root], excluding the helper itself.
List<File> _stdlibFiles(String root) {
  final dir = Directory(root);
  if (!dir.existsSync()) {
    fail(
      'stdlib root "$root" does not exist — run this from the package root, '
      'with both packages checked out side by side.',
    );
  }
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where(
        (f) =>
            f.path.endsWith('.dart') &&
            !f.path.endsWith('error_handler_args.dart'),
      )
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
}

/// The full `{relative file: [sites]}` map for one tree.
Map<String, List<String>> _siteMap(String root) {
  final result = <String, List<String>>{};
  for (final file in _stdlibFiles(root)) {
    final sites = _sitesIn(file);
    if (sites.isEmpty) continue;
    result[file.path.substring(root.length + 1)] = sites;
  }
  return result;
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage('tom_d4rt', subject: 'both stdlib trees under lib/src/stdlib');

  group('SCC22: the sites no script can reach are guarded structurally', () {
    test('F-SCC22-10: the only hardcoded [error, stackTrace] pair in the stdlib '
        'is the one inside errorHandlerArgs [2026-09-04]', () {
      // The regression SCB9 fixed, stated as an invariant. Every adapter used
      // to build this pair itself; the helper is now the only place allowed to,
      // because it is the only place that first asks how many parameters the
      // script's handler declared.
      for (final entry in _stdlibRoots.entries) {
        final offenders = <String>[];
        for (final file in _stdlibFiles(entry.value)) {
          final lines = file.readAsLinesSync();
          for (var i = 0; i < lines.length; i++) {
            if (RegExp(
              r'\[\s*\w*[Ee]rror\w*\s*,\s*\w*[Ss]tack\w*\s*\]',
            ).hasMatch(lines[i])) {
              offenders.add('${entry.key}: ${file.path}:${i + 1}');
            }
          }
        }
        expect(
          offenders,
          isEmpty,
          reason:
              'a two-argument error-handler call was hardcoded again — '
              'route it through errorHandlerArgs instead',
        );
      }
    });

    test('F-SCC22-11: every error-handler adapter still routes through the '
        'helper, in both trees [2026-09-04]', () {
      // Named per site rather than counted, so a failure says *which* adapter
      // stopped calling the helper.
      //
      // The set was 15 until SCC25 collapsed the nine `listen` adapters into
      // `bridgedStreamListen`. The six that had no behavioural case anywhere in
      // the corpus — ServerSocket.listen, RawSocket.listen,
      // RawServerSocket.listen, RawDatagramSocket.listen, HttpServer.listen and
      // Stdin.listen — were all `listen` adapters, so they are now covered by
      // whatever covers the shared one, which includes F-SCB9-1..3 and
      // F-SCC22-1..3. That is the substantive gain from the de-duplication: the
      // sites a test cannot reach stopped being separate code.
      for (final entry in _stdlibRoots.entries) {
        expect(
          _siteMap(entry.value),
          equals(_expectedSites),
          reason:
              '${entry.key}: the set of adapters calling '
              'errorHandlerArgs changed',
        );
      }
    });

    test('F-SCC22-12: the two trees declare the same sites, so the fix cannot '
        'drift out of one of them [2026-09-04]', () {
      // The mirror rule as an assertion. SCB9 landed in both trees by hand;
      // nothing until now would have noticed a later edit reaching only one.
      expect(
        _siteMap(_stdlibRoots['tom_d4rt_ast']!),
        equals(_siteMap(_stdlibRoots['tom_d4rt']!)),
      );
    });
  });
}
