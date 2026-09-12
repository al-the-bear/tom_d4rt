// SCD49 — the two stdlib trees agree on CODE, and the four places they do not
// are named.
//
// WHY THIS FILE EXISTS. `doc/stdlib_sdk_gap_audit.md` justifies the whole
// member-coverage guard for the analyzer-free line by asserting that the mirror
// stdlib is the same code, so the findings transfer: one oracle, both trees.
// That is how a suite measuring only `tom_d4rt` gets read as evidence about
// `tom_d4rt_ast` — which is the tree that ships inside Flutter apps, and the
// one the audit tool cannot look at (it needs `dart:mirrors`, and the twin must
// stay dependency-free). The claim was load-bearing and unmeasured.
//
// WHAT IS COMPARED, AND WHAT IS DELIBERATELY NOT. Token streams, not text:
//
//   * COMMENTS ARE EXCLUDED. They differ legitimately and often — a doc comment
//     in the twin naming `F-SCC50-AST-1..4` and its own test path is CORRECT,
//     and a check that demanded identical comments would report dozens of files
//     as divergent for being right. An earlier text-level measurement reported
//     29 of 117 files differing; comparing code puts it at 4 of 126, and the
//     difference between those two numbers is almost entirely comment wording
//     and `dart format` line wrapping.
//   * DIRECTIVES ARE EXCLUDED. `package:tom_d4rt/d4rt.dart` against
//     `package:tom_d4rt_ast/runtime.dart` is not a prefix rewrite — the barrels
//     have different granularity, so the twin needs fewer imports. Directives
//     are also the one part that cannot go wrong quietly: a wrong import does
//     not compile, and both trees are analyzed and tested.
//   * TRAILING COMMAS ARE EXCLUDED. Whether `dart format` emits one depends on
//     the line length it computed, which depends on the comment above it. A
//     comment rewrap in one tree would otherwise fail this file with a finding
//     that means nothing. (`io/socket.dart` really does differ this way today.)
//
// What is left is the executable code, which is exactly what "the same gaps"
// is a claim about: gaps live in adapter maps, not in import lines.
//
// THE FOUR ALLOWED DIVERGENCES ARE PINNED EXACTLY, not waved through by path.
// `io/socket.dart` is 8724 tokens; allowing the file wholesale would leave all
// of it unguarded for the sake of one 20-token region. Each entry records both
// sides of its divergence, so a SECOND divergence in an allow-listed file still
// fails (F-SCD49-4), and a divergence that gets resolved also fails
// (F-SCD49-3) rather than leaving a permanent permission behind.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                           | Fires     |
//   | -------------------------------------------------------- | --------- |
//   | twin root pointed at a path that does not exist           | 1 and 3   |
//   | a line comment reworded in the twin only                  | nothing   |
//   | a block comment inserted in the twin only                 | nothing   |
//   | a file reformatted in the twin only                       | nothing   |
//   | `'whereType'` renamed in the twin's `core/set.dart`       | 2         |
//   | `io/platform.dart` made identical in both trees           | 3         |
//   | a second, unrelated divergence added to `io/socket.dart`  | 4         |
//
// The three `nothing` rows are the design claim, and a version of this check
// that compared text would have failed all three.
//
// The first row fires F-SCD49-3 as well, and that is worth knowing before
// reading a double-red as two problems: with no twin files there are no
// divergences, so every allow-list entry looks resolved. F-SCD49-1 is the one
// to believe — it is ordered first for that reason, and nothing else in this
// file means anything until it passes.

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:test/test.dart';

/// The reference tree's stdlib, relative to the package root.
const _refRoot = 'lib/src/stdlib';

/// The twin's. A sibling checkout, because both packages live in the one
/// `tom_d4rt` repository.
const _astRoot = '../tom_d4rt_ast/lib/src/runtime/stdlib';

/// Both trees held 126 stdlib files on 2026-09-12. The floor is well below that
/// because its job is to separate "compared the corpus" from "compared nothing"
/// — a walk that silently found no files would otherwise satisfy every
/// emptiness assertion below.
const _minFiles = 100;

