// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter) — asserts a property of the INTERPRETER's
// name resolution (`Environment.findAllBridgedClassesByName`) across this
// package's entire bridge registry. It lives here for the same reason SCD133
// does: this is where a registry large enough to collide exists. SCC76 asks
// the same question of the stdlib's 205 names; this asks it of 2 426.
//
// So it runs only when tom_d4rt_flutter's suite runs, and a session working
// elsewhere in the repo reaches none of it. SCD129 made that arrangement
// visible rather than incidental: `grep -rn 'REPO-WIDE GUARD' */test` lists
// every one, and `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails
// if a new one arrives without this banner.
//
// SCD195 — the collision check, one layer above the stdlib.
//
// SCC76 registers the eight `dart:` stdlib registrars into one environment and
// asserts each name resolves to exactly one bridge. Green at 205 names, and
// silent about the layer where cross-PACKAGE collision actually happens.
// `environment.dart`'s own comment names that shape: "two distinct bridges
// register under the same simple name (e.g. `tom_doc_scanner` and
// `tom_md2latex` both export a `MarkdownParser`)". The generated Flutter
// bridges are it — 18 `*.b.dart` files covering material, widgets, rendering,
// painting, gestures, animation, foundation, cupertino, dart:ui and
// vector_math, all re-exporting each other, with a
// `PerPackageBridgeOrchestrator` in the generator that exists to deduplicate
// the overlap. A dedup step is an admission that the input collides.
//
// SCD195 EXPECTED THIS TO LAND RED. It does not, and the measurement is why
// the file asserts what it asserts rather than copying SCC76 (figures from the
// AST twin, 2026-09-15; this twin's registry is the same shape):
//
//     class names in the live registry          2 426
//     names with more than one candidate        1 659
//     ... every candidate the same nativeType   1 659   <- re-exports
//     ... two DIFFERENT nativeTypes                 0   <- the defect
//
// So a straight copy of SCC76's `_collisions` would report 1 659 findings and
// be discarded within a week. The distinction SCD195 predicted would be needed
// IS needed, and it is the whole content of this guard: `defineBridgeLazy`
// already treats same-`nativeType` candidates as a re-export and different ones
// as Dart's ambiguous-import case, so the guard asks the same question the
// registry does.
//
// F-SCD195-2 IS NOT DECORATION. Both other cases are emptiness assertions over
// a walk, and a walk that found nothing satisfies them. Worse here than usual:
// the re-export count is 1 659, so a registry that half-loaded could plausibly
// show a small non-zero number and still look alive. The floors are set against
// the measured figures, well below them.
//
// THE ENUM AXIS IS PUBLISH-BLOCKED, and that is recorded rather than skipped.
// SCD194 added `findAllBridgedEnumsByName`, which is what can see an enum
// displaced WITHIN a frame; this package resolves `tom_d4rt` from pub.dev
// (DGUC6), and the published copy predates it. So F-SCD195-3 asks the question
// the published API can answer — no name in both namespaces — and the sharper
// one waits for the release. Counting enum names per frame instead would look
// like the same check and silently miss the only case worth catching.
//
// EACH CASE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                        | Fires |
//   | ----------------------------------------------------- | ----- |
//   | a second bridge for a different native type, one name  | 1     |
//   | the registry replaced with a bare Environment          | 2     |
//   | a bridged class registered under an existing enum name | 3     |

library;

import 'package:flutter_test/flutter_test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

/// A script importing what essentially every corpus script imports, so the
/// environment under test is one a real build produces.
const String _probeScript = '''
import 'package:flutter/material.dart';

int main() => 1;
''';

/// Floors, not equalities — the counts move with every Flutter SDK bump and
/// every regeneration. Measured 2026-09-15: 2 426 class names, 1 659 of them
/// re-exported under more than one barrel, 213 bridged enums.
const int _minClassNames = 1500;
const int _minReExports = 800;
const int _minEnumNames = 120;

/// Every bridged class name reachable from [env], across the scope chain.
///
/// `bridgedClassNames` reports ONE frame. The generated bridges land in the
/// warm parent and the script runs in a child, so a single-frame read sees a
/// fraction of the registry — which for an emptiness assertion is a pass.
Set<String> _classNames(Environment env) {
  final names = <String>{};
  for (Environment? frame = env; frame != null; frame = frame.enclosing) {
    names.addAll(frame.bridgedClassNames);
  }
  return names;
}

Set<String> _enumNames(Environment env) {
  final names = <String>{};
  for (Environment? frame = env; frame != null; frame = frame.enclosing) {
    names.addAll(frame.bridgedEnumNames);
  }
  return names;
}

