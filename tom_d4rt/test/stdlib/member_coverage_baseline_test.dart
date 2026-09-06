// SCC13: the member-coverage audit, made standing.
//
// `tool/stdlib_member_diff.dart` measures which stdlib members no script can
// reach. It found gaps that had been accumulating for months, and they had
// accumulated for exactly one reason: nothing failed when they appeared. A tool
// that has to be remembered measures the past, not the present.
//
// This file runs that same audit — the tool's own `collectMemberDiffs` and
// `verifyAll`, not a reimplementation of them — and compares the result against
// the checked-in baseline in `member_coverage_baseline.dart`.
//
// THE THREE TESTS ARE DELIBERATELY NOT ONE. A single "matches the baseline"
// assertion cannot distinguish a regression from an improvement, so it teaches
// people to regenerate the baseline reflexively, and once that reflex exists the
// guard is decorative. Split by *remedy* instead:
//
//   1. a member that used to be reachable is not any more  -> a defect to fix
//   2. a recipe stopped producing an instance              -> the measurement went dark
//   3. the baseline no longer describes reality            -> regenerate it
//
// Only (3) is ever a correct response to "regenerate", and (3) can only be
// triggered by good news: gaps closing, or blind spots becoming measurable. A
// regression always shows up as (1) or (2), which regenerating does not silence
// on its own — so the reflex is safe to have.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL. A guard nobody has watched fail is a
// guess about a guard. Each row was produced by breaking the thing named and
// checking that exactly the expected test went red:
//
//   | Injected fault                                | Fires    |
//   | --------------------------------------------- | -------- |
//   | every probe unable to answer (1µs timeout)    | 0 and 2  |
//   | `DateTime.year` adapter deleted               | 1        |
//   | `DateTime` instance recipe broken             | 2        |
//   | a baselined class no longer bridged           | 2        |
//   | baseline claims a gap that is bridged now     | 3        |
//   | `HttpRequest` instance recipe deleted         | F-SCC74-2|
//
// The last row is worth its own note: deleting the `WebSocketTransformer`
// recipe did NOT fire it, and that is correct. Its one candidate is bridged
// now, so with no recipe there is nothing left unmeasured. The guard reports a
// class that has candidates nobody can see, not a class without a recipe.
//
// The first row is why F-SCC13-0 and F-SCC13-2 exist: with the probe timeout at
// 1µs nothing was measured at all, and tests 1 and 3 PASSED — an empty
// measurement agrees with any baseline. Two of the four tests here are green on a
// run that learned nothing, so "the suite is green" is not by itself evidence
// that the audit ran.
//
// WHY THE DIFF DIRECTION IS ASYMMETRIC. Probe classification is not perfectly
// stable in principle: a probe that never answers is scored *reachable* (a
// missing member throws instantly, so a program still running got past the
// lookup). A loaded machine can therefore turn a real gap into an apparent
// pass — which surfaces as test 3, a bookkeeping failure. It cannot manufacture
// the opposite, because nothing about load makes a resolving member report
// "undefined". The one failure that means "you broke something" is the one that
// timing cannot fake.

@Timeout(Duration(minutes: 5))
library;

import 'package:test/test.dart';

import '../../tool/stdlib_member_diff.dart';
import 'member_coverage_baseline.dart';

/// One member's classification, as this run measured it.
enum _Now { gap, reachable, blind }

/// Floors that a regenerated baseline cannot lower, because they live here and
/// not in the generated file.
///
/// Every probe runs in a spawned isolate, and a probe that cannot answer is
/// scored as "not measured". So if isolate spawning were broken — or the
/// interpreter refused to start at all — the audit would find zero gaps, zero
/// working recipes, and all three comparisons below would pass on an empty
/// measurement. Regenerating the baseline in that state would then write the
/// emptiness down as expected and the suite would stay green for ever, having
/// measured nothing.
///
/// These two numbers are the floor under that. They are far below the real
/// figures (181 classes examined, 75 with a working recipe) because their job is
/// to separate "measured" from "measured nothing", not to pin the measurement —
/// pinning is what the baseline is for, and a tight floor here would just be a
/// second baseline to update.
const _minClassesExamined = 100;
const _minClassesMeasured = 40;