/// The permission-access idiom, which is structural and cannot be reconciled.
///
/// The reference reaches the permission table through `visitor.moduleLoader
/// .d4rt`, which is nullable; the twin has no `D4rt` in that shape and reaches
/// it through the non-nullable `visitor.moduleContext`.
///
/// NOTE THE BEHAVIOURAL DIFFERENCE, because it is not cosmetic: the reference
/// `return`s when the `D4rt` is null, so it SKIPS the check, while the twin
/// always performs it. A permission gate that fails open is a real difference
/// and is tracked separately — it is recorded here rather than normalised away
/// precisely so that it stays visible.
const _idiomRef =
    'final d4rt = visitor . moduleLoader . d4rt ; if ( d4rt == null ) '
    'return ; if ( ! d4rt';
const _idiomAst = 'if ( ! visitor . moduleContext';

/// The same idiom in `filesystem_permission_helper.dart`, where the shared
/// prefix ends one token earlier (the `final` binds a different variable), so
/// the trimmed region picks up the statement around it.
const _helperRef =
    'd4rt = visitor . moduleLoader . d4rt ; if ( d4rt == null ) return ; '
    'final normalizedPath = File ( path ) . absolute . path ; '
    'final allowed = d4rt';
const _helperAst =
    'normalizedPath = File ( path ) . absolute . path ; '
    'final allowed = visitor . moduleContext';

/// Files allowed to differ, and exactly how. Anything else is a finding.
const _allowed = <String, (String, String)>{
  'io/platform.dart': (_idiomRef, _idiomAst),
  'io/process.dart': (_idiomRef, _idiomAst),
  'io/socket.dart': (_idiomRef, _idiomAst),
  'io/filesystem_permission_helper.dart': (_helperRef, _helperAst),
};

/// The executable tokens of [source]: no comments, no directives, no trailing
/// commas.
List<String> _codeTokens(String source) {
  final unit = parseString(
    content: source,
    featureSet: FeatureSet.latestLanguageVersion(),
    throwIfDiagnostics: false,
  ).unit;
  final directives = unit.directives;
  // `Token.next` skips comments — they hang off `precedingComments` — so
  // excluding them costs nothing here.
  final start = directives.isEmpty
      ? unit.beginToken
      : directives.last.endToken.next!;
  final out = <String>[];
  for (Token? t = start; t != null && t.type != TokenType.EOF; t = t.next) {
    if (t.lexeme == ',') {
      final next = t.next;
      if (next != null && const [')', ']', '}'].contains(next.lexeme)) continue;
    }
    out.add(t.lexeme);
  }
  return out;
}

/// The two sides of where [a] and [b] stop agreeing, with the common prefix and
/// suffix trimmed off. `null` when they agree everywhere.
(String, String)? _divergence(List<String> a, List<String> b) {
  var head = 0;
  while (head < a.length && head < b.length && a[head] == b[head]) {
    head++;
  }
  if (head == a.length && head == b.length) return null;
  var tail = 0;
  while (tail < a.length - head &&
      tail < b.length - head &&
      a[a.length - 1 - tail] == b[b.length - 1 - tail]) {
    tail++;
  }
  return (
    a.sublist(head, a.length - tail).join(' '),
    b.sublist(head, b.length - tail).join(' '),
  );
}

List<String> _dartFilesUnder(String root) {
  final dir = Directory(root);
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .map((f) => f.path.substring(root.length + 1))
      .toList()
    ..sort();
}

