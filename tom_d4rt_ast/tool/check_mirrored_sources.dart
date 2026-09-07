// SCC92: the tom_d4rt <-> tom_d4rt_ast mirror rule, enforced.
//
// The quest's standing rule is that an interpreter fix lands in BOTH trees.
// Nothing checked it, so a one-sided fix analyzed clean, passed both suites,
// and surfaced only when somebody next read the two files side by side. This
// tool is that check; `test/runtime/mirrored_sources_test.dart` runs it.
//
//     dart run tool/check_mirrored_sources.dart            # report and exit
//     dart run tool/check_mirrored_sources.dart --verbose  # with the diffs
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

/// Where the two trees keep the sources that must agree.
const String kReferenceRoot = '../tom_d4rt/lib/src';
const String kAstRoot = 'lib/src/runtime';

/// Pairs allowed to differ, with why.
///
/// The same shape as the conformance guard's `_divergentBaseline`, and for the
/// same reason: an entry here is a decision, and a file that stops diverging
/// should leave rather than sit here claiming a difference it no longer has.
/// `F-SCC92-3` fails on a stale entry.
///
/// Reasons are what was MEASURED on 2026-09-07, not what was assumed. Five
/// stdlib barrels were in this list on the first draft and the stale check
/// removed them within a minute — they had been copied from an earlier run
/// with a weaker path normaliser and did not diverge at all. Two of the
/// entries that remain are suspected one-sided edits rather than architecture,
/// and say so; SCD208 owns finishing that characterisation.
const Map<String, String> kDivergentMirrors = <String, String>{
  'interpreter_visitor.dart': _astNodeTypes,
  'callable.dart': _astNodeTypes,
  'declaration_visitor.dart': _astNodeTypes,
  'runtime_types.dart': _astNodeTypes,
  'introspection.dart': _astNodeTypes,
  'async_state.dart': _astNodeTypes,
  'stdlib/core/enum.dart':
      'one import: the reference reaches bridged_enum.dart directly and this '
      'tree gets it another way. Not characterised further; SCD208.',
  'bridge/bridged_enum.dart':
      'module loading differs — the reference constructs a ModuleLoader where '
      'this tree builds an Environment directly, which is the same difference '
      'that makes module_loader.dart untwinnable',
  'environment.dart':
      'SUSPECTED ONE-SIDED EDIT, not architecture: the reference declares '
      '`removeLocalValue` and this tree does not. Baselined so the guard can '
      'ship, NOT because the difference is justified. SCD208.',
  'bridge/bridged_types.dart':
      'SUSPECTED ONE-SIDED EDIT, not architecture: the same enum name/index '
      'lookup is an if-chain in the reference and a switch here — a refactor '
      'that reached one tree. Behaviour looks identical; unverified. SCD208.',
  'stdlib/io/process.dart': _permissionAccess,
  'stdlib/io/platform.dart': _permissionAccess,
  'stdlib/io/filesystem_permission_helper.dart': _permissionAccess,
  'stdlib/io/socket.dart':
      'documented as a deliberate divergence in the quest overview, alongside '
      'io/process.dart and unbridged_reasons.dart',
};

const String _astNodeTypes =
    'the analyzer AST and the mirror AST are different types — `AstNode` vs '
    '`SAstNode` — so these files cannot be textual mirrors even in principle. '
    'This is the divergence the whole analyzer-free line exists to have.';

const String _permissionAccess =
    'permission checks reach the host differently: the reference goes through '
    '`visitor.moduleLoader.d4rt`, which this tree has no equivalent of, and '
    'uses `visitor.moduleContext` instead';

/// The code of [source], with comments removed and the two package layouts
/// normalised so only real differences survive.
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
    final rel = entity.path.substring(referenceRoot.length + 1);
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

void main(List<String> args) {
  final verbose = args.contains('--verbose');
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