void main() {
  // The audit is ~600 interpreter probes, each in its own isolate. Measured at
  // ~7 seconds for the whole run, which is affordable once per suite and not
  // once per test — hence `setUpAll` and three tests reading one result.
  late Map<String, Map<String, _Now>> observed;
  late Set<String> observedMeasured;

  /// Bridged classes carrying unmeasured members with no stated reason.
  late Set<String> observedUnfinished;

  setUpAll(() async {
    final diffs = collectMemberDiffs(buildFullyRegisteredEnvironment());
    await verifyAll(diffs);

    observed = {};
    observedMeasured = {};
    observedUnfinished = {};
    for (final d in diffs) {
      if (d.unverifiedCount > 0 && d.notAuditableReason == null) {
        observedUnfinished.add(d.name);
      }
      if (d.recipeUsable) observedMeasured.add(d.name);
      final byMember = <String, _Now>{};
      for (final m in [
        ...d.missingInstance,
        ...d.missingStatic,
        ...d.missingOperators,
        ...d.missingUniversal,
      ]) {
        byMember[m] = _Now.gap;
      }
      for (final m in d.reachableViaFallback) {
        byMember[m] = _Now.reachable;
      }
      for (final m in [
        ...d.unverifiedInstance,
        ...d.unverifiedStatic,
        ...d.unverifiedOperators,
        ...d.unverifiedUniversal,
      ]) {
        byMember[m] = _Now.blind;
      }
      observed[d.name] = byMember;
    }
  });

  /// What the baseline says about `class.member`: a gap, a known blind spot, or
  /// nothing at all.
  String baselineStateOf(String cls, String member) {
    if (confirmedGaps[cls]?.contains(member) ?? false) return 'gap';
    // A declined member measures exactly like a gap and must not read as a
    // regression — the difference is why it is unreachable, not whether.
    if (declinedMembers[cls]?.contains(member) ?? false) return 'declined';
    if (unmeasurable[cls]?.contains(member) ?? false) return 'blind';
    return 'absent';
  }

  test('F-SCC13-0: the audit measured something [2026-09-04]', () {
    // Runs first because the other three are only meaningful if this one holds:
    // they all compare against a measurement, and an empty measurement agrees
    // with an empty baseline.
    expect(
      observed.length,
      greaterThanOrEqualTo(_minClassesExamined),
      reason:
          'The audit examined only ${observed.length} bridged classes. '
          'That is not a coverage finding — the environment did not come up.',
    );
    expect(
      observedMeasured.length,
      greaterThanOrEqualTo(_minClassesMeasured),
      reason:
          'Only ${observedMeasured.length} classes yielded an instance, so '
          'almost nothing was probed. Probes run in spawned isolates; if '
          'spawning fails, every probe reports "no answer" and the audit '
          'reports no gaps. Check that a plain '
          '`dart run tool/stdlib_member_diff.dart` works before trusting any '
          'other result in this file.',
    );
  });

  test('F-SCC13-1: no member that used to be reachable is unreachable now '
      '[2026-09-04]', () {
    // The regression guard. Every member this run confirmed unreachable must
    // already be a known gap — or a known blind spot, which becoming a gap is
    // new information rather than new breakage (a recipe was added, so something
    // previously unmeasurable can now be seen; scc12 moved 243 members this way
    // in one commit).
    final regressions = <String>[];
    for (final entry in observed.entries) {
      for (final member in entry.value.entries) {
        if (member.value != _Now.gap) continue;
        if (baselineStateOf(entry.key, member.key) == 'absent') {
          regressions.add('${entry.key}.${member.key}');
        }
      }
    }
    regressions.sort();

    // The message carries the members, not just the count. A count cannot tell
    // "closed two and opened two" from "no change", and closed-then-reopened is
    // precisely what happened to the typed lists before this guard existed.
    expect(
      regressions,
      isEmpty,
      reason:
          'These members are unreachable from interpreted code and were '
          'not before:\n  ${regressions.join('\n  ')}\n\n'
          'Each one is a member a script can no longer call. Do not regenerate '
          'the baseline to make this pass — that records the breakage as '
          'expected. Fix the bridge, or if the member is deliberately '
          'unbridged, say so in test/stdlib/intentionally_unbridged_test.dart.',
    );
  });

  test('F-SCC13-2: every recipe the baseline was measured with still produces '
      'an instance [2026-09-04]', () {
    // Without this the guard can go dark and still report success. A broken
    // instance recipe turns every one of its class's members UNVERIFIED, and
    // test 1 tolerates gap -> blind by design (a member that cannot be measured
    // must not be asserted about). So the tolerance needs a floor: the set of
    // classes that CAN be measured is itself pinned.
    //
    // This is also the per-class version of what F-SCC13-0 checks in aggregate.
    // Between them, "the audit silently stopped probing" cannot present as a
    // pass: wholesale failure trips F-SCC13-0, and one class quietly dropping
    // out trips this.
    final wentDark = measuredClasses.difference(observedMeasured).toList()
      ..sort();

    // A class the baseline has an opinion about that the registry no longer
    // contains at all. That is a deleted or renamed bridge — every member of it
    // is unreachable, which is the largest regression this file can encounter,
    // and it would otherwise slip past F-SCC13-1: that test walks what was
    // measured, and a class that is gone contributes nothing to walk.
    final vanished = <String>{
      ...confirmedGaps.keys,
      ...declinedMembers.keys,
      ...unmeasurable.keys,
    }.where((c) => !observed.containsKey(c)).toList()..sort();

    expect(
      [...wentDark, ...vanished],
      isEmpty,
      reason:
          '${vanished.isEmpty ? '' : 'These classes are no longer bridged at '
                    'all, so nothing about them is being measured:\n'
                    '  ${vanished.join('\n  ')}\n'
                    'A bridge that disappeared is a much larger regression than a '
                    'missing member — check that the registration was not dropped '
                    'before touching the baseline.\n\n'}'
          '${wentDark.isEmpty ? '' : 'The instance recipe for these classes no '
                    'longer yields an instance, so their members are not being '
                    'measured:\n  ${wentDark.join('\n  ')}\n'
                    'Either the recipe broke (fix it in _instanceRecipes) or this '
                    'platform cannot run it — and if it is the platform, record that '
                    'as a reason in _notAuditable rather than shrinking the baseline, '
                    'so the blind spot stays visible.'}',
    );
  });

  test('F-SCC74-2: every bridged class with unmeasured members has a stated '
      'reason [2026-09-06]', () {
    // The blackout this file could not see. F-SCC13-2 catches a recipe that
    // BREAKS; nothing caught a class that never had one. When SCC61..SCC63
    // bridged `HttpRequest`, `WebSocket` and `WebSocketTransformer`, no recipes
    // followed, and 73 members went straight into the unmeasurable bucket — the
    // same bucket as the classes with a documented reason. The totals moved
    // from "74 members on 4 classes" to "146 on 7" and every test here stayed
    // green, because the baseline folded the two kinds together.
    //
    // The tool has always known the difference: `notAuditableReason` is null
    // exactly when the class is expected to be measurable. This asserts on it.
    // Writing the three recipes found a real gap on the first run
    // (`WebSocketTransformer.cast`), which is the argument for the guard rather
    // than for tolerating the bucket.
    final unfinished = <String>[];
    for (final name in observedUnfinished) {
      unfinished.add(name);
    }
    unfinished.sort();
    expect(
      unfinished,
      isEmpty,
      reason:
          'These bridged classes have members nobody can measure, and no '
          'stated reason why:\n  ${unfinished.join('\n  ')}\n\n'
          'A bridged class with no instance recipe is invisible to this audit '
          '— its gaps cannot be found. Add a recipe to _instanceRecipes, or if '
          'the class genuinely cannot be instantiated in a probe, record that '
          'in _notAuditable so the blind spot is at least deliberate.',
    );
  });

  test('F-SCC13-3: the baseline still describes reality [2026-09-04]', () {
    // The bookkeeping test, and the only one "just regenerate it" answers. It
    // can only be provoked by improvements: a gap that closed, or a blind spot
    // that became measurable. Kept separate from test 1 so that the safe
    // response to one is never the response to the other.
    // A member LEAVING the candidate set is the ordinary way a gap closes, and
    // it is not the same event as it becoming reachable-via-fallback: adding the
    // missing adapter removes the member from the diff altogether, so it is
    // absent from `observed` rather than present-and-reachable. Checking only for
    // reachable missed exactly the case this guard is most likely to meet —
    // measured, by adding an adapter and watching the test stay green.
    final closed = <String>[];
    final nowMeasurable = <String>[];

    for (final entry in confirmedGaps.entries) {
      // A class missing from the registry entirely is F-SCC13-2's finding, not
      // staleness — skipping it here keeps one event from being reported twice
      // with two different meanings.
      final byMember = observed[entry.key];
      if (byMember == null) continue;
      for (final member in entry.value) {
        switch (byMember[member]) {
          case _Now.gap:
            break; // still a known gap
          case _Now.blind:
            break; // no longer measurable; F-SCC13-2 owns that
          case _Now.reachable:
            closed.add('${entry.key}.$member (reachable via fallback now)');
          case null:
            closed.add('${entry.key}.$member (bridged directly now)');
        }
      }
    }
    // A declined member becoming reachable is not "good news needing a
    // regenerate" — it means someone bridged something the limitations table
    // says is deliberately absent. Reported here because this is the test that
    // walks the baseline, but with its own wording: the remedy is to move the
    // row out of the doc and delete its pinning case, in the same change.
    final reversedDecisions = <String>[];
    for (final entry in declinedMembers.entries) {
      final byMember = observed[entry.key];
      if (byMember == null) continue;
      for (final member in entry.value) {
        if (byMember[member] != _Now.gap) {
          reversedDecisions.add('${entry.key}.$member');
        }
      }
    }
    reversedDecisions.sort();
    expect(
      reversedDecisions,
      isEmpty,
      reason:
          'These members are recorded in doc/d4rt_limitations.md as '
          'deliberately unbridged, and they are reachable now:\n'
          '  ${reversedDecisions.join('\n  ')}\n\n'
          'That is a decision being reversed, not a gap being closed. If it '
          'was intended, move the row out of the limitations table, delete its '
          'case in intentionally_unbridged_test.dart and drop it from '
          '_declined — all in the same change.',
    );

    for (final entry in unmeasurable.entries) {
      final byMember = observed[entry.key];
      if (byMember == null) continue;
      for (final member in entry.value) {
        switch (byMember[member]) {
          case _Now.blind:
            break; // still a blind spot
          case _Now.gap:
            nowMeasurable.add(
              '${entry.key}.$member (measurable, and a real gap)',
            );
          case _Now.reachable:
            nowMeasurable.add(
              '${entry.key}.$member (measurable, and reachable)',
            );
          case null:
            nowMeasurable.add('${entry.key}.$member (bridged directly now)');
        }
      }
    }
    closed.sort();
    nowMeasurable.sort();

    expect(
      [...closed, ...nowMeasurable],
      isEmpty,
      reason:
          'Good news, and the baseline has not caught up.\n'
          '${closed.isEmpty ? '' : 'No longer gaps:\n  ${closed.join('\n  ')}\n'}'
          '${nowMeasurable.isEmpty ? '' : 'No longer blind spots:\n  ${nowMeasurable.join('\n  ')}\n'}'
          '\nRegenerate with: '
          'dart run tool/stdlib_member_diff.dart --baseline\n'
          'Commit the regenerated baseline together with the change that caused '
          'it, so the diff shows which members moved and why.',
    );
  });
}