void main() {
  final refFiles = _dartFilesUnder(_refRoot);
  final astFiles = _dartFilesUnder(_astRoot);

  /// Divergence per shared file, computed once.
  final divergences = <String, (String, String)>{};
  for (final rel in refFiles.toSet().intersection(astFiles.toSet())) {
    final d = _divergence(
      _codeTokens(File('$_refRoot/$rel').readAsStringSync()),
      _codeTokens(File('$_astRoot/$rel').readAsStringSync()),
    );
    if (d != null) divergences[rel] = d;
  }

  test('F-SCD49-1: both stdlib trees are present and hold the same files '
      '[2026-09-12]', () {
    // Runs first because the other three are emptiness assertions over a walk,
    // and a walk that found nothing satisfies all of them. A missing twin is
    // the likeliest way to reach that state, and it must not read as a pass.
    expect(
      refFiles.length,
      greaterThanOrEqualTo(_minFiles),
      reason:
          'Found only ${refFiles.length} files under $_refRoot. That is not a '
          'finding about the twins — the walk did not run. Tests are expected '
          'to run with the package root as the working directory.',
    );
    expect(
      astFiles.length,
      greaterThanOrEqualTo(_minFiles),
      reason:
          'Found only ${astFiles.length} files under $_astRoot. The twin is a '
          'sibling checkout in the same `tom_d4rt` repository; if it is absent '
          'this file cannot make its comparison, and reporting that as a pass '
          'would be worse than failing.',
    );

    final onlyRef = refFiles.toSet().difference(astFiles.toSet()).toList()
      ..sort();
    final onlyAst = astFiles.toSet().difference(refFiles.toSet()).toList()
      ..sort();
    expect(
      [...onlyRef, ...onlyAst],
      isEmpty,
      reason:
          '${onlyRef.isEmpty ? '' : 'Only in the reference tree:\n'
                    '  ${onlyRef.join('\n  ')}\n'}'
          '${onlyAst.isEmpty ? '' : 'Only in the twin:\n'
                    '  ${onlyAst.join('\n  ')}\n'}\n'
          'A bridge file that exists in one tree and not the other is the '
          'coarsest form of the divergence this file measures, and it is the '
          'one the member-coverage audit cannot see at all — that audit reads '
          'the reference tree only.',
    );
  });

  test('F-SCD49-2: every stdlib file outside the allow-list is code-identical '
      'in both trees [2026-09-12]', () {
    // The regression guard. Comments, formatting and imports are already
    // excluded, so anything reaching here is executable code that differs —
    // which means a finding measured on one tree may not hold on the other.
    final unexpected =
        divergences.keys.where((f) => !_allowed.containsKey(f)).toList()
          ..sort();

    expect(
      unexpected,
      isEmpty,
      reason:
          'These stdlib files differ in CODE between the two trees:\n'
          '${unexpected.map((f) => '  $f\n'
              '      ref: ${divergences[f]!.$1}\n'
              '      ast: ${divergences[f]!.$2}').join('\n')}\n\n'
          'Every measurement the gap audit publishes is taken on the reference '
          'tree and read as applying to both. A file that differs here breaks '
          'that inference for its class. Either port the change to the other '
          'tree — which is the usual answer, and the mirror rule in '
          '_copilot_guidelines/d4rt/mirror_maintenance.md says so — or, if the '
          'trees genuinely cannot agree, add an entry to _allowed recording '
          'both sides and why.',
    );
  });

  test('F-SCD49-3: every allow-list entry is still needed [2026-09-12]', () {
    // An allow-list nobody prunes stops being a list of known exceptions and
    // becomes a list of files that are not checked. This is the ratchet:
    // resolving a divergence is good news, and good news has to be recorded or
    // the permission outlives its reason.
    final resolved =
        _allowed.keys.where((f) => !divergences.containsKey(f)).toList()
          ..sort();

    expect(
      resolved,
      isEmpty,
      reason:
          'These files are on the allow-list and no longer differ:\n'
          '  ${resolved.join('\n  ')}\n\n'
          'Delete their entries from _allowed. Until you do, the file is '
          'exempt from F-SCD49-2 for a reason that has stopped being true, '
          'and a real divergence introduced later would not be reported.',
    );
  });

  test('F-SCD49-4: every allow-listed file diverges only where recorded '
      '[2026-09-12]', () {
    // What makes the allow-list safe to have. `io/socket.dart` is 8724 tokens;
    // exempting the path would unguard all of them to permit one region. The
    // entry pins both sides of that region instead, so a second divergence
    // anywhere in the file changes the trimmed result and is reported.
    final changed = <String>[];
    for (final entry in _allowed.entries) {
      final actual = divergences[entry.key];
      // Absent means the divergence was resolved, which F-SCD49-3 owns —
      // skipping it here keeps one event from being reported twice with two
      // different remedies.
      if (actual == null) continue;
      if (actual.$1 == entry.value.$1 && actual.$2 == entry.value.$2) continue;
      changed.add(
        '  ${entry.key}\n'
        '      expected ref: ${entry.value.$1}\n'
        '        actual ref: ${actual.$1}\n'
        '      expected ast: ${entry.value.$2}\n'
        '        actual ast: ${actual.$2}',
      );
    }
    changed.sort();

    expect(
      changed,
      isEmpty,
      reason:
          'These allow-listed files diverge differently than recorded:\n'
          '${changed.join('\n')}\n\n'
          'The likeliest cause is a SECOND divergence in the same file, which '
          'widens the trimmed region — that is a finding, and the remedy is '
          'F-SCD49-2\'s: port it. Only update the _allowed entry when the '
          'recorded divergence itself was deliberately rewritten.',
    );
  });
}
