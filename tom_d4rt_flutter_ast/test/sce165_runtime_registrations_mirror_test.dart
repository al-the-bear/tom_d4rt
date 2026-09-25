// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — the twins' ~200 KB hand-duplicated
// `d4rt_runtime_registrations.dart` must agree below its import prologue.
//
// Its subject reaches OUTSIDE this package (the sibling twin's copy), so it
// runs only when tom_d4rt_flutter_ast's suite runs. SCD129 made that
// arrangement visible rather than incidental: `grep -rn 'REPO-WIDE GUARD'
// */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
/// SCE165 — the largest unguarded duplication in the repo, measured and closed.
///
/// `lib/src/d4rt_runtime_registrations.dart` is ~200 KB of hand-written
/// interface proxies and it exists twice, once per Flutter twin, with nothing
/// checking that the copies agree. The twins' four shared USER BRIDGES have a
/// derivation tool, a test and a pre-commit refusal, because they drifted once
/// and sat that way for months. This file is forty times larger and had none of
/// it. It bit during scd138, when the same 21-class edit had to be hand-applied
/// to both copies and a mistake in one would have been caught by nothing.
///
/// ## Characterise before mechanising — and the raw diff was misleading
///
/// The work recorded "327 differing lines" and proposed building a sync tool.
/// 327 is a TEXT diff: comments, wrapping, import order. Compared as CODE —
/// full-line comments stripped and the two package layouts normalised, which is
/// what `tom_d4rt_ast/tool/check_mirrored_sources.dart` does for the
/// interpreter pairs — the real figure was **42 lines in three groups**:
///
/// | group                                  | lines | verdict |
/// | -------------------------------------- | ----: | ------- |
/// | the import prologue                    |     9 | structural |
/// | `const` on nine proxy constructors     |    18 | DRIFT |
/// | `AutomaticKeepAliveClientMixin` support |    15 | MISSING FEATURE |
///
/// Two of the three were repaired rather than recorded, which is why the
/// baseline below has one entry instead of three:
///
/// * The `const` difference was measured, not assumed: adding `const` to the
///   AST twin's nine constructors analyzes clean. It was drift.
/// * `AutomaticKeepAliveClientMixin` was absent from the AST twin ENTIRELY —
///   no `_InterpretedKeepAliveState`, no mixin detection — while 28 corpus
///   scripts use it and the mixin is bridged on both lines. A script mixing it
///   in "compiled" and was structurally absent at runtime: the proxy the
///   framework mounted was a plain `State`, so `KeepAliveNotification` was
///   never dispatched. Ported.
///
/// ## What is left, and why it cannot be derived away
///
/// The import prologue, and only that. The source twin imports one barrel; the
/// AST twin reaches into `src/` for `D4`, `BridgedInstance`,
/// `InterpreterVisitor`, `D4InterpretedProxy`, `RuntimeType` and
/// `runtime_types.dart`, because `package:tom_d4rt_ast/runtime.dart` does not
/// export them. That is a real difference between the two packages' surfaces,
/// not a copy that drifted, so a derivation tool would have to special-case it
/// anyway — and a baselined comparison says the same thing in one entry
/// without a generator to maintain.
///
/// Everything below the prologue is compared line for line.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'sibling_trees.dart';

const _ast = 'lib/src/d4rt_runtime_registrations.dart';
const _source = '../tom_d4rt_flutter/lib/src/d4rt_runtime_registrations.dart';

/// Well under the measured ~3 500 code lines; a floor, not a tracker.
const _minCodeLines = 2500;

