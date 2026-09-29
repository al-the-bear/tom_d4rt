// SCC92: the tom_d4rt <-> tom_d4rt_ast mirror rule, enforced.
//
// The quest's standing rule is that an interpreter fix lands in BOTH trees.
// Nothing checked it, so a one-sided fix analyzed clean, passed both suites,
// and surfaced only when somebody next read the two files side by side. This
// tool is that check; `test/runtime/mirrored_sources_test.dart` runs it.
//
//     dart run tool/check_mirrored_sources.dart            # report and exit
//     dart run tool/check_mirrored_sources.dart --verbose  # with the diffs
//     dart run tool/check_mirrored_sources.dart --show <path>   # one pair,
//                                                              # in full
//
// WHY IT COMPARES CODE AND NOT TEXT. The todo that filed this proposed a
// derivation tool — generate one tree's copy from the other, as
// `tom_d4rt_flutter_ast/tool/sync_shared_user_bridges.dart` does for the
// Flutter twins. Measured, that is wrong here. The Flutter pairs differ by
// exactly one import line, so generating one from the other loses nothing.
// These pairs differ in PROSE on purpose: `unbridged_reasons.dart` documents a
// doc-derived pin in `tom_d4rt` and a registry-derived one here, because those
// are genuinely different pins. A generator would overwrite that with the other
// tree's comment and delete information somebody wrote deliberately.
//
// So the comparison strips comments and normalises the two package layouts,
// and what must match is the CODE. Prose stays per-tree, which is what it is
// for.
import 'dart:io';

// The rename map SCD199 already applies per member body. It is plain
// `dart:io` and reads `../tom_ast_model/lib`, which is a sibling of both
// packages, so the relative path is right from either root and this tool
// keeps zero dependencies.
import '../../tom_d4rt/test/mirror_normalisation.dart';

/// Where the two trees keep the sources that must agree.
const String kReferenceRoot = '../tom_d4rt/lib/src';
const String kAstRoot = 'lib/src/runtime';

/// Pairs allowed to differ, with why.
///
/// This is one of four registers of mirror divergence, and
/// `tom_d4rt/test/sce252_mirror_register_agreement_test.dart` holds their keys
/// in agreement (SCE252): the `stdlib/` entries must be exactly SCD49's, every
/// file SCD183 exempts must be here, and anything here that SCD183 finds
/// identical must be a rename-only file recorded there. Adding or deleting an
/// entry means reading that file's findings, not only this one's.
///
/// The same shape as the conformance guard's `_divergentBaseline`, and for the
/// same reason: an entry here is a decision, and a file that stops diverging
/// should leave rather than sit here claiming a difference it no longer has.
/// `F-SCC92-3` fails on a stale entry.
///
/// Reasons are what was MEASURED, not what was assumed. Five stdlib barrels
/// were in this list on the first draft and the stale check removed them
/// within a minute — they had been copied from an earlier run with a weaker
/// path normaliser and did not diverge at all.
///
/// SCD208 read all thirteen entries with `--show` and each now carries its
/// measured size on 2026-09-15: how many code lines of the file actually
/// differ, and where. Two entries said SUSPECTED ONE-SIDED EDIT, meaning the
/// difference had been noticed and not investigated, and NEITHER survived
/// reading — both were reconciled and their entries deleted. The counts are a
/// dated observation rather than a pinned one; what pins these files is
/// SCD183's region and member checks and SCD199's per-body census, which fire
/// on movement. A number here that has drifted is stale prose, not a failure.
///
/// The sizes are worth having because they are not what the shared reasons
/// suggest. `runtime_types.dart` diverges in 62 of 2035 code lines and
/// `interpreter_visitor.dart` in 2319 of 11548 — 3 % and 20 %, against the
/// 55 % and 99 % that SCD183's whole-stream reading records for the same
/// files. Both readings are honest about different questions: a trimmed
/// common-prefix comparison measures where two token streams STOP agreeing,
/// which after the first desynchronisation is most of the file. \"These cannot
/// be textual mirrors\" is true either way; \"almost nothing in them matches\"
/// is not.
const Map<String, String> kDivergentMirrors = <String, String>{
  'interpreter_visitor.dart': '1498 of 11743 code lines. $_astNodeTypes',
  'callable.dart': '821 of 5170 code lines. $_astNodeTypes',
  'declaration_visitor.dart': '62 of 203 code lines. $_astNodeTypes',
  'runtime_types.dart': '55 of 2100 code lines. $_astNodeTypes',
  'introspection.dart': '48 of 608 code lines. $_astNodeTypes',
  'bridge/bridged_enum.dart':
      '4 code lines at two sites, and nothing else: the reference passes '
      '`moduleLoader: ModuleLoader(env, {}, {}, {})` where the twin passes '
      '`moduleContext: NoOpModuleContext(globalEnvironment: env)`, in the two '
      'throwaway visitors built to invoke a bridged enum `toString`. The twin '
      'has no `ModuleLoader` at all, which is the same difference that makes '
      '`module_loader.dart` untwinnable.',
  'stdlib/io/process.dart': '4 code lines, one site. $_permissionAccess',
  'stdlib/io/platform.dart': '4 code lines, one site. $_permissionAccess',
  'stdlib/io/filesystem_permission_helper.dart':
      '4 code lines, one site. $_permissionAccess',
  'stdlib/io/network_permission_helper.dart':
      '4 code lines, one site. $_permissionAccess',
  // SCE74H added this one, deliberately as its own file rather than inline in
  // `stdlib/io/tls.dart`, following SCD170's precedent directly above: the
  // permission idiom is what diverges, so confining it to a helper keeps the
  // 240-line `tls.dart` a textual mirror and leaves one three-line entry here
  // instead of a large one.
  'stdlib/io/certificate_permission_helper.dart':
      '3 code lines, one site. $_permissionAccess',
  // SCD170 removed `stdlib/io/socket.dart` from this baseline. Its divergence
  // was this same permission-access idiom, written inline in
  // `_checkNetworkPermission`; both trees now route that through the network
  // helper above, so the file is a textual mirror again and the idiom lives
  // only in the two helpers whose job it is.
  //
  // SCE253 removed `async_state.dart`. Its whole divergence was the mirror
  // rename and the import supplying it; once [stripToCode] normalised both,
  // the pair agreed. The same normalisation re-measured every entry above on
  // 2026-09-29 — `interpreter_visitor.dart` went from 2312 differing lines to
  // 1498 and `callable.dart` from 1517 to 821, so roughly a third of what these
  // entries used to record was spelling.
  //
  // SCD208 removed `environment.dart` and `bridge/bridged_types.dart`, the two
  // entries that said SUSPECTED ONE-SIDED EDIT. Neither was one. The first
  // declared the same method in a different POSITION, which the guard's
  // positional comparison reported as 136 divergent lines; the second spelled
  // one enum-property lookup as an if-chain against a switch. Both were
  // reconciled rather than re-worded, and both pairs now agree whole-file.
};

