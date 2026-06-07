/// Tests for the AST/non-AST user-bridge copy-generator pilot
/// (`tool/sync_shared_user_bridges.dart`, MCI#9 / clean_todos #6 step 2).
///
/// Pin: the import-prefix rewrite is narrow (only `package:tom_d4rt_ast/` is
/// touched, never the `tom_d4rt_flutter_ast/doc/...` doc reference); the rewrite
/// is idempotent on already-non-AST source; the AST-only
/// `scene_builder_user_bridge.dart` web divergence is excluded from the shared
/// set; and the three committed non-AST copies reproduce byte-for-byte from the
/// AST source-of-truth (the de-dup safety property — no behavioural change).
///
/// Pure file I/O only (no HTTP companion app), so this file is safe to run on
/// its own; it is NOT part of the serial corpus.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../tool/sync_shared_user_bridges.dart';

void main() {
  group('syncAstSourceToNonAst (MCI#9 user-bridge pilot)', () {
    test('SYNC-UB-1: rewrites the interpreter-package import prefix. [2026-06-07 00:00] (PASS)', () {
      const ast = "import 'package:tom_d4rt_ast/d4rt.dart';\n";
      expect(
        syncAstSourceToNonAst(ast),
        equals("import 'package:tom_d4rt/d4rt.dart';\n"),
      );
    });

    test('SYNC-UB-2: leaves the tom_d4rt_flutter_ast doc reference untouched. [2026-06-07 00:00] (PASS)', () {
      // The flutter-package doc ref does NOT contain the `package:tom_d4rt_ast/`
      // prefix, so the narrow rewrite must not corrupt it.
      const ast =
          "/// See `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md`.\n"
          "import 'package:tom_d4rt_ast/d4rt.dart';\n";
      const expected =
          "/// See `tom_d4rt_flutter_ast/doc/interpreter_unfixable.md`.\n"
          "import 'package:tom_d4rt/d4rt.dart';\n";
      expect(syncAstSourceToNonAst(ast), equals(expected));
    });

    test('SYNC-UB-3: is idempotent on already-non-AST source. [2026-06-07 00:00] (PASS)', () {
      const nonAst = "import 'package:tom_d4rt/d4rt.dart';\n// body\n";
      expect(syncAstSourceToNonAst(nonAst), equals(nonAst));
    });

    test('SYNC-UB-4: the AST-only scene_builder web divergence is excluded. [2026-06-07 00:00] (PASS)', () {
      expect(
        sharedUserBridgeBasenames,
        isNot(contains('scene_builder_user_bridge.dart')),
      );
      expect(sharedUserBridgeBasenames, hasLength(3));
    });
  });

  group('checkInSync against the committed files (MCI#9 user-bridge pilot)', () {
    test('SYNC-UB-5: the committed non-AST copies reproduce byte-for-byte from the AST source. [2026-06-07 00:00] (PASS)', () {
      // Under `flutter test`, CWD is the package root (tom_d4rt_flutter_ast).
      final astRoot = Directory.current.path;
      final drifted = checkInSync(astRoot);
      expect(
        drifted,
        isEmpty,
        reason: 'non-AST user bridges drifted from the AST source-of-truth: '
            '$drifted — run `dart run tool/sync_shared_user_bridges.dart`',
      );
    });
  });
}
