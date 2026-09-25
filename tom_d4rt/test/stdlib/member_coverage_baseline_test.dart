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
// THE TESTS ARE DELIBERATELY NOT ONE. A single "matches the baseline"
// assertion cannot distinguish a regression from an improvement, so it teaches
// people to regenerate the baseline reflexively, and once that reflex exists the
// guard is decorative. Split by *remedy* instead:
//
//   1. a member that used to be reachable is not any more  -> a defect to fix
//   2. a recipe stopped producing an instance              -> the measurement went dark
//   3. the baseline no longer describes reality            -> regenerate it
//   4. a name is gone from the registry (SCD48)            -> a bridge was renamed or deleted
//
// Only (3) is ever a correct response to "regenerate", and (3) can only be
// triggered by good news: gaps closing, blind spots becoming measurable, or a
// class newly bridged. A regression always shows up as (1), (2) or (4), which
// regenerating does not silence on its own — so the reflex is safe to have.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL. A guard nobody has watched fail is a
// guess about a guard. Each row was produced by breaking the thing named and
// checking that exactly the expected tests went red — the Fires column is what
// was observed, not what was expected:
//
//   | Injected fault                                  | Fires                   |
//   | ----------------------------------------------- | ----------------------- |
//   | every probe unable to answer (1µs timeout)      | 0, 2, 3, F-SCC74-2      |
//   | `DateTime.year` adapter deleted                 | 1                       |
//   | `DateTime` instance recipe broken               | 2                       |
//   | a baselined class no longer bridged             | 2                       |
//   | baseline claims a gap that is bridged now       | 3                       |
//   | `HttpRequest` instance recipe deleted           | F-SCC74-2               |
//   | `FileLock` bridge renamed to `FileLockZ`        | F-SCD48-1 and 3         |
//   | `IoStdlib.register` dropped from the env builder| F-SCD48-1 (bulk) and 2  |
//   | `JsonUtf8Encoder`'s `defineBridge` deleted      | F-SCD48-1, and F-SCB24-1 |
//   | a name cut from `bridgedClasses` by hand        | 3                       |
//
// The `HttpRequest` row is worth its own note: deleting the
// `WebSocketTransformer` recipe did NOT fire it, and that is correct. Its one
// candidate is bridged now, so with no recipe there is nothing left unmeasured.
// The guard reports a class that has candidates nobody can see, not a class
// without a recipe.
//
// The first row is why F-SCC13-0 exists: with the probe timeout at 1µs nothing
// was measured at all, and test 1 — the regression guard, the one people care
// about — PASSED, because an empty measurement agrees with any baseline. (3 and
// F-SCC74-2 do fire on that run, but for reasons unrelated to the point: every
// declined member reads as unmeasurable, and every class then has unexplained
// unmeasured members. Neither says "the audit did not run", which is what
// F-SCC13-0 says.) So "the suite is green" is not by itself evidence that the
// audit ran.
//
// F-SCD48-1 IS THE EXCEPTION TO ALL OF THAT, and deliberately: it reads the
// registry rather than a probe result, so it is the one test in this file that
// still means something on a machine where probing has gone dark. Measured —
// it is the only test here that stays green under the 1µs timeout.
//
// WHY THE DIFF DIRECTION IS ASYMMETRIC. Probe classification is not perfectly
// stable in principle: a probe that never answers is scored *reachable* (a
// missing member throws instantly, so a program still running got past the
// lookup). A loaded machine can therefore turn a real gap into an apparent
// pass — which surfaces as test 3, a bookkeeping failure. It cannot manufacture
// the opposite, because nothing about load makes a resolving member report
// "undefined". The one failure that means "you broke something" is the one that
// timing cannot fake.