/// The code of [source], with full-line comments removed and the two package
/// layouts normalised — the same treatment
/// `tom_d4rt_ast/tool/check_mirrored_sources.dart` gives the interpreter pairs,
/// and for the same reason: the two trees document themselves separately and
/// should keep doing so, so what must match is the CODE.
List<String> codeLines(String source, {required bool ast}) {
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

/// [lines] with the leading `library;` / `import` / `export` prologue removed.
///
/// The prologue is the one recorded divergence. Splitting on it rather than
/// baselining its individual lines means a NEW import on either side is not a
/// failure — which is correct, since each package imports what its own layout
/// needs — while every line of the 3 500 below it is compared exactly.
List<String> belowPrologue(List<String> lines) {
  var i = 0;
  var inDirective = false;
  while (i < lines.length) {
    final t = lines[i].trimLeft();
    if (!inDirective) {
      final starts =
          t.startsWith('import ') ||
          t.startsWith('export ') ||
          t.startsWith('part ') ||
          t == 'library;' ||
          t.startsWith('library ');
      if (!starts) break;
      inDirective = true;
    }
    // A directive runs to the line that terminates it. Wrapped `show` / `hide`
    // clauses put the `;` several lines down, and every line in between
    // belongs to the prologue rather than to the body.
    if (t.endsWith(';')) inDirective = false;
    i++;
  }
  return lines.sublist(i);
}

/// The directive lines each side declares, for the divergence record.
List<String> prologue(List<String> lines) =>
    lines.sublist(0, lines.length - belowPrologue(lines).length);

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject: "the twins' ~200 KB hand-duplicated",
  );

  late List<String> astCode;
  late List<String> sourceCode;

  setUpAll(() {
    for (final path in <String>[_ast, _source]) {
      expect(
        File(path).existsSync(),
        isTrue,
        reason:
            '$path is this guard\'s entire subject. If the file moved, move '
            'the guard with it rather than leaving one that reads nothing',
      );
    }
    astCode = codeLines(File(_ast).readAsStringSync(), ast: true);
    sourceCode = codeLines(File(_source).readAsStringSync(), ast: false);
  });

  group('SCE165: the twins\' runtime registrations agree below the prologue', () {
    test('F-SCE165-1: every code line below the import prologue matches', () {
      final a = belowPrologue(sourceCode);
      final b = belowPrologue(astCode);

      final mismatches = <String>[];
      for (var i = 0; i < a.length && i < b.length; i++) {
        if (a[i] != b[i]) {
          mismatches.add(
            'line ${i + 1} below the prologue:\n'
            '      source: ${a[i].trim()}\n'
            '      ast   : ${b[i].trim()}',
          );
          if (mismatches.length >= 8) break;
        }
      }
      if (mismatches.isEmpty && a.length != b.length) {
        mismatches.add(
          'the two sides have the same ${a.length < b.length ? a.length : b.length} '
          'leading lines and then differ in length: source ${a.length}, '
          'ast ${b.length}',
        );
      }

      expect(
        mismatches,
        isEmpty,
        reason:
            'This file is ~200 KB duplicated BY HAND between the twins with no '
            'generator. Every edit has to land twice, and until SCE165 nothing '
            'noticed when one did not — scd138 hand-applied the same 21-class '
            'change to both copies and a mistake in either would have been '
            'caught by nothing. Apply the change to both, or, if the '
            'divergence is real, widen the prologue split deliberately and say '
            'why:\n  ${mismatches.join('\n  ')}',
      );
    });

    test('F-SCE165-2: the prologue is the ONLY recorded divergence, and it is '
        'the shape it claims to be', () {
      final astPrologue = prologue(astCode);
      final sourcePrologue = prologue(sourceCode);

      // The AST twin reaches into `src/` because its barrel does not export
      // these names; the source twin takes them from one barrel. That is a
      // difference between the two PACKAGES' surfaces, not a copy that
      // drifted — and it is the whole of what this pair is allowed to differ
      // by.
      expect(
        astPrologue.where((l) => l.contains('@SRC@')),
        isNotEmpty,
        reason:
            'the AST prologue no longer reaches into `src/`. If its barrel now '
            'exports those names, the two prologues may have converged — check, '
            'and if so this exemption is dead and the whole file can be '
            'compared',
      );
      expect(
        sourcePrologue.where((l) => l.contains('@SRC@')),
        isEmpty,
        reason:
            'the SOURCE twin has started reaching into `src/` too. That is a '
            'new divergence in the one place this guard does not compare, so '
            'it needs a decision rather than a silent pass',
      );
      expect(
        sourcePrologue.where((l) => l.contains('@BARREL@')),
        isNotEmpty,
        reason: 'the source twin no longer imports the interpreter barrel',
      );
    });

    test('F-SCE165-3 (control): the normaliser did not eat the file', () {
      for (final (label, lines) in <(String, List<String>)>[
        ('tom_d4rt_flutter_ast', astCode),
        ('tom_d4rt_flutter', sourceCode),
      ]) {
        expect(
          lines.length,
          greaterThanOrEqualTo(_minCodeLines),
          reason:
              '$label produced only ${lines.length} code lines. F-SCE165-1 '
              'compares two lists positionally, and two short lists match '
              'trivially — this is what stops a broken comment stripper '
              'passing it',
        );
        expect(
          belowPrologue(lines).length,
          greaterThanOrEqualTo(_minCodeLines),
          reason:
              '$label: the prologue split consumed the file. Everything below '
              'the prologue is what F-SCE165-1 actually compares',
        );
      }
      // And the split really does stop at the first declaration rather than
      // running on, which is the other way it could pass over nothing.
      expect(
        belowPrologue(astCode).first,
        isNot(startsWith('import ')),
        reason: 'the prologue split left an import behind',
      );
    });
  });
}
