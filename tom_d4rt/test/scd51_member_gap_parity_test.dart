// SCD51 — the two trees' unreachable-member sets agree, and the method that
// says so is itself checked.
//
// `tom_d4rt_ast` now has a member-coverage audit of its own
// (`tool/stdlib_member_audit.dart`). SCD51 said the interesting output is not
// either baseline but the DIFF between them: two registries maintained in
// lock-step by hand should have the same unreachable set, and every member
// unreachable on one side only is a mirroring miss. This is that comparison.
//
// IT CANNOT BE A NAIVE SET DIFF, because the two sides are measured by
// different methods. This tree decides reachability EMPIRICALLY — it runs a
// script per candidate through the interpreter. The twin cannot execute source
// (it interprets pre-parsed `SAstNode` trees, and the parser depends back on
// it), so it SIMULATES the interpreter's `lookupOnBridgedSupertypes` by walking
// the registered supertype chain. A raw mismatch between the two would then be
// ambiguous: a mirroring miss, or an artefact of the second method.
//
// So the comparison is decomposed, and the first half is the load-bearing one:
//
//   F-SCD51-5  the chain walk reproduces THIS tree's empirical verdict
//   F-SCD51-6  the twin's chain walk agrees with this tree's
//
// F-SCD51-5 is the calibration that licensed the twin's design, made standing
// instead of left as a one-off measurement. It runs the simulation against the
// reference registry and compares it to `member_coverage_baseline.dart`, which
// is the empirical answer. While it holds, a disagreement in F-SCD51-6 is a
// fact about the registries rather than about the method — which is the whole
// reason the twin's numbers can be believed.
//
// SCOPE: ordinary named members. Measured 2026-09-12, the chain walk agreed
// with the probe on all 644 of them and disagreed on all 63 operators and
// `Object` universals (`+`, `<`, `[]`, `==`, `toString`, ...), which the
// interpreter reaches through paths the registry does not model. Those are
// excluded here and remain covered by `member_coverage_baseline_test.dart`,
// which measures them for real. The exclusion is a measurement, not a taste.
//
// NOTE ON DIRECTION. This tree's baseline splits its unreachable members into
// `confirmedGaps` (work not yet done) and `declinedMembers` (a boundary that
// was chosen). The twin's audit cannot make that distinction — it is about
// intent, not reachability — so the union is what corresponds to its
// `unreachableMembers`.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                           | Fires   |
//   | -------------------------------------------------------- | ------- |
//   | the twin's baseline pointed at a path that is absent      | 6       |
//   | a member cut from the twin's baseline by hand             | 6       |
//   | `Duration.inDays` deleted from THIS tree's bridge         | 5 and 6 |
//   | the universal-member exclusion removed                    | nothing |
//
// The third row fires both, correctly: deleting an adapter here makes this tree
// disagree with its own empirical baseline AND with the twin, and both are
// true. Read F-SCD51-5 first — while it is red, F-SCD51-6 is not a statement
// about the registries.
//
// The last row is why the scope restriction is structural rather than a filter.
// An `_isOrdinary` predicate was written, and injecting its removal changed
// nothing: `diffClass` had already routed operators and universals into buckets
// this file does not read, so the filter was dead code. It is gone. A guard
// that cannot fire reads as protection and is not.

@Timeout(Duration(minutes: 5))
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

import '../tool/stdlib_member_diff.dart';
import 'stdlib/member_coverage_baseline.dart';

/// The twin's generated baseline, a sibling checkout in the same repository.
const _twinBaseline = '../tom_d4rt_ast/test/stdlib_member_baseline.dart';

/// Reads `const unreachableMembers = {...}` out of the twin's generated
/// baseline.
///
/// Parsed rather than regex-matched: the file is generated Dart, and a reader
/// that guessed at its shape would silently return an empty map if the emitter
/// changed — which every assertion below would then agree with.
Map<String, Set<String>>? _readTwinBaseline() {
  final file = File(_twinBaseline);
  if (!file.existsSync()) return null;
  final unit = parseString(
    content: file.readAsStringSync(),
    featureSet: FeatureSet.latestLanguageVersion(),
    throwIfDiagnostics: false,
  ).unit;

  for (final declaration in unit.declarations) {
    if (declaration is! TopLevelVariableDeclaration) continue;
    for (final variable in declaration.variables.variables) {
      if (variable.name.lexeme != 'unreachableMembers') continue;
      final literal = variable.initializer;
      if (literal is! SetOrMapLiteral) return null;
      final out = <String, Set<String>>{};
      for (final element in literal.elements) {
        if (element is! MapLiteralEntry) continue;
        final key = element.key;
        final value = element.value;
        if (key is! StringLiteral || value is! ListLiteral) continue;
        final name = key.stringValue;
        if (name == null) continue;
        out[name] = {
          for (final item in value.elements)
            if (item is StringLiteral && item.stringValue != null)
              item.stringValue!,
        };
      }
      return out;
    }
  }
  return null;
}

