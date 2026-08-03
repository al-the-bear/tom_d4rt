// ignore_for_file: avoid_print
/// Copy-generator pilot for the AST/non-AST `d4rt_user_bridges/`
/// de-duplication.
///
/// The three shared user-bridge files
/// (`basic_message_channel_user_bridge.dart`, `state_user_bridge.dart`,
/// `strut_style_user_bridge.dart`) are byte-identical across the two flutter
/// twins **except for a single interpreter-package import line**
/// (`package:tom_d4rt_ast/...` in the AST twin vs `package:tom_d4rt/...` in the
/// source-direct twin). They were previously hand-maintained in both packages.
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
/// source would produce — wiring it into CI prevents the dual-maintenance the
/// de-dup removes from silently creeping back.
library;

import 'dart:io';

/// Basenames of the user-bridge files shared verbatim (modulo the import line)
/// between the two flutter twins. `scene_builder_user_bridge.dart` is
/// intentionally absent — it is an AST-only web divergence to preserve.
const sharedUserBridgeBasenames = <String>[
  'basic_message_channel_user_bridge.dart',
  'state_user_bridge.dart',
  'strut_style_user_bridge.dart',
];

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
  final nonAstDir =
      Directory('$repoRoot/tom_d4rt_flutter/$_userBridgesRelDir');
  return (astDir: astDir, nonAstDir: nonAstDir);
}

/// Compare each non-AST copy against what the AST source would produce.
///
/// Returns the basenames that have drifted (empty list ⇒ fully in sync).
List<String> checkInSync(String astProjectRoot) {
  final dirs = _resolveDirs(astProjectRoot);
  final drifted = <String>[];
  for (final name in sharedUserBridgeBasenames) {
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
    stderr.writeln('Error: AST user-bridges dir not found: ${dirs.astDir.path}');
    stderr.writeln('Run from the tom_d4rt_flutter_ast project root.');
    exitCode = 1;
    return;
  }
  if (!dirs.nonAstDir.existsSync()) {
    stderr.writeln(
        'Error: non-AST user-bridges dir not found: ${dirs.nonAstDir.path}');
    exitCode = 1;
    return;
  }

  if (checkOnly) {
    final drifted = checkInSync(astProjectRoot);
    if (drifted.isEmpty) {
      print('In sync: all ${sharedUserBridgeBasenames.length} shared user '
          'bridges match the AST source-of-truth.');
    } else {
      stderr.writeln('DRIFT: ${drifted.length} non-AST user bridge(s) differ '
          'from the AST source-of-truth:');
      for (final name in drifted) {
        stderr.writeln('  - $name');
      }
      stderr.writeln('Run `dart run tool/sync_shared_user_bridges.dart` to '
          'regenerate them.');
      exitCode = 1;
    }
    return;
  }

  for (final name in sharedUserBridgeBasenames) {
    final astFile = File('${dirs.astDir.path}/$name');
    final nonAstFile = File('${dirs.nonAstDir.path}/$name');
    final generated = syncAstSourceToNonAst(astFile.readAsStringSync());
    final unchanged =
        nonAstFile.existsSync() && nonAstFile.readAsStringSync() == generated;
    nonAstFile.writeAsStringSync(generated);
    print('${unchanged ? '  (unchanged) ' : '  wrote       '}$name');
  }
  print('Synced ${sharedUserBridgeBasenames.length} shared user bridges from '
      'the AST source-of-truth into tom_d4rt_flutter.');
}
