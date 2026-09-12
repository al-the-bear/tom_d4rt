// SCD51 — the member-coverage audit, made standing for the ANALYZER-FREE tree.
//
// `tom_d4rt` has had this guard since SCC13: the members no script can reach
// are pinned, and the next one to appear fails a test. This tree — the one that
// ships inside Flutter apps — had nothing, and `conformance_drift_test.dart`
// records the reference's file as NOT PORTABLE, correctly: it reflects over
// *that* package's registry, so a copy with the import rewritten would measure
// the reference while appearing to measure this one.
//
// This runs `tool/stdlib_member_audit.dart` — the tool's own `auditMembers`,
// not a reimplementation — and compares against `stdlib_member_baseline.dart`.
//
// FOUR TESTS, SPLIT BY REMEDY, for the reason SCC13 arrived at: a single
// "matches the baseline" assertion cannot tell a regression from an
// improvement, so it teaches people to regenerate reflexively, and once that
// reflex exists the guard is decorative.
//
//   1. the audit measured almost nothing        -> fix the environment
//   2. a member that was reachable is not       -> fix the bridge
//   3. a class stopped being diffable           -> the measurement went dark
//   4. the baseline no longer matches reality   -> regenerate it
//
// Only (4) is ever answered by regenerating, and (4) can only be provoked by
// good news — a gap closing. A regression shows up as (2) or (3), which
// regenerating does not silence on its own.
//
// HOW THIS DIFFERS FROM THE REFERENCE, and why it is not weaker where it
// counts. The reference decides reachability by RUNNING a script per candidate.
// This package cannot execute source, so the audit walks the registered
// supertype chain instead — the same walk `lookupOnBridgedSupertypes` performs
// at run time. Calibrated against the reference's empirical result on
// 2026-09-12: exact agreement on all 644 ordinary named members, in both
// directions, and total disagreement on the 63 operators and `Object`
// universals, which are therefore excluded. The tool's header carries the
// table. One consequence is worth knowing: the chain walk needs no instance,
// so it decides the 36 members the reference cannot measure at all for want of
// an instance recipe.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                       | Fires   |
//   | ---------------------------------------------------- | ------- |
//   | only `Stdlib.register` run, the five lazy ones cut    | 1 and 3 |
//   | `Duration.inDays` getter deleted from the bridge      | 2       |
//   | a member added to the baseline by hand                | 4       |
//
// The first row was expected to fire 1 alone and fires 3 as well, which is
// correct and worth knowing: cutting the registrars removes the classes those
// registrars own, so they leave `auditedClasses` too. It also means test 3 has
// a control after all — the guess when this file was written was that it could
// not be provoked without editing the SDK, on the theory that a class only
// stops being diffable when `dart:mirrors` stops reflecting it. Losing its
// registration does the same thing.
//
// Read F-SCD51-1 first when both are red. Test 3 is the per-class version of
// the same check: wholesale failure trips 1, one class quietly dropping out
// trips 3, and without 3 a class leaving the audit would read as good news in
// test 4.

@Timeout(Duration(minutes: 2))
library;

import 'package:test/test.dart';

import '../tool/stdlib_member_audit.dart';
import 'stdlib_member_baseline.dart';

/// Floors that a regenerated baseline cannot lower, because they live here.
///
/// If the registrars stopped running, the audit would find no classes, no
/// candidates and no gaps — and every comparison below would pass on an empty
/// measurement. Regenerating in that state would write the emptiness down as
/// expected and the suite would stay green for ever, having measured nothing.
///
/// Measured 2026-09-12 at 205 classes examined and 624 members resolving
/// through the chain. The floors sit far below so that adding a bridge is never
/// an edit here — their job is to separate "measured" from "measured nothing".
const _minClassesExamined = 100;
const _minReachable = 300;

