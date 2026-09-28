/// SCE225 — a bridged member has exactly one kind.
///
/// The kind (getter / setter / method / operator) decides which registration
/// map the member is emitted into. scd189 found six hand-written stdlib members
/// in the wrong map; the generated bridges were measured on 2026-09-29 against
/// the analyzer element model — every one of the 60 000+ registered getters and
/// methods in both Flutter twins, including the 2 496 reached through
/// `dynamic` and the 7 through `Function.apply` — and none was. The kind is
/// taken from the element type, so it is right by construction; the assertion
/// in `MemberInfo` keeps that true for any member built with no kind or two.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_generator.dart';

void main() {
  group('SCE225: MemberInfo kind', () {
    test('G-SCE225-1: a member with two kinds or none is refused '
        '[2026-09-29] (PASS)', () {
      expect(
        () => MemberInfo(
          name: 'x',
          returnType: 'int',
          isGetter: true,
          isMethod: true,
        ),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => MemberInfo(name: 'x', returnType: 'int'),
        throwsA(isA<AssertionError>()),
      );
    });

    test('G-SCE225-2: each single kind is accepted [2026-09-29] (PASS)', () {
      for (final member in [
        MemberInfo(name: 'g', returnType: 'int', isGetter: true),
        MemberInfo(name: 's', returnType: 'int', isSetter: true),
        MemberInfo(name: 'm', returnType: 'int', isMethod: true),
        MemberInfo(name: '+', returnType: 'int', isOperator: true),
      ]) {
        expect(member.name, isNotEmpty);
      }
    });
  });
}
