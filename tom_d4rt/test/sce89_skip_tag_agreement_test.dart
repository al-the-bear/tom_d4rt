// REPO-WIDE GUARD (tom_d4rt) — a test tagged (SKIP) is skipped, and an unconditionally skipped test says so.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's
// suite runs and a session working elsewhere in the repo reaches none of it.
// SCD129 made that arrangement visible rather than incidental: `grep -rn
// 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCE89. The workspace naming convention is `ID: description [date] (result)`,
// and testkit reads that `(result)` into the baseline CSV — so the tag is an
// INPUT TO A REPORT, not a comment. SCD50 banned `(FAIL)`, which removed the
// failure mode that had bitten. Two combinations were left unguarded, and they
// are the same disease one notch down: a description claiming an outcome the
// run did not produce.
//
//   | tag       | actual            | guarded by            |
//   | --------- | ----------------- | --------------------- |
//   | `(FAIL)`  | anything          | F-SCD50-2 (banned)    |
//   | `(PASS)`  | fails             | the suite going red   |
//   | `(PASS)`  | skipped           | F-SCE89-1 below       |
//   | `(SKIP)`  | runs              | F-SCE89-2 below       |
//
// ONLY THE STATICALLY DECIDABLE PART IS CHECKED, and the boundary is the whole
// design. A `skip:` given a variable or an expression — `skip: layoutSkip`,
// `skip: anchorsOf(...).isEmpty ? ... : null` — is conditional BY DESIGN: it
// skips on one machine and runs on another, so no tag can describe its
// outcome and demanding one would be wrong wherever it runs. Same for every
// `markTestSkipped(...)`. Those are left alone.
//
// AND A LITERAL `skip:` IS NOT ENOUGH ON ITS OWN, which is the correction this
// file exists to record. The rule as first stated — "a `skip:` argument that
// is a literal string or `true` is unconditionally skipped" — has two false
// positives in this very suite:
//
//     if (!_gitAvailable()) {
//       test('SCD110: skipped — not a git repository', () {}, skip: true);
//       return;
//     }
//
// The LITERAL is unconditional; the DECLARATION is not. On a git checkout that
// test does not exist at all, so a `(SKIP)` tag would be a claim about a
// machine the reader is not on — and the name already carries the reason. So
// the rule is "an unconditional literal at an unconditional declaration site",
// and [_conditionalSite] is what makes that distinction. Measured 2026-09-21:
// with the site rule, one test in 4389 qualifies and it is correctly tagged;
// without it, three do and two are false positives.
//
// BOTH TREES ARE SCANNED. The twin carries no equivalent of F-SCD50-2 and
// cannot: the scan needs `package:analyzer` and `tom_d4rt_ast` must stay
// dependency-free. Reading its test tree from here is what the other
// cross-tree guards do, and it is strictly better than the regex alternative —
// a regex matches the tag in a COMMENT, which is why SCD50 parses rather than
// greps and why this file does too. This header writes `(SKIP)` a dozen times
// and passes.
//
// A TEST ABOUT THE TAG CANNOT WEAR THE TAG, which this file found out by
// failing on its own names before it had run on anything else. F-SCE89-2 reads
// the first string argument of every `test(...)`, so "a test tagged (SKIP)
// really is skipped" IS a description containing the tag and passing no
// `skip:`. Comments are safe — the scan parses, and this header writes the tag
// a dozen times — but names are the thing being read, so the cases here are
// phrased around it. An exemption for this file would have been the other
// option and a worse one: the constraint is real for any future test on the
// same subject, and it costs a rewording.
//
// EACH CASE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                          | Fires |
//   | ------------------------------------------------------- | ----- |
//   | `(SKIP)` removed from F-SCD4-10's name                   | 1     |
//   | `(SKIP)` added to a test that has no `skip:`             | 2     |
//   | `skip: true` added at an unconditional site, untagged    | 1     |
//   | the site rule removed (the two `if`-guarded skips)       | 1     |
//   | the scan pointed at a directory with no test files       | 3     |

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

import 'sibling_trees.dart';

/// The two test corpora, relative to this package's root.
const _roots = <String>['test', '../tom_d4rt_ast/test'];

/// Floors under the emptiness assertions. A scan that matched nothing — a
/// renamed directory, or an analyzer change that stopped `test(...)` parsing as
/// a `MethodInvocation` — satisfies every assertion below perfectly. Measured
/// 2026-09-21: 457 files and 1 qualifying skip across both trees.
const _minFiles = 200;
const _minNames = 1000;

/// A `test(...)` or `group(...)` declaration, with what it says about skipping.
class _Decl {
  const _Decl({
    required this.name,
    required this.file,
    required this.hasSkip,
    required this.unconditionallySkipped,
  });

  final String name;
  final String file;

  /// Whether a `skip:` argument was passed at all, however it is computed.
  final bool hasSkip;

  /// Whether this declaration is skipped on every machine: a literal `skip:`
  /// AND a declaration site no condition guards.
  final bool unconditionallySkipped;

  bool get tagged => name.contains('(SKIP)');

  @override
  String toString() =>
      '$file\n      ${name.length > 90 ? '${name.substring(0, 90)}…' : name}';
}

