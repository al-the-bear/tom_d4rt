import 'dart:io';

import 'package:test/test.dart';

/// SCC87 — which `D4` helpers the hand-written stdlib may use.
///
/// There are two ways to read a positional argument out of a bridge adapter and
/// they throw different exception types. That is a deliberate split, not an
/// oversight, and this file is what keeps it deliberate.
///
///   * [D4.getRequiredArg] / [D4.getOptionalArg] throw `ArgumentD4rtException`
///     and are the GENERATED-code entry points — `tom_d4rt_generator` emits
///     them. Generated bridges and their tests depend on that type, which is a
///     wide blast radius for a cosmetic win, so SCC87 chose not to change it.
///   * [D4.checkArity] throws `RuntimeD4rtException`, matching what the stdlib
///     dispatch path already produced and what `describeArityError` emits, so a
///     hand-written bridge reports an arity failure the same way whether the
///     guard is explicit or generic.
///
/// The cost of leaving that undocumented was that a new bridge had no one
/// obvious way to read an argument, so the inconsistency kept reproducing. Both
/// definitions now say which side they belong to; this pins it, because a doc
/// comment nobody opens is not a boundary.
///
/// WHAT THIS DOES NOT CLAIM. The stdlib uses plenty of `D4` — measured
/// 2026-09-07, 554 call sites across 60 files per tree, almost all of them
/// SCC85's `checkArity`. `D4` is not off-limits here; the argument-READING pair
/// specifically is.
void main() {
  final stdlibDir = Directory('lib/src/runtime/stdlib');

  /// Every `.dart` under the stdlib, as (path, source).
  List<MapEntry<String, String>> stdlibSources() {
    expect(
      stdlibDir.existsSync(),
      isTrue,
      reason:
          'lib/src/runtime/stdlib is missing, so this guard would pass by checking '
          'nothing. Run from the package root.',
    );
    return stdlibDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .map((f) => MapEntry(f.path, f.readAsStringSync()))
        .toList();
  }

  group('SCC87: the D4 argument-reading boundary', () {
    test('F-SCC87-AST-1: the guard is looking at a real corpus [2026-09-07]', () {
      // Without this, every assertion below passes on an empty list — the
      // failure mode where a guard reports success because it found nothing.
      final sources = stdlibSources();
      expect(sources.length, greaterThan(100));
      expect(
        sources.where((e) => e.value.contains('D4.')).length,
        greaterThan(50),
        reason:
            'The stdlib should be full of D4 calls (checkArity alone is in 526 '
            'adapters). Finding almost none means this is reading the wrong '
            'tree, and the boundary check below would be vacuous.',
      );
    });

    test('F-SCC87-AST-2: no stdlib file uses the generated-code argument readers '
        '[2026-09-07]', () {
      final offenders = <String>[];
      for (final entry in stdlibSources()) {
        for (final member in const ['getRequiredArg', 'getOptionalArg']) {
          if (entry.value.contains('D4.$member')) {
            offenders.add('${entry.key}: D4.$member');
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'These hand-written stdlib files reach for a GENERATED-code helper. '
            'D4.getRequiredArg and D4.getOptionalArg throw '
            'ArgumentD4rtException; every other arity failure in the stdlib '
            'throws RuntimeD4rtException, so mixing them makes the same mistake '
            'surface as two different types depending on which bridge you '
            'called. Use D4.checkArity for the arity check and cast the '
            'argument inline, which is what the other 526 adapters do.\n'
            '${offenders.join('\n')}',
      );
    });

    test('F-SCC87-AST-3: the arity guard the stdlib DOES use is the one that '
        'matches its dispatch path [2026-09-07]', () {
      // The positive half. If `checkArity` ever stopped being the stdlib's
      // guard — replaced wholesale, or renamed — F-SCC87-AST-2 would still pass
      // while the boundary had quietly moved.
      final users = stdlibSources()
          .where((e) => e.value.contains('D4.checkArity'))
          .length;
      expect(
        users,
        greaterThan(40),
        reason:
            'D4.checkArity was in 60 stdlib files across both trees on '
            '2026-09-07. A collapse here means the SCC85 sweep was reverted or '
            'the helper renamed, and the boundary this file documents no longer '
            'describes the code.',
      );
    });
  });
}