void main() {
  late List<ClassAudit> audits;
  late Map<String, Set<String>> observedUnreachable;
  late Set<String> observedAudited;
  late int observedReachable;

  setUpAll(() {
    audits = auditMembers(buildFullyRegisteredEnvironment());
    observedUnreachable = {
      for (final a in audits)
        if (a.unreachable.isNotEmpty) a.name: a.unreachable.toSet(),
    };
    observedAudited = {
      for (final a in audits)
        if (a.error == null) a.name,
    };
    observedReachable = audits.fold<int>(0, (s, a) => s + a.reachable.length);
  });

  test('F-SCD51-1: the audit measured something [2026-09-12]', () {
    // Ordered first because the other three compare against a measurement, and
    // an empty measurement agrees with an empty baseline.
    expect(
      audits.length,
      greaterThanOrEqualTo(_minClassesExamined),
      reason:
          'The audit examined only ${audits.length} bridged classes. That is '
          'not a coverage finding — the environment did not come up. Check '
          'that `dart run tool/stdlib_member_audit.dart` works before trusting '
          'any other result in this file.',
    );
    expect(
      observedReachable,
      greaterThanOrEqualTo(_minReachable),
      reason:
          'Only $observedReachable members resolved through a supertype chain, '
          'so almost nothing was classified. The likeliest cause is that the '
          'supertype registry is empty — every candidate then reads as '
          'unreachable, and test 2 would report the whole SDK surface as a '
          'regression.',
    );
  });

  test('F-SCD51-2: no member that was reachable is unreachable now '
      '[2026-09-12]', () {
    // The regression guard. Every member this run found unreachable must
    // already be a known gap.
    final regressions = <String>[];
    for (final entry in observedUnreachable.entries) {
      final known = unreachableMembers[entry.key] ?? const <String>[];
      for (final member in entry.value) {
        if (!known.contains(member)) regressions.add('${entry.key}.$member');
      }
    }
    regressions.sort();

    // The message carries the members, not just a count: a count cannot tell
    // "closed two and opened two" from "no change".
    expect(
      regressions,
      isEmpty,
      reason:
          'These members are unreachable from interpreted code and were not '
          'before:\n  ${regressions.join('\n  ')}\n\n'
          'Each is a member a script can no longer call. Do not regenerate the '
          'baseline to make this pass — that records the breakage as expected. '
          'Fix the bridge. If the member is deliberately unbridged, the '
          'reference tree records that in doc/d4rt_limitations.md and its own '
          'intentionally_unbridged_test.dart; say so there, then regenerate '
          'here in the same change.',
    );
  });

  test('F-SCD51-3: every class the baseline was measured with is still '
      'diffable [2026-09-12]', () {
    // Without this the guard can go dark and still report success. A class that
    // stops reflecting contributes no candidates, so all of its gaps vanish
    // from the observed set — which test 4 would otherwise announce as a gap
    // closing, i.e. as good news.
    final wentDark = auditedClasses.difference(observedAudited).toList()
      ..sort();

    expect(
      wentDark,
      isEmpty,
      reason:
          'These classes no longer diff against an SDK surface, so nothing '
          'about them is being measured:\n  ${wentDark.join('\n  ')}\n\n'
          'Either the bridge was removed — which is the larger regression, and '
          'the registry pin in the reference tree is what names it — or its '
          'native type stopped being reflectable. Three classes are undiffable '
          'by design (a bridged top-level function, and types `dart:mirrors` '
          'will not reflect); a fourth joining them is not automatically one '
          'of those.',
    );
  });

  test('F-SCD51-4: the baseline still describes reality [2026-09-12]', () {
    // The bookkeeping test, and the only one "just regenerate it" answers. It
    // can only be provoked by a gap closing.
    final closed = <String>[];
    for (final entry in unreachableMembers.entries) {
      // A class that dropped out of the audit entirely is F-SCD51-3's finding,
      // not staleness — skipping it here keeps one event from being reported
      // twice with two different remedies.
      if (!observedAudited.contains(entry.key)) continue;
      final now = observedUnreachable[entry.key] ?? const <String>{};
      for (final member in entry.value) {
        if (!now.contains(member)) closed.add('${entry.key}.$member');
      }
    }
    closed.sort();

    expect(
      closed,
      isEmpty,
      reason:
          'Good news, and the baseline has not caught up. These are no longer '
          'unreachable:\n  ${closed.join('\n  ')}\n\n'
          'Regenerate with: dart run tool/stdlib_member_audit.dart --baseline\n'
          'Commit the regenerated baseline together with the change that '
          'caused it, so the diff shows which members moved and why.',
    );
  });
}