/// Whether [node] is written inside something that decides whether it runs.
///
/// The `test(...)` calls in a suite sit inside `main()` and inside `group(...)`
/// closures; neither decides anything. An `if`, a `?:`, a loop or a `try` does
/// — a declaration under one exists on some machines and not others, so its
/// `skip:` literal describes only the machines that reach it.
bool _conditionalSite(AstNode node) {
  for (AstNode? n = node.parent; n != null; n = n.parent) {
    if (n is IfStatement ||
        n is ConditionalExpression ||
        n is SwitchStatement ||
        n is SwitchExpression ||
        n is ForStatement ||
        n is WhileStatement ||
        n is DoStatement ||
        n is TryStatement) {
      return true;
    }
  }
  return false;
}

class _DeclCollector extends RecursiveAstVisitor<void> {
  _DeclCollector(this.file);
  final String file;
  final decls = <_Decl>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final kind = node.methodName.name;
    if (kind == 'test' || kind == 'group') {
      final args = node.argumentList.arguments;
      // `stringValue` covers adjacent string literals — how most descriptions
      // here are written, since they run past the line limit — and is null for
      // an interpolated one, which no name uses.
      final first = args.isEmpty ? null : args.first;
      final name = first is StringLiteral ? first.stringValue : null;
      if (name != null) {
        Expression? skip;
        for (final a in args) {
          if (a is NamedExpression && a.name.label.name == 'skip') {
            skip = a.expression;
          }
        }
        // `skip: false` and `skip: null` mean "not skipped", so neither is an
        // unconditional skip; only a reason string or `true` is.
        final literalSkip =
            (skip is StringLiteral && skip.stringValue != null) ||
            (skip is BooleanLiteral && skip.value);
        decls.add(
          _Decl(
            name: name,
            file: file,
            hasSkip: skip != null,
            unconditionallySkipped: literalSkip && !_conditionalSite(node),
          ),
        );
      }
    }
    super.visitMethodInvocation(node);
  }
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it runs
  // in, so a copy anywhere else measures a different corpus in silence.
  requirePackage('tom_d4rt', subject: 'both trees\' test corpora');

  final files = <File>[];
  for (final root in _roots) {
    final dir = Directory(root);
    if (!dir.existsSync()) continue;
    files.addAll(
      dir
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart')),
    );
  }
  files.sort((a, b) => a.path.compareTo(b.path));

  final decls = <_Decl>[];
  for (final file in files) {
    final unit = parseString(
      content: file.readAsStringSync(),
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    ).unit;
    final collector = _DeclCollector(file.path);
    unit.accept(collector);
    decls.addAll(collector.decls);
  }

  group('SCE89: a skip tag and the skip itself agree', () {
    test('F-SCE89-1: an unconditionally skipped test says so in its '
        'description [2026-09-21] (PASS)', () {
      // The `(PASS)`-and-skipped row. testkit writes the tag into the baseline
      // column, so a skipped test tagged `(PASS)` reports a passing test that
      // never ran — and the honest form costs one word.
      final untagged = decls
          .where((d) => d.unconditionallySkipped && !d.tagged)
          .toList();
      expect(
        untagged,
        isEmpty,
        reason:
            'These tests are skipped on every machine and their descriptions '
            'do not say so. Tag each `(SKIP)` and state the reason in the '
            '`skip:` argument — `F-SCD4-10` in `scd4_await_for_break_test.dart` '
            'is the form, naming the todo that owns '
            'it.\n${untagged.join('\n')}',
      );
    });

    test('F-SCE89-2: a description claiming a skip has one [2026-09-21] '
        '(PASS)', () {
      // The other direction, and the cheaper mistake to make: a tag left
      // behind when the `skip:` was removed. The baseline column then reads
      // `-` for a test that ran, so a real regression in it is invisible.
      //
      // Deliberately asks only that a `skip:` argument EXISTS, not that it is
      // unconditional: a conditionally skipped test may reasonably carry the
      // tag, and this guard has nothing to say about which machine it is read
      // on.
      final lying = decls.where((d) => d.tagged && !d.hasSkip).toList();
      expect(
        lying,
        isEmpty,
        reason:
            'These descriptions claim to be skipped and pass no `skip:` '
            'argument, so they run. Remove the tag, or restore the skip with '
            'its reason.\n${lying.join('\n')}',
      );
    });

    test('F-SCE89-3 (control): the scan read both corpora [2026-09-21] '
        '(PASS)', () {
      // Ordered last but read first on a failure: the two cases above are
      // emptiness assertions, and an empty scan satisfies both without having
      // looked at anything. That is the failure this file would otherwise be
      // most likely to have, because it walks a SIBLING package whose absence
      // is silent.
      expect(
        files.length,
        greaterThanOrEqualTo(_minFiles),
        reason:
            'Found only ${files.length} files across ${_roots.join(' and ')}. '
            'That is not a finding about either suite — the walk did not run. '
            'Tests are expected to run with the package root as the working '
            'directory.',
      );
      expect(
        decls.length,
        greaterThanOrEqualTo(_minNames),
        reason:
            'Found only ${decls.length} test or group names in '
            '${files.length} files, so the collector stopped recognising '
            'them and the cases above are asserting over nothing.',
      );
      expect(
        decls.where((d) => d.file.startsWith('../tom_d4rt_ast')),
        isNotEmpty,
        reason:
            'No declarations were read from the twin, so this guard is '
            'covering one tree while claiming both. The twin has no '
            'equivalent check of its own — it cannot depend on the analyzer '
            '— so nothing else would notice.',
      );
    });
  });
}