//
// SCD75 ADDED ONE CASE AND ONE CORRECTION, both worth reading before trusting a
// "no gaps" result on any class.
//
// The correction: SCD75 was filed as "bridge member surface is a second
// enumeration gap, unguarded", from reading bridge sources and counting their
// declared members. This audit had always measured that surface — it diffs
// `dart:mirrors` over `BridgedClass.nativeType` against the declared map, which
// is exactly what that todo proposed building — and its verdict on both named
// examples was that they are reachable through the registered hierarchy. Neither
// was a gap. F-SCD75-1 pins that so the claim cannot be re-derived from the same
// reading, and it distinguishes the two routes a member can take (declared by
// the bridge, or inherited through the chain), because a member that swaps
// routes is invisible to every other test here:
//
//   | Injected fault                                    | Fires                |
//   | ------------------------------------------------- | -------------------- |
//   | `LinkedList -> Iterable` hierarchy edge cut       | 1 and F-SCD75-1      |
//   | `LinkedList.isNotEmpty` getter deleted            | F-SCD75-1 ALONE      |
//
// The second row is why the case is not merely documentation: deleting a
// declared getter that the chain also supplies is not a coverage regression by
// this file's other definitions — the member stays reachable — so nothing else
// notices the bridge shrinking.
//
// THE BLIND SPOT SCD75 FOUND INSTEAD, and it is a real one: every probe here
// runs against an instance the BRIDGE constructed. A script class that
// `extends` a bridged class is never probed, and that route can be broken while
// every member reads as reachable. Measured 2026-09-13: `class B extends
// StringBuffer` works, while `class E extends LinkedListEntry<E>` — the idiom
// the SDK documents for `LinkedList` — cannot be added to a `LinkedList` at all,
// because the bridge's `add` tests `is BridgedLinkedListEntry` and an
// interpreted subclass is not one. Tracked as sce120_aimm; widening the audit to
// cover the subclass route is not free, so it is named rather than assumed away.
@Timeout(Duration(minutes: 5))
library;

import 'dart:io';
import 'dart:mirrors';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/src/stdlib/io/stdio.dart';

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
/// figures (205 classes examined, 96 with a working recipe — measured
/// 2026-09-12) because their job is
/// to separate "measured" from "measured nothing", not to pin the measurement —
/// pinning is what the baseline is for, and a tight floor here would just be a
/// second baseline to update.
const _minClassesExamined = 100;
const _minClassesMeasured = 40;