const String _astNodeTypes =
    'The `SAstNode`/`AstNode` rename is normalised before comparing (SCE253), '
    'so what remains is the accessors, which differ with the two ASTs '
    "(`node.name.lexeme` against `node.name?.name ?? ''`), and the parent "
    'pointer the mirror AST does not have. These files cannot be textual '
    'mirrors even in principle; this is the divergence the whole '
    'analyzer-free line exists to have. What HOLDS them is not this entry but '
    '`scd199_mirror_body_agreement_test.dart`, which compares each shared '
    'member body separately after normalising the rename, and pins every one '
    'that disagrees — 107 of 726, so 85 % of the bodies in these files are '
    'held to being identical.';

const String _permissionAccess =
    'permission checks reach the host differently: the reference reads '
    '`visitor.moduleLoader.d4rt`, null-checks it and calls `checkPermission` '
    'on it, where the twin calls `visitor.moduleContext.checkPermission` '
    'directly — three lines against one, and no other difference in the file.';

/// Every type `tom_ast_model` declares, read once from the sibling checkout.
///
/// Empty when the model is not beside this package, in which case nothing is
/// normalised and every AST-typed file reads as divergent: the counts in
/// [kDivergentMirrors] and `F-SCC92-4` then say so loudly rather than pass.
final Set<String> _mirrorTypes = mirrorTypeNames();

final RegExp _identifier = RegExp(r'\b[A-Za-z_][A-Za-z0-9_]*\b');

/// The imports that SUPPLY the two ASTs: the analyzer in the reference; the
/// mirror model in the twin, directly or through `package:tom_d4rt_ast/ast.dart`,
/// whose whole content is `export 'package:tom_ast_model/ast.dart'`. They
/// differ by construction and name nothing else, so after the rename is
/// normalised they are the only lines left in a file whose whole difference
/// is the rename.
final RegExp _astSupplierImport = RegExp(
  r"^\s*import\s+'package:(analyzer/|tom_ast_model/|tom_d4rt_ast/ast\.dart')",
);