void main() {
  late Map<String, Set<String>> chainWalk;
  late Map<String, Set<String>>? twin;

  setUpAll(() {
    // Candidate generation is the tool's, so this cannot drift from what the
    // empirical audit calls a candidate — the two would then disagree about
    // the question rather than about the answer.
    final env = buildFullyRegisteredEnvironment();
    final diffs = collectMemberDiffs(env);
    // `verifyAll` is deliberately NOT run. It only MOVES candidates between
    // the tool's buckets — a member it proves reachable leaves `missingInstance`
    // for `reachableViaFallback` — so the union below is the same set either
    // way, and skipping it keeps this file off the probe path entirely. That
    // matters: probes are timing-sensitive by construction (one that never
    // answers is scored reachable), and a calibration inheriting that
    // sensitivity would fail on a loaded machine for a reason unrelated to
    // either registry.

    bool chainDeclares(String cls, String member) {
      for (final n in [cls, ...BridgedClass.transitiveSupertypeNames(cls)]) {
        final bc = env.findBridgedClassByName(n);
        if (bc == null) continue;
        if (bc.methods.containsKey(member) ||
            bc.getters.containsKey(member) ||
            bc.setters.containsKey(member) ||
            bc.staticMethods.containsKey(member) ||
            bc.staticGetters.containsKey(member) ||
            bc.staticSetters.containsKey(member)) {
          return true;
        }
      }
      return false;
    }

    chainWalk = {};
    for (final d in diffs) {
      // `missingInstance` and `missingStatic` ARE the ordinary named members:
      // `diffClass` routes operators into `missingOperators` and the `Object`
      // universals into `missingUniversal` when it generates candidates, and
      // neither bucket is read here. The scope restriction is therefore
      // structural rather than a filter — an explicit filter was tried and
      // measured to be dead code, which is worse than none because it reads as
      // protection.
      final candidates = <String>{...d.missingInstance, ...d.missingStatic};
      final unreachable = {
        for (final m in candidates)
          if (!chainDeclares(d.name, m)) m,
      };
      if (unreachable.isNotEmpty) chainWalk[d.name] = unreachable;
    }

    twin = _readTwinBaseline();
  });

  /// This tree's empirical verdict: a member is unreachable whether the reason
  /// is an open gap or a chosen boundary.
  Map<String, Set<String>> empirical() {
    final out = <String, Set<String>>{};
    for (final source in [confirmedGaps, declinedMembers]) {
      for (final entry in source.entries) {
        out.putIfAbsent(entry.key, () => <String>{}).addAll(entry.value);
      }
    }
    return out;
  }

  /// `Class.member` lines, sorted, for a legible diff in a failure message.
  List<String> flatten(Map<String, Set<String>> m) => [
    for (final entry in m.entries)
      for (final member in entry.value) '${entry.key}.$member',
  ]..sort();

  test('F-SCD51-5: the chain walk reproduces this tree\'s empirical verdict '
      '[2026-09-12]', () {
    // The calibration, standing. The twin decides reachability by simulating
    // the interpreter's supertype lookup because it cannot run one; this is
    // what says the simulation is faithful. If it goes red, F-SCD51-6's verdict
    // is not about the registries any more and must not be read as one.
    final walked = flatten(chainWalk).toSet();
    final measured = flatten(empirical()).toSet();

    final walkSaysUnreachable = (walked.difference(measured).toList())..sort();
    final probeSaysUnreachable = (measured.difference(walked).toList())..sort();

    expect(
      [...walkSaysUnreachable, ...probeSaysUnreachable],
      isEmpty,
      reason:
          'The supertype-chain simulation and the interpreter disagree.\n'
          '${walkSaysUnreachable.isEmpty ? '' : 'Walk says unreachable, the '
                    'probe reached them:\n  '
                    '${walkSaysUnreachable.join('\n  ')}\n'}'
          '${probeSaysUnreachable.isEmpty ? '' : 'Probe says unreachable, the '
                    'walk resolved them:\n  '
                    '${probeSaysUnreachable.join('\n  ')}\n'}\n'
          'The second direction is the dangerous one: it means the walk calls '
          'a member reachable that no script can call, so the twin\'s audit is '
          'under-reporting. Either a resolution path was added that the '
          'registry does not model — in which case the walk needs to learn it, '
          'and tom_d4rt_ast/tool/stdlib_member_audit.dart is where — or the '
          'member kind belongs in the excluded set beside operators, with the '
          'measurement that says so.',
    );
  });

  test('F-SCD51-6: the two trees have the same unreachable members '
      '[2026-09-12]', () {
    // The mirroring guard. The two stdlibs are kept in step by hand under the
    // "keep tom_d4rt <-> tom_d4rt_ast in sync" rule, and a member unreachable
    // on one side only is a miss that rule did not catch.
    expect(
      twin,
      isNotNull,
      reason:
          'Could not read `unreachableMembers` from $_twinBaseline. The twin '
          'is a sibling checkout in the same repository; if it is absent or '
          'its baseline has not been generated, this comparison cannot be '
          'made, and reporting that as a pass would be worse than failing. '
          'Generate it with: '
          'cd ../tom_d4rt_ast && dart run tool/stdlib_member_audit.dart '
          '--baseline',
    );

    final here = flatten(chainWalk).toSet();
    final there = flatten(twin!).toSet();

    final onlyHere = (here.difference(there).toList())..sort();
    final onlyThere = (there.difference(here).toList())..sort();

    expect(
      [...onlyHere, ...onlyThere],
      isEmpty,
      reason:
          'The two stdlib registries expose different members.\n'
          '${onlyHere.isEmpty ? '' : 'Unreachable in tom_d4rt only — so the '
                    'twin bridges something this tree does not:\n  '
                    '${onlyHere.join('\n  ')}\n'}'
          '${onlyThere.isEmpty ? '' : 'Unreachable in tom_d4rt_ast only — so '
                    'THIS tree bridges something the shipping tree does '
                    'not:\n  ${onlyThere.join('\n  ')}\n'}\n'
          'The second list is the one that matters most: tom_d4rt_ast is what '
          'runs inside Flutter apps, so a member missing only there is missing '
          'where it counts. Port the adapter, then regenerate the twin\'s '
          'baseline in the same change.',
    );
  });
}