/// [source] with comment bodies blanked out, string literals preserved.
///
/// SCD161. The scan below asks whether a member NAME appears in the pinning
/// file's code. A member's name also appears in the prose explaining why it is
/// unbridged — that is what the prose is for — so a raw search would accept a
/// decision that was documented and never pinned, which is the one outcome the
/// check exists to reject.
String _withoutComments(String source) {
  final out = source.split('');
  var i = 0;
  while (i < source.length) {
    final c = source[i];
    if (c == "'" || c == '"') {
      final quote = c;
      i++;
      while (i < source.length && source[i] != quote) {
        if (source[i] == r'\') i++;
        i++;
      }
      i++;
    } else if (source.startsWith('//', i)) {
      while (i < source.length && source[i] != '\n') {
        out[i] = ' ';
        i++;
      }
    } else if (source.startsWith('/*', i)) {
      while (i < source.length && !source.startsWith('*/', i)) {
        if (source[i] != '\n') out[i] = ' ';
        i++;
      }
      i += 2;
    } else {
      i++;
    }
  }
  return out.join();
}

/// A fully registered environment for the patch-library scan.
///
/// Separate from the audit's own environment so the scan cannot be affected by
/// anything `setUpAll` does to that one, and built lazily so a suite run that
/// skips these cases pays nothing.
final Environment _registryForPatchScan = buildFullyRegisteredEnvironment();

void main() {
  // The audit is ~600 interpreter probes, each in its own isolate. Measured at
  // ~7 seconds for the whole run, which is affordable once per suite and not
  // once per test — hence `setUpAll` and three tests reading one result.
  late Map<String, Map<String, _Now>> observed;
  late Set<String> observedMeasured;

  /// Bridged classes carrying unmeasured members with no stated reason.
  late Set<String> observedUnfinished;

  /// Every bridge name live in the environment, read from the registry itself
  /// rather than from `observed`. The distinction is what makes F-SCD48-1 hold
  /// on a machine where probing has gone dark: `observed` is built from the
  /// audit walk, the registry is not, so a run that measures nothing still has
  /// a full vocabulary to compare.
  late Set<String> observedRegistry;

  setUpAll(() async {
    final env = buildFullyRegisteredEnvironment();
    observedRegistry = env.bridgedClassNames.toSet();
    final diffs = collectMemberDiffs(env);
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

  test('F-SCD48-1: no bridged class has left the registry [2026-09-12]', () {
    // The registry guard, and the only test here that does not read a probe.
    //
    // WHAT WAS ALREADY COVERED, so that this is not read as a second copy of
    // it. `F-SCB24-1` (scb24_unregistered_bridge_test.dart) parses every
    // `static BridgedClass get` under lib/src/stdlib and requires its `name:`
    // to be live, so deleting a `defineBridge` call fires there. `F-SCC13-2`
    // above pins the 96 classes with a working instance recipe. Between them a
    // large part of the registry is defended.
    //
    // WHAT WAS NOT. 109 of the 205 bridged classes have no gap, no blind spot
    // and no recipe, so the four tables above say nothing about them, and two
    // changes reach them without touching a `defineBridge` line:
    //
    //   * the `name:` string changes. The declaration still exists and is
    //     still registered — under the new name — so F-SCB24-1 is satisfied
    //     while every script naming the old one breaks. MEASURED: renaming
    //     `FileLock` to `FileLockZ` left all 3543 tests passing.
    //   * the definition is deleted together with its registration. Nothing
    //     declares it, so F-SCB24-1 has no unregistered declaration to find.
    //
    // Both are the same event from a script's point of view: a name that used
    // to resolve does not. That is what this asserts, and it is why the check
    // is on NAMES rather than on definitions.
    //
    // ADDITIONS DO NOT FAIL HERE. Bridging a class is the ordinary good
    // outcome, and a guard that goes red on good news is one people learn to
    // silence by regenerating — the reflex the whole split-by-remedy structure
    // of this file exists to avoid. A new name is reported by F-SCC13-3
    // instead, with "regenerate" as the correct answer.
    final vanished = bridgedClasses.difference(observedRegistry).toList()
      ..sort();

    // The count is in the message because it separates two different
    // emergencies. One name gone is a rename or a deleted bridge: read the
    // name and put it back. A large fraction gone is a registrar that did not
    // run, and chasing the names individually would waste the diagnosis.
    final wholesale = vanished.length > bridgedClasses.length ~/ 4;
    expect(
      vanished,
      isEmpty,
      reason:
          '${vanished.length} of ${bridgedClasses.length} bridged names are no '
          'longer in the registry, so no script can name them:\n'
          '  ${vanished.join('\n  ')}\n\n'
          '${wholesale ? 'That is a large fraction of the registry, which is '
                    'not a bridge being dropped — it is a registrar that did not run, or an '
                    'environment that did not come up. Check F-SCC13-0 in this '
                    'file first; if it is red too, fix that and re-run before '
                    'reading these names.\n' : 'Check for a changed `name:` on the '
                    'BridgedClass, a deleted definition, or a `defineBridge` '
                    'call that went with it. Do NOT regenerate the baseline to '
                    'make this pass: that records the lost vocabulary as '
                    'expected.\n'}',
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
    // SCD48: a name in the registry that the baseline does not know about.
    // Reported here rather than in F-SCD48-1 because the remedy is the one this
    // test owns — a bridge was added, which is the outcome the project wants,
    // and the baseline simply has not been told.
    final newlyBridged = observedRegistry.difference(bridgedClasses).toList()
      ..sort();

    closed.sort();
    nowMeasurable.sort();

    expect(
      [...closed, ...nowMeasurable, ...newlyBridged],
      isEmpty,
      reason:
          'Good news, and the baseline has not caught up.\n'
          '${closed.isEmpty ? '' : 'No longer gaps:\n  ${closed.join('\n  ')}\n'}'
          '${nowMeasurable.isEmpty ? '' : 'No longer blind spots:\n  ${nowMeasurable.join('\n  ')}\n'}'
          '${newlyBridged.isEmpty ? '' : 'Newly bridged classes:\n  ${newlyBridged.join('\n  ')}\n'}'
          '\nRegenerate with: '
          'dart run tool/stdlib_member_diff.dart --baseline\n'
          'Commit the regenerated baseline together with the change that caused '
          'it, so the diff shows which members moved and why.',
    );
  });

  test('F-SCD163-1: every bridged class declared in a patch library resolves '
      'to a public one [2026-09-15]', () {
    // SCD163's DONE WHEN, over the real registry rather than over a table.
    //
    // A `dart:_`-prefixed library cannot be imported by any program, so an
    // import directive naming one does not resolve and the probe throws — which
    // the audit then scores UNVERIFIED with the reason "cannot derive an
    // import". That reads as a property of the CLASS and is a property of the
    // TOOL, which is the distinction this audit spends most of its design on.
    //
    // SCC57 fixed the case it hit with a one-entry table,
    // `{'dart:_http': 'dart:io'}`. Measured 2026-09-15: 30 bridged classes are
    // declared in a patch library, 28 of them `dart:_http` — and the other two,
    // `BytesBuilder` and `HttpStatus`, are `dart:_internal` and were not in the
    // table at all. The derivation covers both without anyone writing a line.
    final unresolved = <String>[];
    for (final name in _registryForPatchScan.bridgedClassNames) {
      final bridge = _registryForPatchScan.findBridgedClassByName(name);
      if (bridge == null) continue;
      final mirror = reflectType(bridge.nativeType);
      if (mirror is! ClassMirror) continue;
      final owner = mirror.owner;
      if (owner is! LibraryMirror) continue;
      final declaring = owner.uri.toString();
      if (!declaring.startsWith('dart:_')) continue;
      final typeName = MirrorSystem.getName(mirror.simpleName);
      if (sdkReexportOwners(declaring, typeName).isEmpty &&
          !sdkReexportOverrides.containsKey(declaring)) {
        unresolved.add('$name ($declaring.$typeName)');
      }
    }
    unresolved.sort();
    expect(
      unresolved,
      isEmpty,
      reason:
          'These bridged classes are declared in a library no program can '
          'import, and nothing says which public library re-exports them. The '
          'audit will emit no import for them and score whatever depends on '
          'them UNVERIFIED, with a reason that names the class rather than the '
          'tool.\n  ${unresolved.join('\n  ')}\n\n'
          'The derivation reads the SDK\'s own `export ... show` directives, so '
          'a miss here means the re-export is NOT show-limited — add the '
          'library to `sdkReexportOverrides` with the public library it belongs '
          'to, and say why the derivation could not see it.',
    );
  });

  test('F-SCE196-1: the patch-library import census covers the registry, not '
      'the candidate edges [2026-09-25]', () {
    // SCE196. The derivation used to run only inside the hierarchy audit's
    // confirmed-edge loop; measured 2026-09-25 a `--hierarchy` run had one
    // candidate edge, satisfied before any probe, so it ran ZERO times and its
    // unresolved list was empty because nothing asked. The census now runs it
    // once per bridged class declared in a `dart:_` library.
    final census = patchLibraryImportCensus(_registryForPatchScan);
    // Measured 2026-09-25: 31 (F-SCD163-1's comment recorded 30; the registry
    // grew). A floor, not an equality: the count is a property of the registry.
    expect(census.derived, greaterThanOrEqualTo(30));
    expect(census.unresolved, isEmpty);
  });

  test('F-SCE196-2: an unresolvable patch library is NAMED, with no hierarchy '
      'loop involved [2026-09-25]', () {
    // SCE196's DONE WHEN: the tool names a `dart:_` library it cannot resolve
    // on a run whose edge loop would never have reached it. The resolver is
    // replaced with one that finds nothing — the state a new SDK re-export
    // shape would put the real one in — and every patch-declared class must
    // then be named, by library and type.
    final census = patchLibraryImportCensus(
      _registryForPatchScan,
      owners: (patchUri, typeName) => const [],
    );
    expect(census.unresolved, hasLength(census.derived));
    expect(
      census.unresolved,
      containsAll(['dart:_http.HeaderValue', 'dart:_internal.BytesBuilder']),
    );
  });

  test('F-SCD163-2: the re-export derivation answers per type, not per library '
      '[2026-09-15]', () {
    // F-SCD163-1 is an emptiness assertion and would pass over a derivation
    // that returned a non-empty list for everything. These are the answers.
    expect(
      sdkReexportOwners('dart:_http', 'HeaderValue'),
      ['dart:io'],
      reason:
          'the entry SCC57 wrote by hand, now derived — if this fails the '
          'derivation has stopped working and the table is gone',
    );
    expect(
      sdkReexportOwners('dart:_internal', 'BytesBuilder'),
      ['dart:io', 'dart:typed_data'],
      reason:
          'PER TYPE, not per library: `dart:_internal` is re-exported by three '
          'public libraries and each shows a different name, so a table keyed '
          'on the library alone could not have answered this at all. Two homes '
          'here, sorted so the emitted probe is reproducible — either import '
          'resolves.',
    );
    expect(
      sdkReexportOwners('dart:_internal', 'HttpStatus'),
      ['dart:io'],
      reason: 'the second class the one-entry table missed',
    );
    expect(
      sdkReexportOwners('dart:_http', 'NotAClassInThatLibrary'),
      isEmpty,
      reason:
          'an unknown name must answer nothing rather than the library\'s '
          'other re-exporters — otherwise F-SCD163-1 passes for every class '
          'whose library happens to re-export anything',
    );
  });

  test('F-SCD162-1: no audit recipe reaches a process-global resource '
      '[2026-09-15]', () {
    // THE RULE THE STDIN INCIDENT PRODUCED, with a check behind it at last.
    //
    // A recipe is a measurement, and the audit probes a member by BARE-READING
    // it — which for an inherited `Stream` getter SUBSCRIBES. Declaring
    // `Stdin -> Stream` was correct and made `stdin.length`, `stdin.first` and
    // `stdin.last` probeable; a bare read of any of them destroys fd 0 for the
    // whole process, and `dart test` runs VM suites as isolates in ONE process.
    // 82 suites in test/stdlib then died in `IoStdioStdlib.register` with
    // "Failed to get type of stdio handle (fd 0)", none of them near the audit.
    // Five bisecting runs to connect the two.
    //
    // "A recipe must yield an object the audit owns" went into
    // `_notAuditable`'s Stdin entry and into the gap-audit doc, and stayed
    // prose — evaluated only by whoever rereads it, which is the same defect
    // `_pinnedInterpreterFloors` was built to remove one register over.
    expect(
      recipesNamingProcessGlobals(),
      isEmpty,
      reason:
          'A recipe reaches a resource the PROCESS owns rather than one the '
          'probe owns. Bare-reading an inherited member of such an object is '
          'not an observation — it consumes something every later suite in the '
          'same `dart test` process still needs, and the failure surfaces '
          'somewhere else entirely.\n\n'
          'Find another instance the probe can construct and tear down. If '
          'there genuinely is none — as for `Stdout`, which has no constructor '
          '— add the class to `processGlobalExemptions` with the reason it is '
          'safe, and "it seems to work" is not one: `Stdin` seemed to work for '
          'as long as it exposed nothing inherited.',
    );
  });

  test('F-SCD162-2: the rule reads a bare library getter, not a member access '
      '[2026-09-15]', () {
    // The check above is an emptiness assertion over a table that is empty
    // today, so it passes whether or not the rule works. This supplies the
    // inputs instead.
    //
    // WHOLE-WORD AND NOT AFTER A DOT are both load-bearing, in opposite
    // directions. Loose `contains` would flag `stdinLike`, which SCD161
    // measured the cost of on a check of this exact shape. Ignoring the leading
    // dot would flag `process.pid` and `socket.stdin` — ordinary member
    // accesses on an object the probe DOES own, which is the common case and
    // would make the rule unusable within a week.
    expect(namesProcessGlobal('stdin.first', 'stdin'), isTrue);
    expect(namesProcessGlobal('print(stdout)', 'stdout'), isTrue);
    expect(namesProcessGlobal('pid', 'pid'), isTrue);
    expect(namesProcessGlobal('Isolate.current', 'Isolate.current'), isTrue);
    expect(
      namesProcessGlobal('stdinLike', 'stdin'),
      isFalse,
      reason: 'a longer identifier that merely starts with the token',
    );
    expect(
      namesProcessGlobal('process.pid', 'pid'),
      isFalse,
      reason: 'an instance member on an object the probe owns',
    );
    expect(
      namesProcessGlobal('myIsolate.current', 'Isolate.current'),
      isFalse,
      reason: 'a member access that happens to end in the token',
    );
  });

  test('F-SCD162-3: fd 0 is still usable after the audit has run '
      '[2026-09-15]', () {
    // THE FINGERPRINT. F-SCD162-1 is a static rule and can only catch a recipe
    // whose reach is visible in its own text; this catches the consequence
    // however it arrives — a transitive read, a teardown that closes the wrong
    // handle, a future probe form nobody has thought of.
    //
    // It runs in the audit's own suite, AFTER `setUpAll` has probed all 682
    // candidates, so a recipe that destroys the descriptor fails HERE with a
    // message naming the audit — rather than in 82 later suites with a message
    // naming `IoStdioStdlib`.
    //
    // `IoStdioStdlib.register` is the exact call that failed in the incident:
    // its `environment.define('stdin', stdin)` touches the library getter, and
    // that is what throws "Failed to get type of stdio handle (fd 0)".
    expect(
      () => IoStdioStdlib.register(Environment()),
      returnsNormally,
      reason:
          'Registering `dart:io` stdio fails after the audit ran, which means '
          'a probe consumed one of the process standard descriptors. This is '
          'the SCD162 incident: the damage is done by a subscription, not by a '
          'hang, so no timeout catches it and every later suite in this '
          '`dart test` process will die in `IoStdioStdlib.register` with a '
          'message that names stdio rather than the audit.\n\n'
          'Look at what `setUpAll` probed last, and at any recipe added since '
          'the run that was green — F-SCD162-1 catches the visible cases, so a '
          'failure HERE with that one green means the reach is transitive.',
    );
  });

  test('F-SCD161-1: every declined member is pinned by a case in '
      'intentionally_unbridged_test.dart [2026-09-15]', () {
    // SCD161's DONE WHEN, made derivable. Its wording was "the baseline's
    // confirmedGaps contains only entries whose Boundary status is pinned by a
    // test" — which reads across two maps, because a Boundary lives in
    // `declinedMembers`, not in `confirmedGaps`. What it asks for is that a
    // DECISION not be recorded in a data table alone.
    //
    // The distinction matters here more than it usually does. The check above
    // asserts a declined member is still UNREACHABLE, which is the decision
    // holding; nothing asserted that the decision is VISIBLE to a script author
    // — that reaching for it produces the diagnostic the limitations doc
    // promises rather than a bare "no such member". Those are different claims
    // and only the second survives someone deleting a pinning case.
    //
    // Measured 2026-09-15: all five declined members were already pinned, by
    // F-SCB29-1..4 and F-SCC74-1. This case is what stops the sixth being
    // recorded in the table alone.
    //
    // COMMENTS ARE STRIPPED before the scan, and that is insurance rather than
    // a fix: measured 2026-09-15, all five declined members are named in CODE
    // as well as in prose, so stripping changes nothing today. It is here
    // because a limitations decision is exactly the kind of thing whose name
    // appears in the paragraph explaining it, and a scan that reads prose would
    // accept a member that was documented and never pinned — the failure SCD140
    // and SCD151 both hit, in the one direction that would make this check
    // agree with the table it exists to distrust.
    //
    // ONLY THE WHOLE-WORD MATCH BELOW IS DEMONSTRATED BY ABLATION. Renaming a
    // pinning mention fires this case; removing the stripping does not change
    // the verdict on the current corpus, and claiming otherwise would be the
    // kind of unmeasured assertion the baseline's own header warns about.
    final pinning = File('test/stdlib/intentionally_unbridged_test.dart');
    expect(
      pinning.existsSync(),
      isTrue,
      reason:
          'The file every Boundary decision is pinned in is missing, so the '
          'check below would pass over nothing.',
    );
    final code = _withoutComments(pinning.readAsStringSync());
    // WHOLE-WORD, not `contains`. Measured by ablation 2026-09-15: renaming
    // `readMessage` to `readMessageZZZ` in the pinning file left a substring
    // search satisfied, so the check accepted a member whose only mention was
    // the name of a DIFFERENT identifier. A pinning case that no longer names
    // the member is exactly what this is for.
    final unpinned = <String>[
      for (final entry in declinedMembers.entries)
        for (final member in entry.value)
          if (!RegExp('\\b${RegExp.escape(member)}\\b').hasMatch(code))
            '${entry.key}.$member',
    ]..sort();
    expect(
      unpinned,
      isEmpty,
      reason:
          'These members are recorded in `declinedMembers` as deliberately '
          'unbridged, and no case in intentionally_unbridged_test.dart names '
          'them. A decision that lives only in a data table is a decision '
          'nothing re-checks: the member could start resolving, or start '
          'failing with a different diagnostic than the limitations doc '
          'promises, and the table would go on saying the same thing.\n'
          '  ${unpinned.join('\n  ')}\n\n'
          'Add a case asserting what a script actually sees when it reaches '
          'for the member, in the shape F-SCC74-1 uses.',
    );
  });

  test('F-SCD75-1: a short declared-member list is not a coverage gap — the '
      'fallback is what closes it [2026-09-13]', () {
    // SCD75 was filed as "bridge member surface is a second enumeration gap,
    // unguarded", naming members measured by hand: the `LinkedList` bridge
    // "declares exactly two instance getters, `length` and `isEmpty`", and the
    // `StreamController` bridge contains no `done` at all. The reading of the
    // source was right about `done` — `grep -c "'done'"` on
    // `stream_controller.dart` is still 0 — and wrong about `isNotEmpty`, which
    // the `LinkedList` bridge has declared all along. Every conclusion drawn
    // from either was wrong, and this case exists so the claim cannot be filed
    // a third time from the same reading.
    //
    // A bridge's declared members are not its reachable surface. What a script
    // can touch is decided at run time by the registered hierarchy walk, so an
    // undeclared member resolves through a supertype's bridge. Measured
    // 2026-09-13 through the interpreter: `iterator`, `first`, `last`,
    // `isNotEmpty`, `for`-`in` and `map` all work on a `LinkedList`, and
    // `controller.done` completes when the controller closes.
    //
    // So each member reaches a script by one of TWO routes, and this case
    // records which — a member that swapped routes would otherwise look
    // identical from the outside:
    //
    //   * DECLARED by the bridge itself. Never enters this audit's diff at all,
    //     because the diff is the SDK surface MINUS the declared map.
    //   * UNDECLARED, reachable through the hierarchy. Enters the diff and is
    //     classified by RUNNING a script, not by reading the map — which is the
    //     other half of the correction: this audit has always seen these
    //     members correctly, so the surface was never unguarded.
    const declared = <String, List<String>>{
      'LinkedList': ['length', 'isEmpty', 'isNotEmpty'],
    };
    const viaHierarchy = <String, List<String>>{
      'LinkedList': ['iterator', 'first', 'last'],
      'StreamController': ['done'],
    };

    // Anti-vacuity first: if the diff for these classes were empty — a narrowed
    // run, a mirror walk that stopped early — every per-member expectation
    // below would pass by absence.
    for (final cls in {...declared.keys, ...viaHierarchy.keys}) {
      expect(
        observed[cls],
        isNotNull,
        reason:
            '$cls is not in the audit at all, so nothing below is a '
            'measurement of it',
      );
    }
    expect(
      observed['LinkedList']!.length,
      greaterThanOrEqualTo(20),
      reason:
          'the SDK surface walk should find ~28 members this bridge does not '
          'declare; a handful would mean the walk stopped early, and then '
          '"no gaps" says nothing',
    );

    final wrong = <String>[];
    declared.forEach((cls, members) {
      for (final member in members) {
        final now = observed[cls]![member];
        if (now != null) {
          wrong.add(
            '$cls.$member is declared by the bridge, so it should not be in '
            'the diff at all — got $now',
          );
        }
      }
    });
    viaHierarchy.forEach((cls, members) {
      for (final member in members) {
        final now = observed[cls]![member];
        if (now != _Now.reachable) {
          wrong.add(
            '$cls.$member should be undeclared and reachable through the '
            'hierarchy — got ${now ?? 'declared by the bridge now'}',
          );
        }
      }
    });

    expect(
      wrong,
      isEmpty,
      reason:
          'These are the members SCD75 reported as unreachable, with the route '
          'each actually takes. A change that breaks the hierarchy fallback '
          'shows up here with a name instead of as an unexplained baseline '
          'diff; a member that moves from one route to the other shows up as '
          'well, which is information rather than breakage — move it and say '
          'why.\n'
          '${wrong.join('\n')}',
    );
  });
}