/// The code of [source], with comments removed and the two package layouts
/// normalised so only real differences survive.
///
/// The twin's mirror types are also de-prefixed — `SAstNode` reads as
/// `AstNode`, `GeneralizingSAstVisitor` as `GeneralizingAstVisitor` — with the
/// same map SCD199 uses per member (sce253). Without it `async_state.dart`
/// was baselined under the reason that the two ASTs "cannot be textual
/// mirrors", when every one of its divergent lines was the rename.
///
/// THE TRADE, restated rather than inherited from SCD199: the map hides a
/// twin that uses a mirror type where the reference uses an UNRELATED
/// analyzer type of the same base name. That is the 1:1-mirror claim itself
/// being false, which `tom_ast_model`'s suite owns and a line diff could not
/// have diagnosed anyway. A twin naming the wrong mirror type is still caught
/// whenever the reference names the right one: `SBlock` against `Statement`
/// normalises to `Block` against `Statement`, which differs. What the map buys
/// is that this guard reports only differences in what the code DOES.
///
/// Comments are stripped because the two trees document themselves separately
/// and should keep doing so. Package paths are normalised because
/// `package:tom_d4rt/src/x` and `package:tom_d4rt_ast/src/runtime/x` name the
/// same file in the two layouts; leaving them raw would report every import as
/// a divergence and drown the real ones.
List<String> stripToCode(String source, {required bool ast}) {
  final out = <String>[];
  var inBlockComment = false;
  for (final raw in source.split('\n')) {
    var line = raw;
    if (inBlockComment) {
      final end = line.indexOf('*/');
      if (end < 0) continue;
      inBlockComment = false;
      line = line.substring(end + 2);
    }
    final open = line.indexOf('/*');
    if (open >= 0 && !line.substring(open).contains('*/')) {
      inBlockComment = true;
      line = line.substring(0, open);
    }
    if (RegExp(r'^\s*//').hasMatch(line)) continue;
    if (_astSupplierImport.hasMatch(line)) continue;
    if (ast) {
      line = line.replaceAllMapped(
        _identifier,
        (m) => denormaliseMirrorType(m[0]!, _mirrorTypes),
      );
    }
    line = ast
        ? line
              .replaceAll('package:tom_d4rt_ast/runtime.dart', '@BARREL@')
              .replaceAll('package:tom_d4rt_ast/src/runtime/', '@SRC@')
              .replaceAll('package:tom_d4rt_ast/', '@PKG@')
        : line
              .replaceAll('package:tom_d4rt/d4rt.dart', '@BARREL@')
              .replaceAll('package:tom_d4rt/src/', '@SRC@')
              .replaceAll('package:tom_d4rt/', '@PKG@');
    if (line.trim().isEmpty) continue;
    out.add(line.trimRight());
  }
  return out;
}

/// Every `.dart` under [kReferenceRoot] that has a counterpart here, as paths
/// relative to the two roots.
List<String> mirroredPaths({
  String referenceRoot = kReferenceRoot,
  String astRoot = kAstRoot,
}) {
  final ref = Directory(referenceRoot);
  if (!ref.existsSync()) return const [];
  final out = <String>[];
  for (final entity in ref.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    // Always `/`-separated. `kDivergentMirrors` and every other register
    // keyed by these paths is written that way, and on Windows `listSync`
    // yields backslashes, so an unnormalised key matched nothing there and
    // every baselined divergence was reported as drift (SCF30).
    final rel = entity.path
        .substring(referenceRoot.length + 1)
        .replaceAll(r'\', '/');
    if (File('$astRoot/$rel').existsSync()) out.add(rel);
  }
  out.sort();
  return out;
}

/// The code lines that differ for [rel], or empty when the pair agrees.
List<String> diffFor(
  String rel, {
  String referenceRoot = kReferenceRoot,
  String astRoot = kAstRoot,
}) {
  final a = stripToCode(
    File('$referenceRoot/$rel').readAsStringSync(),
    ast: false,
  );
  final b = stripToCode(File('$astRoot/$rel').readAsStringSync(), ast: true);
  if (a.length == b.length) {
    var identical = true;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        identical = false;
        break;
      }
    }
    if (identical) return const [];
  }
  // Report is line-oriented rather than a minimal edit script: the guard only
  // needs to say WHERE they stop agreeing, and the first disagreement is what
  // a reader acts on.
  final out = <String>[];
  for (var i = 0; i < (a.length > b.length ? a.length : b.length); i++) {
    final left = i < a.length ? a[i] : '<absent>';
    final right = i < b.length ? b[i] : '<absent>';
    if (left != right) {
      out.add(
        '  line ${i + 1}\n    tom_d4rt    : $left\n    tom_d4rt_ast: $right',
      );
      if (out.length >= 5) {
        out.add('  … and possibly more; the two files diverge from here.');
        break;
      }
    }
  }
  return out;
}

