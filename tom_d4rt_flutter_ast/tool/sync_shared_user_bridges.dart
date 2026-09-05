// ignore_for_file: avoid_print
/// Copy-generator pilot for the AST/non-AST `d4rt_user_bridges/`
/// de-duplication.
///
/// The shared user-bridge files are byte-identical across the two flutter twins
/// **except for a single interpreter-package import line**
/// (`package:tom_d4rt_ast/...` in the AST twin vs `package:tom_d4rt/...` in the
/// source-direct twin). They were previously hand-maintained in both packages.
///
/// **Which files those are is DERIVED, not listed** — see
/// [sharedUserBridgeBasenames]. This header used to name three of them, and the
/// naming was the bug: a fourth (`text_user_bridge.dart`) was duplicated in both
/// packages with the same one-line difference and was in neither the list nor
/// this comment, so the tool reported success without ever looking at it.
///
/// This tool makes the **AST twin the single source-of-truth** and derives the
/// `tom_d4rt_flutter` (non-AST) copies from it by rewriting only the
/// interpreter-package import prefix. Dart's `import x if (...) y` cannot help
/// here: conditional imports branch on `dart.library.*` environment constants,
/// never on which application package (`tom_d4rt` vs `tom_d4rt_ast`) is on the
/// dependency path — so a template + copy-generator is the only viable
/// mechanism (see `../../tom_d4rt/doc/manual_bridge_interventions.md` §1).
///
/// The AST-only `scene_builder_user_bridge.dart` is a legitimate VM↔web
/// divergence (see `manual_bridge_interventions.md` §4.5) and is
/// **deliberately excluded** — it has no non-AST counterpart and must not be
/// synced.
///
/// Run from the `tom_d4rt_flutter_ast` project root:
///   dart run tool/sync_shared_user_bridges.dart          # write the non-AST copies
///   dart run tool/sync_shared_user_bridges.dart --check   # verify in sync (CI)
///
/// `--check` exits non-zero if any non-AST copy has drifted from what the AST
/// source would produce.
///
/// **NOTHING RUNS IT AUTOMATICALLY.** This paragraph used to say that wiring
/// `--check` into CI prevents dual-maintenance creeping back, which reads as a
/// description of the setup and is not one: there is no CI workflow in this
/// repo, and `test/sync_shared_user_bridges_test.dart` — which calls
/// [checkInSync] and is the closest thing to that wiring — is deliberately
/// outside both corpus runners (`run_base_tests.sh` globs
/// `flutter_base_*_test.dart`, `run_issue_analysis_tests.sh` adds
/// `flutter_extended_*`). So the guard is only as good as someone remembering
/// to invoke it. Closing that is SCD108; until then, run it by hand when
/// touching a user bridge.
library;

import 'dart:io';

/// User-bridge basenames deliberately NOT synced even though they exist in
/// BOTH twins.
///
/// Empty, and that is the expected state. An entry here is a claim that two
/// files with the same name are meant to say different things in the two
/// packages — which defeats the de-dup this tool exists to enforce, so it needs
/// a recorded reason next to the name, not just a line.
///
/// This is NOT where `scene_builder_user_bridge.dart` belongs. That file is
/// AST-only (a VM↔web divergence, `manual_bridge_interventions.md` §4.5), so it
/// is absent from the intersection by construction and needs no exclusion. The
/// distinction matters: "exists in one twin" is a fact the filesystem already
/// knows, while "exists in both but must differ" is a human judgement that has
/// to be written down.
const excludedUserBridgeBasenames = <String>{};

/// Basenames of the user-bridge files shared verbatim (modulo the import line)
/// between the two flutter twins — DERIVED from the filesystem, not declared.
///
/// The set is the intersection of the two `d4rt_user_bridges/` directories,
/// minus [excludedUserBridgeBasenames]. A file duplicated across both twins is
/// therefore guarded the moment it appears, rather than when someone remembers
/// to add it to a list.
///
/// **This used to be a hand-written `const` list and the hand-writing is what
/// failed.** `text_user_bridge.dart` sat in both packages for months, differing
/// by exactly the one import line every synced file differs by, and was simply
/// missing from the list — so `--check` reported "in sync" while the two copies
/// were free to drift apart unwatched. Nothing detected it because a membership
/// list maintained alongside the directory it describes cannot notice its own
/// omissions. Deriving the set removes the class of defect instead of the one
/// instance (SCC37).
List<String> sharedUserBridgeBasenames(String astProjectRoot) {
  final dirs = _resolveDirs(astProjectRoot);
  final nonAstNames = _bridgeBasenamesIn(dirs.nonAstDir).toSet();
  return _bridgeBasenamesIn(dirs.astDir)
      .where(nonAstNames.contains)
      .where((name) => !excludedUserBridgeBasenames.contains(name))
      .toList();
}

/// User-bridge basenames present ONLY in the source-direct twin.
///
/// Always expected to be empty. The AST twin is the source of truth, so a user
/// bridge that exists only in `tom_d4rt_flutter` has no upstream to be derived
/// from — it is either a file that belongs in the AST twin and was added to the
/// wrong side, or a deliberate source-direct divergence nobody recorded. Either
/// way the intersection cannot see it, which is precisely the blind spot that
/// motivated deriving the set, so the tool reports it rather than staying quiet.
List<String> orphanedNonAstBasenames(String astProjectRoot) {
  final dirs = _resolveDirs(astProjectRoot);
  final astNames = _bridgeBasenamesIn(dirs.astDir).toSet();
  return _bridgeBasenamesIn(
    dirs.nonAstDir,
  ).where((name) => !astNames.contains(name)).toList();
}

