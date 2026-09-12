// SCD50 — no test in this suite is expected to fail.
//
// WHY THIS IS A TEST AND NOT A CONVENTION. `limitations_and_bugs_test.dart`
// carried a group called "Open Bugs - Won't Fix (SHOULD FAIL)" whose one
// occupant asserted `isA<({int x, int y})>()` on a value the interpreter cannot
// produce, because Dart has no runtime API for building a record with named
// fields. It was meant to fail, and it did, on every run.
//
// The cost was not the one red line. It was that "the suite is green" stopped
// being a sentence anyone could say about this package: every verification step
// became "the suite shows exactly one failure, and it is the expected one",
// which requires the reader to already know which failure is expected. That
// knowledge decayed exactly as you would predict — one session's notes named a
// DIFFERENT single expected failure (a timing diagnostic) from the next's, and
// nobody noticed the substitution. A signal that needs human memory to
// interpret is not a signal.
//
// It also devalues every other guard here. This package now carries a dozen
// tests whose entire worth is that they go red on a real defect. A suite with a
// standing red line teaches the reader to skim the failure list.
//
// WHAT IS CHECKED. Two declarations of intent, both static:
//
//   * a test description tagged `(FAIL)`. The workspace convention is
//     `ID: description [date] (result)`, and testkit reads that `(result)` into
//     the baseline CSV — so a stale tag is not cosmetic, it makes the baseline
//     column say `OK/X` ("newly fixed!") on every run for ever.
//   * a group whose name says `SHOULD FAIL`.
//
// WHAT IS NOT CHECKED, and should not be read in. This finds tests DECLARED to
// fail, not tests that do. A test can of course break without being labelled —
// that is what running the suite is for, and no source scan substitutes for it.
// The claim here is narrower and worth exactly what it says: nobody has written
// down an intention to ship a red line.
//
// THE HONEST WAYS TO KEEP A KNOWN BOUNDARY, since removing the label must not
// mean removing the coverage:
//
//   * assert the CURRENT behaviour and say in a comment that a change is the
//     interesting event. `I-BUG-14a` does this — it asserts the record is NOT
//     native, so it passes while the gap is open and goes red when it closes.
//     This is the preferred form: the test stays load-bearing.
//   * `skip:` with a stated reason, tagged `(SKIP)`. `F-SCD4-10` does this,
//     naming the todo that owns it. This keeps the record but loses the
//     coverage, so prefer the first.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                      | Fires |
//   | --------------------------------------------------- | ----- |
//   | a test description retagged `(FAIL)`                 | 2     |
//   | a group renamed to include `SHOULD FAIL`             | 2     |
//   | the scan pointed at a directory with no test files   | 1     |
//   | `(FAIL)` written in a COMMENT rather than a name     | nothing |
//
// The last row is why this parses rather than greps, and it needs no separate
// injection: this header writes the tag a dozen times and the file passes. A
// grep-based version would fail on its own documentation — which has happened
// three times elsewhere in this quest.

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

const _testRoot = 'test';

/// Floors under the two emptiness assertions below. A scan that matched nothing
/// — a renamed directory, or an analyzer change that stopped `test(...)` from
/// parsing as a `MethodInvocation` — satisfies "no description says (FAIL)"
/// perfectly. Measured 2026-09-12 at 249 files and 3684 names; the floors sit
/// far below so that adding or removing a file is never an edit here.
const _minFiles = 100;
const _minNames = 1000;

/// One `test(...)` or `group(...)` name, and where it was written.
class _Name {
  const _Name(this.kind, this.text, this.file);
  final String kind; // 'test' or 'group'
  final String text;
  final String file;

  @override
  String toString() => '$file\n      $kind: $text';
}

/// Collects the first string argument of every `test(...)` / `group(...)`.
class _NameCollector extends RecursiveAstVisitor<void> {
  _NameCollector(this.file);
  final String file;
  final names = <_Name>[];

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final kind = node.methodName.name;
    if (kind == 'test' || kind == 'group') {
      final args = node.argumentList.arguments;
      if (args.isNotEmpty) {
        final first = args.first;
        // `stringValue` covers adjacent string literals — which is how most
        // descriptions here are written, since they run past the line limit —
        // and returns null for an interpolated one, which no name uses.
        if (first is StringLiteral) {
          final value = first.stringValue;
          if (value != null) names.add(_Name(kind, value, file));
        }
      }
    }
    super.visitMethodInvocation(node);
  }
}

void main() {
  final files = Directory(_testRoot).existsSync()
      ? (Directory(_testRoot)
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path)))
      : <File>[];

  final names = <_Name>[];
  for (final file in files) {
    final unit = parseString(
      content: file.readAsStringSync(),
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    ).unit;
    final collector = _NameCollector(file.path);
    unit.accept(collector);
    names.addAll(collector.names);
  }

  test('F-SCD50-1: the scan read a real corpus of test names [2026-09-12]', () {
    // Ordered first: F-SCD50-2 is an emptiness assertion, and an empty scan
    // satisfies it without having looked at anything.
    expect(
      files.length,
      greaterThanOrEqualTo(_minFiles),
      reason:
          'Found only ${files.length} files under $_testRoot/. That is not a '
          'finding about the suite — the walk did not run. Tests are expected '
          'to run with the package root as the working directory.',
    );
    expect(
      names.length,
      greaterThanOrEqualTo(_minNames),
      reason:
          'Read ${names.length} test/group names from ${files.length} files, '
          'which is too few to be the real corpus. The likeliest cause is that '
          '`test(...)` stopped parsing as a MethodInvocation with a literal '
          'first argument — the same trap F-SCB24-2 exists for, where a scan '
          'read 0 of 205 names and its emptiness assertion passed.',
    );
  });

  test('F-SCD50-2: no test declares that it is expected to fail '
      '[2026-09-12]', () {
    final declared = <String>[];
    for (final name in names) {
      if (name.kind == 'test' && name.text.contains('(FAIL)')) {
        declared.add('  $name');
      }
      if (name.kind == 'group' &&
          name.text.toUpperCase().contains('SHOULD FAIL')) {
        declared.add('  $name');
      }
    }
    declared.sort();

    expect(
      declared,
      isEmpty,
      reason:
          'These names declare an expected failure:\n${declared.join('\n')}\n\n'
          'A suite with a sanctioned red line cannot be used as a gate: every '
          'check of it becomes "one failure, and it is the expected one", '
          'which needs the reader to already know which one. That knowledge '
          'has drifted here before.\n\n'
          'If the test PASSES, the tag is simply stale — three were, in '
          'sync_generator_test.dart, tagged (FAIL) while passing since '
          '2026-02-10. Retag to (PASS).\n'
          'If it genuinely fails, assert the current behaviour and comment '
          'that a change is the interesting event (see I-BUG-14a), or skip it '
          'with a stated reason and tag it (SKIP) (see F-SCD4-10). Prefer the '
          'first: it keeps the test load-bearing.',
    );
  });
}
