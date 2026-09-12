@Timeout(Duration(minutes: 5))
library;

import 'package:test/test.dart';

import '../../tool/stdlib_member_diff.dart';
import 'hierarchy_baseline.dart';

/// SCD47 — the supertype-edge half of the gap audit, guarded on every run.
///
/// The member half has failed on drift since SCC13. This half did not, and the
/// asymmetry was the wrong way round: **a missing edge is the more expensive
/// defect**. It costs the whole inherited surface at once rather than one
/// member, it makes `is` and `on` answer wrongly, and `LinkedList` went from 27
/// unreachable members to 2 when one edge was declared.
///
/// The member baseline does catch a DELETED edge — the members it stops
/// carrying turn up as F-SCC13-1 regressions — but it reports one deleted line
/// as N unrelated member failures. The reader gets ten stream combinators and
/// has to infer the cause. This file names the edge.
///
/// ## Why four tests and not one
///
/// Inherited unchanged from SCC13's reasoning, because it applies verbatim: a
/// single assertion cannot tell a regression from an improvement, so it trains
/// whoever meets it to regenerate without reading. Each test here has exactly
/// one remedy:
///
/// | Test | Means | Remedy |
/// | --- | --- | --- |
/// | `F-SCD47-1` | the audit measured almost nothing | fix the environment; trust no other result |
/// | `F-SCD47-2` | an edge that held does not any more | fix the registration |
/// | `F-SCD47-3` | a recipe stopped producing an instance, or a class vanished | fix the recipe, or record a reason |
/// | `F-SCD47-4` | the baseline no longer describes reality | regenerate it |
///
/// ## The control matrix
///
/// A guard nobody has watched fail is a guess about a guard. Each row below was
/// produced by breaking the thing named and reading which cases went red — not
/// predicted:
///
/// | Injected fault | Fires |
/// | --- | --- |
/// | every probe unable to answer (1 µs timeout) | 1, 3 **and 4** |
/// | `HttpClientResponse -> Stream` deleted from `io_hierarchy.dart` | 2 |
/// | `SplayTreeSet -> Set` deleted from `collection_hierarchy.dart` | **nothing** |
/// | a baselined class's instance recipe broken | 3 |
/// | the one `_declinedEdges` entry un-declined | 4 |
///
/// Two rows are worth more than the others.
///
/// **Not every declared edge is load-bearing.** Deleting `SplayTreeSet -> Set`
/// changes nothing this audit can see: the cross-reference does not even raise
/// it as a candidate, so no case fires and none should. A control has to pick an
/// edge whose absence the instrument can actually observe, and the first one I
/// picked was not — which is the whole reason this matrix records the fault
/// that produced each row rather than a generic description of it.
///
/// **The timeout fault fires 4 as well as 1 and 3**, because a probe that
/// cannot answer also stops the declined edge from being classified as
/// declined, so the baseline's `declinedEdges` entry reads as reversed. That is
/// correct behaviour and worth knowing: under a broken environment, expect
/// noise from 4 as well, and read 1 first — it is the case that says the other
/// three are meaningless.
///
/// ## Pinning the unmeasurable set is load-bearing
///
/// Without `unmeasurableEdges`, `unverified -> confirmed` is indistinguishable
/// from `reachable -> confirmed`, so adding an instance recipe would read as a
/// wave of fresh regressions rather than as new information. That is what SCC57
/// would have looked like on the member side before SCC13 pinned the same
/// thing. It is currently empty — every edge is measurable — and an empty set
/// is worth pinning precisely because a broken recipe is what refills it.
void main() {
  /// Floors a regenerated baseline cannot lower, because they live here.
  const minClassesExamined = 100;
  const minClassesMeasured = 40;

  late final List<HierarchyGap> gaps;
  late final Map<String, HierarchyGap> byName;
  late final Set<String> observedMeasured;

  setUpAll(() async {
    final env = buildFullyRegisteredEnvironment();
    gaps = auditHierarchy(env);
    await verifyAllEdges(gaps, env);
    applyDeclinedEdges(gaps);
    byName = {for (final g in gaps) g.name: g};
    observedMeasured = {
      for (final g in gaps)
        if (g.recipeUsable) g.name,
    };
  });

  test('F-SCD47-1: the audit measured something [2026-09-12]', () {
    // Runs first because the other three only mean anything if this holds: they
    // all compare against a measurement, and an empty measurement agrees with
    // any baseline. Every probe runs in a spawned isolate; if spawning fails,
    // every edge reports "no answer" and the audit finds no missing edges.
    expect(
      gaps.length,
      greaterThanOrEqualTo(minClassesExamined),
      reason:
          'The audit examined only ${gaps.length} bridged classes. That is not '
          'a coverage finding — the environment did not come up.',
    );
    expect(
      observedMeasured.length,
      greaterThanOrEqualTo(minClassesMeasured),
      reason:
          'Only ${observedMeasured.length} classes yielded an instance, so '
          'almost no edge was probed. Check that a plain `dart run '
          'tool/stdlib_member_diff.dart --hierarchy` works before trusting any '
          'other result in this file.',
    );
  });

  test('F-SCD47-2: no edge that held is missing now [2026-09-12]', () {
    // The regression guard, and the reason this file exists. A confirmed
    // missing edge that the baseline does not already know about is a
    // registration that was deleted or never written — and it takes the whole
    // inherited surface with it.
    final regressions = <String>[];
    for (final g in gaps) {
      for (final edge in g.missingEdges) {
        final known =
            (confirmedEdges[g.name]?.contains(edge) ?? false) ||
            (declinedEdges[g.name]?.contains(edge) ?? false) ||
            (unmeasurableEdges[g.name]?.contains(edge) ?? false);
        if (!known) regressions.add('${g.name} -> $edge');
      }
    }
    regressions.sort();
    expect(
      regressions,
      isEmpty,
      reason:
          'These supertype edges do not hold and did before:\n'
          '  ${regressions.join('\n  ')}\n\n'
          'Each one costs every member the class inherits through it, and makes '
          '`is` and `on` answer wrongly for the type. Do not regenerate the '
          'baseline to make this pass — that records the breakage as expected. '
          'Declare the edge in the owning stdlib registrar.',
    );
  });

  test('F-SCD47-3: every class the baseline was measured with still yields an '
      'instance [2026-09-12]', () {
    // Without this the guard can go dark and still report success: a broken
    // recipe turns every one of its class's edges UNVERIFIED, and test 2
    // tolerates confirmed -> unmeasurable by design, because an edge nobody
    // could measure must not be asserted about. So the tolerance needs a floor.
    final wentDark = measuredEdgeClasses.difference(observedMeasured).toList()
      ..sort();

    // A class the baseline has an opinion about that the registry no longer
    // contains. Every edge of it is gone, which is the largest regression this
    // file can meet — and it would slip past test 2, which walks what WAS
    // measured and finds nothing to walk for a class that is absent.
    final vanished = <String>{
      ...confirmedEdges.keys,
      ...declinedEdges.keys,
      ...unmeasurableEdges.keys,
    }.where((c) => !byName.containsKey(c)).toList()..sort();

    expect(
      [...wentDark, ...vanished],
      isEmpty,
      reason:
          '${vanished.isEmpty ? '' : 'These classes are no longer bridged at '
                    'all:\n  ${vanished.join('\n  ')}\n'
                    'A bridge that disappeared is a much larger regression than a '
                    'missing edge.\n\n'}'
          '${wentDark.isEmpty ? '' : 'The instance recipe for these classes no '
                    'longer yields an instance, so their edges are not being '
                    'measured:\n  ${wentDark.join('\n  ')}\n'
                    'Either the recipe broke (fix it in _instanceRecipes) or this '
                    'platform cannot run it — and if it is the platform, record that '
                    'as a reason in _notAuditable rather than shrinking the '
                    'baseline, so the blind spot stays visible.'}',
    );
  });

  test('F-SCD47-4: the baseline still describes reality [2026-09-12]', () {
    // The bookkeeping test, and the only one "just regenerate it" answers. It
    // can be provoked only by improvements: an edge that was declared, or a
    // blind spot that became measurable. Kept separate from test 2 so that the
    // safe response to one is never the response to the other.
    final closed = <String>[];
    for (final entry in confirmedEdges.entries) {
      final g = byName[entry.key];
      if (g == null) continue; // test 3 owns a vanished class
      for (final edge in entry.value) {
        if (g.missingEdges.contains(edge)) continue; // still missing
        if (g.unverifiedEdges.contains(edge)) continue; // test 3 owns this
        closed.add('${entry.key} -> $edge');
      }
    }

    // A declined edge that now holds is a DECISION being reversed, not a gap
    // closing, and the remedy differs: drop the row from `_declinedEdges` in
    // the same change rather than quietly regenerating around it.
    final reversedDecisions = <String>[];
    for (final entry in declinedEdges.entries) {
      final g = byName[entry.key];
      if (g == null) continue;
      for (final edge in entry.value) {
        if (!g.declinedEdges.contains(edge)) {
          reversedDecisions.add('${entry.key} -> $edge');
        }
      }
    }
    reversedDecisions.sort();
    expect(
      reversedDecisions,
      isEmpty,
      reason:
          'These edges are recorded as deliberately absent and are not absent '
          'any more:\n  ${reversedDecisions.join('\n  ')}\n\n'
          'That is a decision being reversed. If it was intended, remove the '
          'entry from `_declinedEdges` in the same change.',
    );

    final nowMeasurable = <String>[];
    for (final entry in unmeasurableEdges.entries) {
      final g = byName[entry.key];
      if (g == null) continue;
      for (final edge in entry.value) {
        if (g.unverifiedEdges.contains(edge)) continue; // still blind
        nowMeasurable.add(
          '${entry.key} -> $edge '
          '(${g.missingEdges.contains(edge) ? 'measurable, and missing' : 'measurable, and holds'})',
        );
      }
    }
    closed.sort();
    nowMeasurable.sort();
    expect(
      [...closed, ...nowMeasurable],
      isEmpty,
      reason:
          'Good news, and the baseline has not caught up.\n'
          '${closed.isEmpty ? '' : 'No longer missing:\n  ${closed.join('\n  ')}\n'}'
          '${nowMeasurable.isEmpty ? '' : 'No longer blind spots:\n  ${nowMeasurable.join('\n  ')}\n'}'
          '\nRegenerate with: '
          'dart run tool/stdlib_member_diff.dart --hierarchy --baseline\n'
          'Commit the regenerated baseline together with the change that caused '
          'it, so the diff shows which edges moved and why.',
    );
  });
}