/// The `*_user_bridge.dart` basenames in [dir], sorted for stable output.
List<String> _bridgeBasenamesIn(Directory dir) {
  if (!dir.existsSync()) return const [];
  return dir
      .listSync()
      .whereType<File>()
      .map((f) => f.uri.pathSegments.last)
      .where((name) => name.endsWith('.dart'))
      .toList()
    ..sort();
}

/// The interpreter-package import prefix used by the AST twin's source.
const _astImportPrefix = 'package:tom_d4rt_ast/';

/// The interpreter-package import prefix used by the source-direct twin.
const _nonAstImportPrefix = 'package:tom_d4rt/';

/// Derive the `tom_d4rt_flutter` (non-AST) copy from the AST twin's
/// [astSource], rewriting only the interpreter-package import prefix.
///
/// The rewrite is intentionally narrow — it targets `package:tom_d4rt_ast/`
/// rather than the bare token `tom_d4rt_ast`, so a doc-comment reference to the
/// *flutter* package (`tom_d4rt_flutter_ast/doc/...`, which does **not** contain
/// the substring `tom_d4rt_ast/`) is left untouched in both twins.
String syncAstSourceToNonAst(String astSource) =>
    astSource.replaceAll(_astImportPrefix, _nonAstImportPrefix);

/// Relative path (under each twin's `lib/`) where the shared bridges live.
const _userBridgesRelDir = 'lib/src/d4rt_user_bridges';

/// Resolve the AST and non-AST `d4rt_user_bridges/` directories from the AST
/// project root [astProjectRoot]. The non-AST twin is the sibling package
/// `tom_d4rt_flutter` next to `tom_d4rt_flutter_ast`.
({Directory astDir, Directory nonAstDir}) _resolveDirs(String astProjectRoot) {
  final astDir = Directory('$astProjectRoot/$_userBridgesRelDir');
  final repoRoot = Directory(astProjectRoot).parent.path;
  final nonAstDir = Directory('$repoRoot/tom_d4rt_flutter/$_userBridgesRelDir');
  return (astDir: astDir, nonAstDir: nonAstDir);
}

/// Compare each non-AST copy against what the AST source would produce.
///
/// Returns the basenames that have drifted (empty list ⇒ fully in sync).
List<String> checkInSync(String astProjectRoot) {
  final dirs = _resolveDirs(astProjectRoot);
  final drifted = <String>[];
  for (final name in sharedUserBridgeBasenames(astProjectRoot)) {
    final astFile = File('${dirs.astDir.path}/$name');
    final nonAstFile = File('${dirs.nonAstDir.path}/$name');
    final expected = syncAstSourceToNonAst(astFile.readAsStringSync());
    final actual = nonAstFile.existsSync() ? nonAstFile.readAsStringSync() : '';
    if (expected != actual) drifted.add(name);
  }
  return drifted;
}

void main(List<String> args) {
  final checkOnly = args.contains('--check');
  final astProjectRoot = Directory.current.path;
  final dirs = _resolveDirs(astProjectRoot);

  if (!dirs.astDir.existsSync()) {
    stderr.writeln(
      'Error: AST user-bridges dir not found: ${dirs.astDir.path}',
    );
    stderr.writeln('Run from the tom_d4rt_flutter_ast project root.');
    exitCode = 1;
    return;
  }
  if (!dirs.nonAstDir.existsSync()) {
    stderr.writeln(
      'Error: non-AST user-bridges dir not found: ${dirs.nonAstDir.path}',
    );
    exitCode = 1;
    return;
  }

  final shared = sharedUserBridgeBasenames(astProjectRoot);

  // Reported in both modes, and never fatal on its own: an orphan is a question
  // about where a file belongs, not a drift between two copies. Staying silent
  // is what let the missing-membership defect live, so an anomaly the
  // intersection cannot cover gets said out loud.
  final orphans = orphanedNonAstBasenames(astProjectRoot);
  if (orphans.isNotEmpty) {
    stderr.writeln(
      'WARNING: ${orphans.length} user bridge(s) exist only in '
      'tom_d4rt_flutter, so they have no AST source to derive from:',
    );
    for (final name in orphans) {
      stderr.writeln('  - $name');
    }
    stderr.writeln(
      'Move each into tom_d4rt_flutter_ast (the source-of-truth) or record '
      'why it is source-direct only.',
    );
  }

  if (checkOnly) {
    final drifted = checkInSync(astProjectRoot);
    if (drifted.isEmpty) {
      print(
        'In sync: all ${shared.length} shared user bridges match the AST '
        'source-of-truth.',
      );
    } else {
      stderr.writeln(
        'DRIFT: ${drifted.length} non-AST user bridge(s) differ '
        'from the AST source-of-truth:',
      );
      for (final name in drifted) {
        stderr.writeln('  - $name');
      }
      stderr.writeln(
        'Run `dart run tool/sync_shared_user_bridges.dart` to '
        'regenerate them.',
      );
      exitCode = 1;
    }
    return;
  }

  for (final name in shared) {
    final astFile = File('${dirs.astDir.path}/$name');
    final nonAstFile = File('${dirs.nonAstDir.path}/$name');
    final generated = syncAstSourceToNonAst(astFile.readAsStringSync());
    final unchanged =
        nonAstFile.existsSync() && nonAstFile.readAsStringSync() == generated;
    nonAstFile.writeAsStringSync(generated);
    print('${unchanged ? '  (unchanged) ' : '  wrote       '}$name');
  }
  print(
    'Synced ${shared.length} shared user bridges from the AST '
    'source-of-truth into tom_d4rt_flutter.',
  );
}
