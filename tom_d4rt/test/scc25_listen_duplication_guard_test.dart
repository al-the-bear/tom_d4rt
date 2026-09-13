// SCC25's source-level half — the two guards that read the stdlib trees rather
// than running a script.
//
// SPLIT OUT OF `scc25_listen_adapter_test.dart` BY SCD79, and the reason is
// about where each half can live rather than about what either asserts.
//
// The behavioural five drive a script through `listen(null)` on every bridge
// that has one, and they pass in `tom_d4rt_exec` too — measured against
// published `tom_d4rt_ast` 0.65.0. These two cannot: they resolve
// `lib/src/stdlib` and `../tom_d4rt_ast/lib/src/runtime/stdlib` RELATIVE TO THE
// PACKAGE THEY RUN IN, and from exec that is exec's own `lib`, which carries no
// stdlib and no listen adapters at all. Ported, they would fail against a
// subject they were never written about.
//
// SCD157 decided to take the subtraction port. The obvious way to do that — port
// the file minus this group and record a `_divergentBaseline` entry — was
// declined in favour of this split, because such an entry is a BLANKET: per
// SCD154 it then absorbs every future divergence in the file, including drift in
// the five behavioural cases the port exists to gain. `conformance_drift_test`'s
// own `_Divergence.necessary` doc says as much — "where the exec-only coverage is
// separable, prefer splitting it into its own file over claiming this category".
// Here it is the REFERENCE-only coverage that is separable, which is the same
// move in the other direction.
//
// So `scc25_listen_adapter_test.dart` is now a verbatim port on both sides and
// stays under F-SCC6-4's content guard, and what carries an `_uncoveredBaseline`
// entry is this two-case file, whose un-portability is a property of what it
// reads rather than a cost anyone pays.
//
// WHY THE SOURCE GUARDS EXIST AT ALL. Behavioural tests pin what the adapters do
// today, but SCC25's defect is structural: the next `listen` adapter someone adds
// will be a tenth copy, and no behavioural test can fail for code that does not
// exist yet. SCB9 is the precedent — fourteen sites for a one-line fix, found by
// grep. These two fail when a new private `_runAction` appears or when an adapter
// builds its own wrapper trio, which is the moment the cost is one edit rather
// than fourteen.
//
// They also cover the four bridges the behavioural half cannot reach —
// RawSocket, RawServerSocket, Stdin and the second HttpClient site — for the
// reasons `scc22_io_error_handler_arity_test.dart`'s header records.
library;

import 'dart:io';

import 'package:test/test.dart';

/// `lib/src/stdlib` in each tree.
///
/// Both trees are swept from this one suite, following the precedent
/// F-SCC22-11/-12 set: `tom_d4rt_ast` has no parser, so it cannot run the
/// script cases above, and a guard that only watched the tree it lives in would
/// let the duplication grow back in the other half of the mirror unnoticed.
/// The two packages always sit side by side in the `tom_d4rt` repo, which is
/// what makes the relative path work.
const _stdlibRoots = <String, String>{
  'tom_d4rt': 'lib/src/stdlib',
  'tom_d4rt_ast': '../tom_d4rt_ast/lib/src/runtime/stdlib',
};

/// The files that carry a `listen` adapter, relative to a tree's stdlib root.
///
/// Listed rather than globbed: a glob would silently start passing if a file
/// were renamed, and the point of the guard is to notice exactly that kind of
/// move.
const _listenAdapterFiles = <String>[
  'async/stream.dart',
  'io/socket.dart',
  'io/stdio.dart',
  'io/http.dart',
];

/// Every stdlib file under [root], for the `_runAction` uniqueness guard.
List<File> _allStdlibSources(String root) {
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
      .where((f) => f.path.endsWith('.dart'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
}

void main() {
  group('SCC25: the duplication cannot grow back', () {
    test('F-SCC25-6: `_runAction` is not redefined privately in any stdlib file '
        '[2026-09-04]', () {
      // Before the fix there were four private definitions in two different
      // shapes: `T? _runAction<T>` in io/socket.dart and
      // typed_data/uint8_list.dart, `FutureOr<T> _runAction<T>` in
      // async/stream.dart and async/stream_controller.dart. They differ only
      // when the function is null and T is non-nullable, where the FutureOr
      // form throws and the nullable form returns null — a divergence no call
      // site relied on, since none of the 84 of them ever awaits the result.
      //
      // The guard is on the *definition*, not on the call: call sites should
      // keep using the helper freely.
      // Comment lines are skipped deliberately: `run_action.dart` documents the
      // two shapes it replaced by quoting their signatures, and a guard that
      // cannot tell a definition from a description of one would make the
      // explanation unwritable.
      final offenders = <String>[];
      for (final root in _stdlibRoots.entries) {
        for (final file in _allStdlibSources(root.value)) {
          final lines = file.readAsLinesSync();
          for (var i = 0; i < lines.length; i++) {
            final line = lines[i];
            if (line.trimLeft().startsWith('//')) continue;
            if (RegExp(r'\b_runAction<T>\s*\(').hasMatch(line)) {
              offenders.add('${root.key}: ${file.path}:${i + 1}');
            }
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'A private `_runAction` has reappeared. Use the shared '
            '`runAction` from lib/src/stdlib/run_action.dart instead — a '
            'second copy is how SCB9 turned into a fourteen-site fix.',
      );
    });

    test('F-SCC25-7: no listen adapter builds its own onError/onDone wrapper '
        'trio [2026-09-04]', () {
      // The onError and onDone wrappers were the genuinely identical part of
      // the nine copies — byte-for-byte the same in all six that had them,
      // including the `onErrorWrapper` / `onDoneWrapper` names. That is the
      // duplication the shared adapter removes, so its return is what this
      // guard watches for.
      final offenders = <String>[];
      for (final root in _stdlibRoots.entries) {
        for (final relative in _listenAdapterFiles) {
          final path = '${root.value}/$relative';
          final lines = File(path).readAsLinesSync();
          for (var i = 0; i < lines.length; i++) {
            if (lines[i].contains('onErrorWrapper') ||
                lines[i].contains('onDoneWrapper')) {
              offenders.add('${root.key}: $path:${i + 1}');
            }
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'A listen adapter is building its own callback wrappers '
            'again. Call `bridgedStreamListen` from '
            'lib/src/stdlib/stream_listen.dart — it already handles the '
            'error-handler arity that SCB9 had to fix in fourteen places.',
      );
    });
  });
}