/// `name -> the distinct native types registered under it`, for every name with
/// more than one.
///
/// A single entry means a re-export: the same class reached through two
/// barrels, which `defineBridgeLazy` deduplicates on purpose. Two or more is
/// the defect — the last registration wins and the other class's members are
/// unreachable under that name, which is SCB26's shape.
Map<String, List<String>> _candidateTypes(Environment env) {
  final out = <String, List<String>>{};
  for (final name in _classNames(env)) {
    final candidates = env.findAllBridgedClassesByName(name);
    if (candidates.length <= 1) continue;
    out[name] = (candidates.map((b) => b.nativeType.toString()).toSet().toList()
      ..sort());
  }
  return out;
}

/// Builds the real environment, taken from the visitor AFTER the probe script
/// has run — the same object a build resolves names against.
///
/// Exactly one [FlutterD4rt] is constructed, and that matters: bridge
/// registration is pooled per process, so a second instance registers nothing
/// and reports an empty registry.
Environment _liveRegistry() {
  final d4rt = SourceFlutterD4rt();
  d4rt.execute<int>(_probeScript, name: 'main');
  return d4rt.interpreter.visitor!.globalEnvironment;
}

void main() {
  late Environment env;
  late Map<String, List<String>> candidates;

  setUpAll(() {
    env = _liveRegistry();
    candidates = _candidateTypes(env);
  });

  group('SCD195: bridged-name collisions in the generated registry', () {
    test('F-SCD195-2 (control): the registry loaded, and re-exports exist '
        '[2026-09-15] (PASS)', () {
      // Ordered first in intent. Both assertions below are emptinesses over
      // this walk, and the second half of this case is the unusual one: the
      // guard's whole content is telling a re-export from a collision, so a
      // registry with NO re-exports would satisfy F-SCD195-1 while proving the
      // distinction was never exercised.
      expect(
        _classNames(env).length,
        greaterThanOrEqualTo(_minClassNames),
        reason:
            'Only ${_classNames(env).length} bridged class names are '
            'reachable. That is not a finding about collisions — the registry '
            'did not load, or the scope chain is not being walked.',
      );
      expect(
        candidates.length,
        greaterThanOrEqualTo(_minReExports),
        reason:
            'Only ${candidates.length} names have more than one candidate. '
            'The generated bridges re-export each other heavily (1 659 such '
            'names on 2026-09-15), so a number near zero means '
            'findAllBridgedClassesByName is not seeing the shadowed entries '
            'and F-SCD195-1 is passing over nothing.',
      );
    });

    test('F-SCD195-1: no bridged name covers two different native classes '
        '[2026-09-15] (PASS)', () {
      final real = <String>[
        for (final entry in (candidates.keys.toList()..sort()))
          if (candidates[entry]!.length > 1)
            '  $entry -> ${candidates[entry]!.join(' | ')}',
      ];

      expect(
        real,
        isEmpty,
        reason:
            'These bridged names resolve to more than one NATIVE CLASS:\n'
            '${real.join('\n')}\n\n'
            'The last registration wins, so every member the loser declared '
            'and the winner does not is unreachable under that name — SCB26, '
            'where `StringSink` lost three members for its whole lifetime.\n\n'
            'Candidates that all share one nativeType are NOT reported: that '
            'is one class reached through several barrels, which '
            '`defineBridgeLazy` deduplicates on purpose and which describes '
            '1 659 of the names here.\n\n'
            'Fix the GENERATOR, not the `.b.dart` — and consider whether '
            '`PerPackageBridgeOrchestrator` should refuse the name at build '
            'time, since it already holds the whole-corpus view.',
      );
    });

    test('F-SCD195-3: no name is both a bridged class and a bridged enum '
        '[2026-09-15] (PASS)', () {
      // The cross-namespace case `defineBridgedEnum` warns about and then
      // registers anyway, so which one a bare name reaches depends on lookup
      // order rather than on any rule. Neither registry can see it alone.
      //
      // The SHARPER enum question — two definitions competing for one enum name
      // — needs `findAllBridgedEnumsByName`, which SCD194 added to the
      // interpreter and no release carries yet (DGUC6). Counting enum names per
      // frame would look like that check and miss every within-frame
      // displacement, which is the only case worth catching, so it is left to
      // the publish rather than approximated.
      final enums = _enumNames(env);
      expect(
        enums.length,
        greaterThanOrEqualTo(_minEnumNames),
        reason:
            'Only ${enums.length} bridged enums are reachable, so the '
            'intersection below is over an empty set.',
      );

      final both = (enums.intersection(_classNames(env)).toList()..sort());
      expect(
        both,
        isEmpty,
        reason:
            'These names are registered in BOTH namespaces: '
            '${both.join(', ')}.\n'
            'Which one a bare name reaches depends on lookup order. Register '
            'the enum as a BridgedClass, or rename one of them.',
      );
    });
  });
}
