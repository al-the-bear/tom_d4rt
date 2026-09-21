// SCE92 — this package's own test hygiene, because nothing else watches it.
//
// SCD53 set out to remove 50 stale `(FAIL)` labels from `tom_d4rt` and
// `tom_d4rt_exec` and found 204 across FOUR packages: 46 in exec — the figure
// it expected, exactly right — and 158 in the two generator packages, which
// the todo did not mention. 120 of those were here. 77% of the rot was in the
// packages nobody was looking at.
//
// THAT IS STRUCTURAL RATHER THAN AN OVERSIGHT. Every standing test-hygiene
// guard in this quest lives in a package that has one — `F-SCD50-2` in
// `tom_d4rt`, the `F-SCC6-*` family in `tom_d4rt_exec` — and this package had
// no such file at all, so a rule reached it only if somebody widened another
// package's walk to include it. One rule was widened that way; the rest were
// not, and the labels rotted for as long as the corpus existed.
//
// WHAT IS CHECKED, and it is deliberately two rules rather than every rule the
// other packages carry:
//
//   * a test or group DECLARED to fail — `(FAIL)` in the description, or
//     `SHOULD FAIL` in a group name. `F-SCD50-2`'s rule.
//   * a `KNOWN-GAP()` marker naming no owner. `F-SCC6-5`'s first half.
//
// Both are rules this package has been caught breaking. The rest were measured
// before being left out, which is the part worth recording: on 2026-09-21 this
// package has zero `skip:` arguments, zero `(SKIP)` tags and zero
// `markTestSkipped` calls, so SCE89's skip-tag agreement rule would guard an
// empty corpus with no history of rot behind it. Add it when a skip arrives.
//
// THE CORPUS IS CLEAN TODAY — SCD53 removed all 120 — so both rules are
// RATCHETS, which is the right shape for them: they stop the pattern
// reappearing rather than cleaning anything up, and the 120 are the evidence
// that it does reappear.
//
// IT PARSES RATHER THAN GREPS for `(FAIL)`. A regex matches the tag in a
// COMMENT, so a file documenting the rule fails it — which has happened three
// times elsewhere in this quest, and this header writes the tag five times.
// The marker rule is line-based on purpose: a marker IS a comment.
//
// EACH CASE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                     | Fires |
//   | -------------------------------------------------- | ----- |
//   | a test description retagged `(FAIL)`                | 1     |
//   | a group renamed to include `SHOULD FAIL`            | 1     |
//   | a `// KNOWN-GAP():` marker with empty brackets      | 2     |
//   | the scan pointed at a directory with no test files  | 3     |
//   | `(FAIL)` written in a COMMENT rather than in a name | nothing |

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

const _testRoot = 'test';

/// Floors under the emptiness assertions. A scan that matched nothing — a
/// renamed directory, or an analyzer change that stopped `test(...)` parsing as
/// a `MethodInvocation` — satisfies both rules perfectly. Measured 2026-09-21
/// at 127 files and about 1360 names; the floors sit far below, so adding or
/// removing a file is never an edit here.
const _minFiles = 60;
const _minNames = 400;

/// One `test(...)` or `group(...)` name, and where it was written.
class _Name {
  const _Name(this.kind, this.text, this.file);
  final String kind;
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
        // `stringValue` covers adjacent string literals — how longer
        // descriptions are written — and is null for an interpolated one.
        if (first is StringLiteral) {
          final value = first.stringValue;
          if (value != null) names.add(_Name(kind, value, file));
        }
      }
    }
    super.visitMethodInvocation(node);
  }
}

/// A marker written as a line comment, e.g. `// KNOWN-GAP(todo-id): ...`.
///
/// Line-based, and a `///` doc comment is deliberately not a marker: the
/// convention is documented by writing the syntax out, and a doc comment that
/// counted as a use would make every file explaining the rule look like a file
/// applying it.
final RegExp _markerPattern = RegExp(
  r'^//\s*(KNOWN-GAP\([^)]*\)|WONT-FIX|PUBLISH-PIN\([^)]*\))\s*:',
);

List<String> _markers(String source) => [
  for (final line in source.split('\n'))
    if (_markerPattern.firstMatch(line.trimLeft()) case final m?) m.group(1)!,
];

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
  final unowned = <String>[];
  for (final file in files) {
    final source = file.readAsStringSync();
    final unit = parseString(
      content: source,
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    ).unit;
    final collector = _NameCollector(file.path);
    unit.accept(collector);
    names.addAll(collector.names);

    for (final marker in _markers(source)) {
      if (marker.startsWith('KNOWN-GAP') &&
          marker.substring(10, marker.length - 1).trim().isEmpty) {
        unowned.add('${file.path}: $marker');
      }
    }
  }

  group('SCE92: this package keeps its own test hygiene', () {
    test('F-SCE92-1: no test is declared to fail [2026-09-21] (PASS)', () {
      // The rule SCD50 wrote for `tom_d4rt`, and the one this package had 120
      // violations of. A stale tag is not cosmetic: testkit reads `(result)`
      // out of the description into the baseline CSV, so the column reads
      // `OK/X` — "newly fixed!" — on every run for ever.
      final declared = names
          .where(
            (n) =>
                n.text.contains('(FAIL)') ||
                (n.kind == 'group' && n.text.contains('SHOULD FAIL')),
          )
          .toList();
      expect(
        declared,
        isEmpty,
        reason:
            'These declare an expected failure. A suite with a standing red '
            'line cannot say "the suite is green", and every other guard here '
            'is worth less for it. The honest forms are to assert the CURRENT '
            'behaviour and say in a comment that a change is the interesting '
            'event, or to `skip:` with a stated reason and tag the description '
            '`(SKIP)`.\n${declared.join('\n')}',
      );
    });

    test('F-SCE92-2: every pinned known gap names an owner [2026-09-21] '
        '(PASS)', () {
      // `F-SCC6-5`'s first half, which reaches ref and exec and not this
      // package. A `KNOWN-GAP()` with nothing in the brackets is the marker
      // equivalent of a bare `// TODO`: it records that somebody noticed, and
      // nothing else. `WONT-FIX` carries its own decision and needs no id.
      expect(
        unowned,
        isEmpty,
        reason:
            'A pinned gap does not name the todo that will delete it. Name '
            'one, or — if nothing will ever fix it — say so with WONT-FIX and '
            'the reason.\n${unowned.join('\n')}',
      );
    });

    test('F-SCE92-3 (control): the scan read a real corpus [2026-09-21] '
        '(PASS)', () {
      // Read first on a failure: the two rules above are emptiness assertions,
      // and an empty scan satisfies both without having looked at anything.
      // That is not hypothetical here — the reason this package went 120
      // violations deep is that nothing was looking, and a vacuous green is
      // indistinguishable from that state.
      expect(
        files.length,
        greaterThanOrEqualTo(_minFiles),
        reason:
            'Found only ${files.length} files under $_testRoot/. That is not a '
            'finding about the suite — the walk did not run. Tests are '
            'expected to run with the package root as the working directory.',
      );
      expect(
        names.length,
        greaterThanOrEqualTo(_minNames),
        reason:
            'Found only ${names.length} test or group names in '
            '${files.length} files, so the collector stopped recognising them '
            'and the rules above are asserting over nothing.',
      );
    });
  });
}
