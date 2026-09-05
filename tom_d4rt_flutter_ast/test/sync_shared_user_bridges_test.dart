/// Tests for the AST/non-AST user-bridge copy-generator pilot
/// (`tool/sync_shared_user_bridges.dart`).
///
/// Pin: the import-prefix rewrite is narrow (only `package:tom_d4rt_ast/` is
/// touched, never the `tom_d4rt_flutter_ast/doc/...` doc reference); the rewrite
/// is idempotent on already-non-AST source; the AST-only
/// `scene_builder_user_bridge.dart` web divergence is excluded from the shared
/// set; and the committed non-AST copies reproduce byte-for-byte from the AST
/// source-of-truth (the de-dup safety property — no behavioural change).
///
/// SYNC-UB-6 and -7 pin MEMBERSHIP, and they exist because the membership was
/// the part that broke. The old guard asserted the shared set had three
/// entries; a count passes just as happily with a fourth duplicated file
/// sitting unsynced next to it, which is what `text_user_bridge.dart` did.
/// Both new cases assert properties of the directories instead — everything
/// duplicated is covered, nothing lives only in the source-direct twin — so
/// they keep holding as bridges are added and cannot be satisfied by a stale
/// number (SCC37).
///
/// Pure file I/O only (no HTTP companion app), so this file is safe to run on
/// its own; it is NOT part of the serial corpus.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../tool/sync_shared_user_bridges.dart';

void main() {
  group('syncAstSourceToNonAst (shared user-bridge pilot)', () {
    test(
      'SYNC-UB-1: rewrites the interpreter-package import prefix. [2026-06-07 00:00] (PASS)',
      () {
        const ast = "import 'package:tom_d4rt_ast/d4rt.dart';\n";
        expect(
          syncAstSourceToNonAst(ast),
          equals("import 'package:tom_d4rt/d4rt.dart';\n"),
        );
      },
    );

    test(
      'SYNC-UB-2: leaves the tom_d4rt_flutter_ast doc reference untouched. [2026-06-07 00:00] (PASS)',
      () {
        // The flutter-package doc ref does NOT contain the `package:tom_d4rt_ast/`
        // prefix, so the narrow rewrite must not corrupt it.
        const ast =
            "/// See `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md`.\n"
            "import 'package:tom_d4rt_ast/d4rt.dart';\n";
        const expected =
            "/// See `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md`.\n"
            "import 'package:tom_d4rt/d4rt.dart';\n";
        expect(syncAstSourceToNonAst(ast), equals(expected));
      },
    );

    test(
      'SYNC-UB-3: is idempotent on already-non-AST source. [2026-06-07 00:00] (PASS)',
      () {
        const nonAst = "import 'package:tom_d4rt/d4rt.dart';\n// body\n";
        expect(syncAstSourceToNonAst(nonAst), equals(nonAst));
      },
    );

    test(
      'SYNC-UB-4: the AST-only scene_builder web divergence is excluded. [2026-06-07 00:00] (PASS)',
      () {
        expect(
          sharedUserBridgeBasenames(Directory.current.path),
          isNot(contains('scene_builder_user_bridge.dart')),
        );
      },
    );

    test(
      'SYNC-UB-6: every user bridge present in BOTH twins is covered. [2026-09-05 00:00] (PASS)',
      () {
        // THE CASE THAT WAS MISSING, and its absence is why SCC37 existed. The
        // old SYNC-UB-4 asserted the set had exactly three entries — a count,
        // which stays green while a fourth duplicated file sits unguarded beside
        // it. `text_user_bridge.dart` did exactly that for months.
        //
        // Assert the PROPERTY instead: whatever is duplicated is covered. This
        // cannot go stale as bridges are added, and it fails the moment a new
        // duplicate escapes the sync.
        final astRoot = Directory.current.path;
        final astNames = _bridgeNamesIn('$astRoot/lib/src/d4rt_user_bridges');
        final nonAstNames = _bridgeNamesIn(
          '${Directory(astRoot).parent.path}/tom_d4rt_flutter'
          '/lib/src/d4rt_user_bridges',
        );
        final duplicated = astNames.intersection(nonAstNames);

        expect(
          duplicated,
          isNotEmpty,
          reason:
              'the twins share no user bridges at all — either the paths '
              'moved or the de-dup regressed; either way the guard below would '
              'pass vacuously',
        );

        // Asserted SEPARATELY, and not folded into the comparison below. Writing
        // `equals(duplicated.difference(excluded))` reads as the more general
        // guard and is in fact a tautology: both sides subtract the same set, so
        // excluding a file moves them together and the case stays green. Measured
        // — that version passed with `text_user_bridge.dart` excluded, which is
        // the exact defect SCC37 was about.
        //
        // So the escape hatch has to cost something. An exclusion turns the next
        // assertion red, and the only way through is to edit this test and say
        // which file is exempt and why.
        expect(
          excludedUserBridgeBasenames,
          isEmpty,
          reason:
              'a user bridge has been marked exempt from the sync. That is a '
              'claim that two same-named files must say different things in the '
              'two twins — record the reason here and in the const before '
              'relaxing this',
        );
        expect(
          sharedUserBridgeBasenames(astRoot).toSet(),
          equals(duplicated),
          reason: 'a user bridge exists in both twins but is not synced',
        );
      },
    );

    test(
      'SYNC-UB-7: no user bridge exists only in the source-direct twin. [2026-09-05 00:00] (PASS)',
      () {
        // The AST twin is the source of truth, so a bridge that lives only in
        // `tom_d4rt_flutter` has nothing to be derived from and the intersection
        // cannot see it. That is the one blind spot deriving the set does NOT
        // close, so it gets its own assertion rather than a comment.
        expect(
          orphanedNonAstBasenames(Directory.current.path),
          isEmpty,
          reason:
              'move it into tom_d4rt_flutter_ast, or record why it is '
              'source-direct only',
        );
      },
    );
  });

  group('checkInSync against the committed files (shared user-bridge pilot)', () {
    test(
      'SYNC-UB-5: the committed non-AST copies reproduce byte-for-byte from the AST source. [2026-06-07 00:00] (PASS)',
      () {
        // Under `flutter test`, CWD is the package root (tom_d4rt_flutter_ast).
        final astRoot = Directory.current.path;
        final drifted = checkInSync(astRoot);
        expect(
          drifted,
          isEmpty,
          reason:
              'non-AST user bridges drifted from the AST source-of-truth: '
              '$drifted — run `dart run tool/sync_shared_user_bridges.dart`',
        );
      },
    );
  });
}

/// Enumerate `*.dart` basenames under [dirPath].
///
/// Deliberately a SECOND implementation rather than a call into the tool's own
/// `_bridgeBasenamesIn`. SYNC-UB-6 asks whether the tool's derived set matches
/// what is actually on disk; deriving both sides with the same private helper
/// would make that assertion true by construction and pin nothing.
Set<String> _bridgeNamesIn(String dirPath) {
  final dir = Directory(dirPath);
  if (!dir.existsSync()) return {};
  return dir
      .listSync()
      .whereType<File>()
      .map((f) => f.uri.pathSegments.last)
      .where((name) => name.endsWith('.dart'))
      .toSet();
}
