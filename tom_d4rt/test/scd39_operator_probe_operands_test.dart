@Timeout(Duration(minutes: 5))
library;

import 'package:test/test.dart';

import '../tool/stdlib_member_diff.dart';

/// SCD39 — the operator probe's right-hand operand comes from the SDK
/// signature, not from the instance.
///
/// A member named `+` or `[]` cannot be read as `o.+`, so the audit drives it
/// through an expression. That expression used to put the instance on both
/// sides — `o * o` — which on `String` is `'a' * 'a'`.
///
/// ## Why the self-operand made the column unfalsifiable
///
/// The interpreter's final fallthrough for a binary expression is
///
///     Unsupported operator (STAR) for types String and String
///
/// and that single wording covers BOTH "this operator does not resolve" and
/// "these operand types are wrong". With an ill-typed probe the two are
/// indistinguishable, so the audit could only ever answer "reachable" for
/// `String *` — whatever the truth. Measured: with `String`'s `*` removed from
/// the interpreter, the self-operand probe reported **0 confirmed gaps** and
/// the signature-derived probe reported **1**.
///
/// That is also why `_isUnreachableOperatorError` may recognise the
/// fallthrough wording and `_isUnreachableError` may not: the wording is only
/// unambiguous once the operand is known to type-check. The narrow classifier
/// and the derived operand are one change, not two.
///
/// ## What these cases pin
///
/// F-SCD39-1..3 pin the operand derivation itself, which is what makes the
/// wording safe to classify on. F-SCD39-4 pins the direction the audit must
/// never lose: an operator with no derivable operand is UNVERIFIED WITH A
/// REASON, never silently reachable — skipping is exactly how these operators
/// came to be classified as reachable in the first place.
void main() {
  final env = buildFullyRegisteredEnvironment();

  ({String? probe, String? reason}) probeFor(String className, String op) {
    final bc = env.findBridgedClassByName(className);
    expect(
      bc,
      isNotNull,
      reason:
          '`$className` is no longer bridged, so this case is asserting '
          'nothing. Point it at a class that is.',
    );
    return operatorProbeForDebug(className, bc!.nativeType, op);
  }

  group('SCD39: operator operands are derived from the SDK signature', () {
    test('F-SCD39-1: `String *` takes an int, so the probe passes one '
        '[2026-09-12]', () {
      // The case SCD39 was filed for. `o * o` here is `'a' * 'a'`.
      expect(probeFor('String', '*').probe, 'o * 1');
    });

    test('F-SCD39-2: an operator whose signature admits its own type keeps '
        'the self-operand [2026-09-12]', () {
      // The self-operand is not a workaround to be removed — where it
      // type-checks it is the most faithful probe available, exercising the
      // operator with a value of exactly the kind the class is built from.
      expect(probeFor('int', '+').probe, 'o + o');
      expect(probeFor('String', '+').probe, 'o + o');
    });

    test('F-SCD39-3: an index operator gets a valid index of the declared key '
        'type [2026-09-12]', () {
      // `HttpHeaders[]` declares a String key and was probed with `o[0]`.
      // A literal `0` on a List is deliberate and separate: the recipes yield
      // small collections, so `1` is frequently out of range and a RangeError
      // is a different failure from an unresolved operator.
      expect(probeFor('HttpHeaders', '[]').probe, "o['a']");
      expect(probeFor('List', '[]').probe, 'o[0]');
    });

    test('F-SCD39-4: an operator with no derivable operand yields a reason, '
        'not a probe [2026-09-12]', () {
      // `DateTime +` declares `Duration`, and the mirror does not surface the
      // declaration at all, so there is nothing to derive from. The contract
      // under test is the SHAPE of that answer: a null probe carrying a stated
      // reason, which `verifyOperator` turns into UNVERIFIED rather than into
      // a silent pass.
      final built = probeFor('DateTime', '+');
      expect(
        built.probe,
        isNull,
        reason:
            'If a probe can now be derived for DateTime `+`, this case has '
            'lost its subject. Point it at another operator with no '
            'reflectable signature rather than deleting it — the '
            'unverified-with-a-reason path is the half of SCD39 that stops '
            'an unmeasurable operator from reading as reachable.',
      );
      expect(built.reason, isNotNull);
      expect(built.reason, contains('not reflectable'));
    });

    test('F-SCD39-5: every operator candidate the audit actually probes has a '
        'well-typed probe [2026-09-12]', () async {
      // The DONE WHEN, as a measurement rather than a claim. `operatorProbeSkips`
      // is populated during verification with every operator that could not be
      // given one; it is empty today, and an entry appearing here is not a
      // failure of this case so much as a prompt to state the reason in the
      // audit doc.
      final diffs = collectMemberDiffs(env);
      await verifyAll(diffs);
      expect(
        operatorProbeSkips,
        isEmpty,
        reason:
            'These operator candidates could not be given a well-typed probe, '
            'so they are unverified. That is the honest answer, but it needs '
            'to be a stated one: record them in doc/stdlib_sdk_gap_audit.md '
            'under the operator-probe section.\n$operatorProbeSkips',
      );
    });
  });
}
