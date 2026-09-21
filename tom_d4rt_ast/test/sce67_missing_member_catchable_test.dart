// SCE67, analyzer-free side: the property, asserted where it ships.
//
// The source-running half of this lives in
// `tom_d4rt/test/sce67_missing_member_catchable_test.dart` — it drives real
// scripts through `D4rt.execute` and checks that a script's
// `on NoSuchMethodError` clause catches a missing getter as well as a missing
// method. This package has no parser, so it cannot ask that question the same
// way.
//
// WHAT IT CAN ASSERT IS THE THING THAT MATTERS HERE, and it is not a
// consolation prize: this is the tree a Flutter app ships, so the hierarchy
// being right in THIS copy is what decides whether an app's catch clause
// works. The mirror rule keeps `exceptions.dart` byte-identical between the
// trees, but a mirror guard tells you the files agree — not that either is
// correct. If the fix were ever reverted on one side, the mirror guard would
// report drift while this reports which side is wrong.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  group('SCE67: a missing member is catchable as the SDK type', () {
    test('F-SCE67-AST-1: UndefinedMemberD4rtException is a NoSuchMethodError '
        '[2026-09-21]', () {
      final error = UndefinedMemberD4rtException('nope', memberName: 'nope');
      expect(
        error,
        isA<NoSuchMethodError>(),
        reason:
            'a missing GETTER raises this; a missing METHOD raises '
            'D4rtNoSuchMethodError. Both must be catchable the way a script '
            "would catch real Dart's.",
      );
    });

    test('F-SCE67-AST-2: the supertype was added, not swapped [2026-09-21]', () {
      // Every internal extension-lookup decision in interpreter_visitor.dart
      // tests `is UndefinedMemberD4rtException`, and `on RuntimeD4rtException`
      // clauses exist throughout. Swapping the hierarchy rather than widening
      // it would break both, silently and only at runtime.
      final error = UndefinedMemberD4rtException('nope', memberName: 'nope');
      expect(error, isA<RuntimeD4rtException>());
      expect(error, isA<UndefinedMemberD4rtException>());
      expect(error.memberName, 'nope');
    });

    test('F-SCE67-AST-3 (control): the deliberately uncatchable ones stay so '
        '[2026-09-21]', () {
      // Real Dart rejects a bare undefined name and a missing static at
      // COMPILE time, so there is no runtime NoSuchMethodError to model.
      // Giving them the supertype would make d4rt strictly more catchable
      // than the platform.
      expect(
        UndefinedNameD4rtException('x', name: 'x'),
        isNot(isA<NoSuchMethodError>()),
      );
      expect(
        UndefinedStaticMemberD4rtException('x', memberName: 'x'),
        isNot(isA<NoSuchMethodError>()),
      );
    });
  });
}
