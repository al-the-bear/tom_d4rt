// REPO-WIDE GUARD (tom_d4rt) — the quest overview states no figure that rots on a schedule nobody owns.
//
// Its subject reaches OUTSIDE this package — it reads
// `_ai/quests/d4rt/overview.d4rt.md` — so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// WHAT WENT WRONG TWICE. The overview's "## Current State" section carried a
// version per package, stamped "working-tree versions as of 2026-07-28". By
// 2026-09-15 every one was wrong — `tom_d4rt` by 92 minors, `tom_d4rt_ast` by
// 86 — and so was every exact line count in the same section, by up to 31%.
// SCC59 had already removed the identical defect from the verification
// protocol a few hundred lines above, which is the reason this is a guard and
// not a one-off edit: the fix does not stay fixed on its own.
//
// WHY A PATTERN GUARD AND NOT A VERSION CHECK. A guard that compares the
// document against `pubspec.yaml` would fire on every single publish, turning
// a documentation nicety into a release-time chore — and this quest publishes
// several times a day during a campaign. This one fires only when someone
// re-introduces the shape, so its maintenance cost is zero until it has
// something to say.
//
// WHAT IS DELIBERATELY NOT BANNED: a version that DATES A CAPABILITY.
// "`checkBridgeFreshness` (tom_d4rt_generator >= 1.17.0)" and "from
// tom_d4rt_generator 1.20.0 every generated file's header reads ..." are
// provenance claims about when something arrived, and they never go stale. A
// heading stamp is a currency claim about what the package IS, and it is stale
// the moment the next commit lands. The discriminator is the claim, not the
// digits.

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

/// The quest overview this guard reads.
///
/// Read rather than mirrored, for the reason `conformance_drift_test.dart`
/// already gives about the quest todo file: a copy here would have to be
/// updated by the same person at the same moment, and would then be checking
/// their memory against itself.
File _overview() => File('../../../_ai/quests/d4rt/overview.d4rt.md');

/// A version stamp in a markdown heading: `### tom_d4rt (v1.23.0) — Mature`.
final RegExp _headingVersionStamp = RegExp(
  r'^#{1,6} .*\(v?\d+\.\d+\.\d+',
  multiLine: true,
);

/// An exact or approximate line count: `(13,088 lines)`, `~1800 lines`,
/// `~10,000-line`.
final RegExp _lineCount = RegExp(r'~?[\d,]{3,}[- ]lines?\b', multiLine: true);

/// The text as it stood before SCD165, for the control case.
const _historicalSample = '''
### tom_d4rt (v1.23.0) — Mature
- Core interpreter: `interpreter_visitor.dart` (13,088 lines), `d4rt_base.dart` (3,249 lines)
  - **Pass 2** (`InterpreterVisitor`): a ~10,000-line `GeneralizingAstVisitor<Object?>`
''';

void main() {
  // SCD158: the overview is located relative to this package, so a copy
  // anywhere else reads a different path or none. SCD200: it is also what keeps
  // the file out of tom_d4rt_exec's conformance census — the quest overview is
  // one document, and a second guard over it is a second red for one cause.
  requirePackage('tom_d4rt', subject: 'the d4rt quest overview document');

  group('SCD165: the quest overview carries no figure that rots', () {
    test('F-SCD165-1: the overview was found and read [2026-09-15] (PASS)', () {
      // Anti-vacuity: every case below asks whether a pattern is ABSENT, and
      // an unreadable file satisfies all of them while checking nothing.
      final file = _overview();
      expect(
        file.existsSync(),
        isTrue,
        reason:
            '${file.path} not found. The `_ai` layer is symlinked into every '
            'workspace on every fleet machine, so its absence is a broken '
            'checkout rather than a supported configuration — fix the mount '
            'rather than skipping this guard.',
      );
      expect(file.readAsLinesSync().length, greaterThan(400));
    });

    test('F-SCD165-2: no heading carries a version stamp '
        '[2026-09-15] (PASS)', () {
      final offenders = _headingVersionStamp
          .allMatches(_overview().readAsStringSync())
          .map((m) => m.group(0)!)
          .toList();
      expect(
        offenders,
        isEmpty,
        reason:
            'A version in a heading is a currency claim, and it is stale the '
            'moment the next commit lands — the interpreter pair moves several '
            'minors a day during a campaign. Describe the package and let '
            "`grep -m1 '^version:' tom_ai/d4rt/*/pubspec.yaml` answer the "
            'version question. Dating a capability ("from 1.20.0 on ...") is '
            'fine and is not what this matches.',
      );
    });

    test('F-SCD165-3: no line count is written out [2026-09-15] (PASS)', () {
      final offenders = _lineCount
          .allMatches(_overview().readAsStringSync())
          .map((m) => m.group(0)!)
          .toList();
      expect(
        offenders,
        isEmpty,
        reason:
            'Line counts rot exactly like versions and are less visibly wrong: '
            'the four in "Current State" had drifted by up to 31% and the '
            '"~1800 lines" in Architecture was off by 92%, which is not an '
            'approximation. State the relative claim (largest file in the '
            'package, mirror of its twin) — that is what the number was '
            'standing in for, and it does not rot.',
      );
    });

    test('F-SCD165-4 (control): both patterns match the text they were '
        'written against [2026-09-15] (PASS)', () {
      // Without this, a typo in either regex turns F-SCD165-2/3 into tests
      // that pass because they can no longer recognise their own subject.
      expect(_headingVersionStamp.allMatches(_historicalSample), hasLength(1));
      expect(
        _lineCount
            .allMatches(_historicalSample)
            .map((m) => m.group(0))
            .toList(),
        ['13,088 lines', '3,249 lines', '~10,000-line'],
      );
    });

    test('F-SCD165-5: a version that DATES A CAPABILITY is not flagged '
        '[2026-09-15] (PASS)', () {
      // The over-broad version of this guard bans every semver in the
      // document, which would delete two true and permanent statements.
      const provenance =
          'checkBridgeFreshness (`tom_d4rt_generator` >= 1.17.0) regenerates '
          'into a scratch tree, and from `tom_d4rt_generator` 1.20.0 every '
          'generated file carries a header.';
      expect(_headingVersionStamp.hasMatch(provenance), isFalse);
      expect(_lineCount.hasMatch(provenance), isFalse);
    });
  });
}