/// The full normalised diff for [rel] as a unified-style listing.
///
/// [diffFor] deliberately stops after five lines and then gives up, because
/// what the GUARD needs is only where a pair stops agreeing. Characterising a
/// baselined entry needs the opposite — every difference, so the reason can
/// state what was measured rather than what the first five lines suggested.
/// SCD208 read all thirteen entries this way.
List<String> fullDiff(
  String rel, {
  String referenceRoot = kReferenceRoot,
  String astRoot = kAstRoot,
}) {
  final a = stripToCode(
    File('$referenceRoot/$rel').readAsStringSync(),
    ast: false,
  );
  final b = stripToCode(File('$astRoot/$rel').readAsStringSync(), ast: true);

  // Longest common subsequence over whole lines. The guard's positional
  // comparison reports every line after an insertion as different, which is
  // fine for "where do they stop agreeing" and useless for "what actually
  // differs" — a single added method made environment.dart look like 136
  // divergent lines when 8 had changed.
  final n = a.length;
  final m = b.length;
  final lcs = List.generate(n + 1, (_) => List<int>.filled(m + 1, 0));
  for (var i = n - 1; i >= 0; i--) {
    for (var j = m - 1; j >= 0; j--) {
      lcs[i][j] = a[i] == b[j]
          ? lcs[i + 1][j + 1] + 1
          : (lcs[i + 1][j] > lcs[i][j + 1] ? lcs[i + 1][j] : lcs[i][j + 1]);
    }
  }

  final out = <String>[];
  var i = 0;
  var j = 0;
  while (i < n && j < m) {
    if (a[i] == b[j]) {
      i++;
      j++;
    } else if (lcs[i + 1][j] >= lcs[i][j + 1]) {
      out.add('- [${i + 1}] ${a[i++]}');
    } else {
      out.add('+ [${j + 1}] ${b[j++]}');
    }
  }
  while (i < n) {
    out.add('- [${i + 1}] ${a[i++]}');
  }
  while (j < m) {
    out.add('+ [${j + 1}] ${b[j++]}');
  }
  return out;
}

void main(List<String> args) {
  final verbose = args.contains('--verbose');

  // `--show <path>` prints one pair's full normalised diff. Reading a
  // baselined entry is how its reason gets written, and doing that with plain
  // `diff` shows the prose differences the guard deliberately ignores — which
  // is most of the output and none of the subject.
  final showAt = args.indexOf('--show');
  if (showAt >= 0) {
    if (showAt + 1 >= args.length) {
      stderr.writeln(
        '--show needs a path relative to the two roots, e.g. '
        '`--show bridge/bridged_types.dart`',
      );
      exit(2);
    }
    final rel = args[showAt + 1];
    if (!File('$kReferenceRoot/$rel').existsSync() ||
        !File('$kAstRoot/$rel').existsSync()) {
      stderr.writeln(
        '$rel is not a mirrored pair — it is missing from one '
        'tree. Run without --show to list what is.',
      );
      exit(2);
    }
    final lines = fullDiff(rel);
    stdout.writeln(
      lines.isEmpty
          ? '$rel: the two trees agree once comments and package paths are '
                'normalised.'
          : '$rel: ${lines.length} differing code '
                '${lines.length == 1 ? 'line' : 'lines'} '
                '(- tom_d4rt, + tom_d4rt_ast)\n${lines.join('\n')}',
    );
    return;
  }

  final paths = mirroredPaths();
  if (paths.isEmpty) {
    stderr.writeln(
      'No mirrored sources found. This tool needs the sibling checkout at '
      '$kReferenceRoot; run it from the tom_d4rt_ast package root.',
    );
    exit(2);
  }

  final unexpected = <String, List<String>>{};
  final stale = <String>[];
  var agreeing = 0;
  for (final rel in paths) {
    final diff = diffFor(rel);
    final baselined = kDivergentMirrors.containsKey(rel);
    if (diff.isEmpty) {
      agreeing++;
      if (baselined) stale.add(rel);
    } else if (!baselined) {
      unexpected[rel] = diff;
    }
  }

  stdout.writeln(
    'mirrored files: ${paths.length}   agreeing: $agreeing   '
    'baselined divergent: ${kDivergentMirrors.length}',
  );
  for (final entry in unexpected.entries) {
    stdout.writeln('\nDRIFT  ${entry.key}');
    if (verbose) entry.value.forEach(stdout.writeln);
  }
  for (final rel in stale) {
    stdout.writeln('\nSTALE BASELINE  $rel now agrees — remove its entry');
  }
  if (unexpected.isNotEmpty || stale.isNotEmpty) exit(1);
  stdout.writeln('All mirrored sources agree.');
}
