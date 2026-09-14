import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCD99 — `runtimeType` names the bridged type, and the answer is USABLE.
///
/// THE REPORTED SYMPTOM WAS ALREADY GONE, and the real one was next door.
///
/// The todo says `Duration(seconds: 1).runtimeType.toString()` is
/// `'BridgedInstance<Object>'`. Measured on the working tree it is `Duration`:
/// the member-access sites answer `bridgedInstance.nativeObject.runtimeType`,
/// and SCD98 then stopped the constructor producing a wrapper at all. So the
/// one-line fix the todo recommends is already in place at every site an audit
/// finds.
///
/// What the todo was actually about survived that. Its stated harm is "a script
/// that branches on `x.runtimeType` takes the wrong branch with no error", and
/// that was true — for a different reason, and for EVERY type:
///
/// ```dart
/// Duration(seconds: 1).runtimeType == Duration   // was false
/// 1.runtimeType == int                           // was false
/// 'a'.runtimeType == String                      // was false
/// DateTime(2020).runtimeType == DateTime         // was false
/// Duration == Duration(seconds: 1).runtimeType   // was TRUE
/// ```
///
/// Asymmetric by operand order, false in the order everybody writes. A correct
/// `runtimeType` whose result cannot be compared to a type literal is not worth
/// much, so this is the same defect the todo names, one step further along.
///
/// WHY IT HAPPENED, and why the reconciliation that existed never ran
///
/// `visitBinaryExpression` HAD the Type-vs-`BridgedClass` comparison — twice,
/// in the `==` and `!=` arms of its operator switch. Neither was reachable for
/// this shape. `Environment.toBridgedInstance` succeeds on a `Type` object, so
/// the bridged-operator dispatch twenty lines ABOVE the switch found an `==`
/// adapter and invoked it on the WRAPPER, comparing a wrapped `Type` against a
/// `BridgedClass` and answering false.
///
/// That is the wrapper substituting itself for the value it wraps — the shape
/// SCD98 removed from the constructor, surviving here because a dispatch site
/// reached it first. The reconciliation is now hoisted above that dispatch, and
/// the two copies in the arms are deleted rather than left as unreachable
/// duplicates: a second implementation of one rule is what let this diverge
/// without anyone noticing.
///
/// THE NEIGHBOURS, audited because the todo asked
///
/// `toString`, `hashCode`, `is`, `is!`, `as` and cross-route `==` were all
/// measured on both production routes and all already delegate to the native.
/// They are pinned below anyway — they are the cases that say the hoist did not
/// buy `runtimeType` at their expense.
void main() {
  const ctor = 'Duration(seconds: 1)';
  const method = 'DateTime(2021).difference(DateTime(2020))';

  group('SCD99: runtimeType names the bridged type', () {
    test('F-SCD99-1: runtimeType is the native type on both routes '
        '[2026-09-14]', () {
      expect(execute('main() => $ctor.runtimeType.toString();'), 'Duration');
      expect(execute('main() => $method.runtimeType.toString();'), 'Duration');
    });

    test(
      'F-SCD99-2: and it compares equal to the type literal [2026-09-14]',
      () {
        // The defect. A `runtimeType` that reads correctly but compares false to
        // its own type is the wrong-branch bug the todo was filed about.
        expect(execute('main() => $ctor.runtimeType == Duration;'), isTrue);
        expect(execute('main() => $method.runtimeType == Duration;'), isTrue);
      },
    );

    test('F-SCD99-3: in BOTH operand orders [2026-09-14]', () {
      // The asymmetry was the fingerprint: the reversed order already worked,
      // so a test written only that way would have reported no defect.
      expect(execute('main() => $ctor.runtimeType == Duration;'), isTrue);
      expect(execute('main() => Duration == $ctor.runtimeType;'), isTrue);
    });

    test('F-SCD99-4: it was never Duration-specific [2026-09-14]', () {
      // `int` and `String` were false too. Pinned so the fix is understood as
      // general rather than as a bridged-Duration special case.
      expect(execute('main() => 1.runtimeType == int;'), isTrue);
      expect(execute("main() => 'a'.runtimeType == String;"), isTrue);
      expect(
        execute('main() => DateTime(2020).runtimeType == DateTime;'),
        isTrue,
      );
      expect(execute('main() => true.runtimeType == bool;'), isTrue);
    });

    test(
      'F-SCD99-5: `!=` follows, and a mismatch is still false [2026-09-14]',
      () {
        // The `!=` arm carried its own copy of the reconciliation and is now
        // served by the same hoisted one, so both operators are asserted.
        expect(execute('main() => $ctor.runtimeType != Duration;'), isFalse);
        expect(execute('main() => $ctor.runtimeType != String;'), isTrue);
        expect(execute('main() => $ctor.runtimeType == String;'), isFalse);
      },
    );

    test('F-SCD99-6: a generic type argument still distinguishes, as Dart '
        'has it [2026-09-14]', () {
      // `[1].runtimeType` is `List<int>`, which is NOT `List`. Real Dart says
      // false here, so a fix that made every Type-vs-name comparison true
      // would be wrong in the other direction.
      expect(execute('main() => [1].runtimeType == List;'), isFalse);
    });

    // ------------------------------------------------------------------
    // The neighbours. Each already delegated; they are here to say the hoist
    // did not buy `runtimeType` at their expense.

    test('F-SCD99-7: the universal members delegate to the native '
        '[2026-09-14]', () {
      expect(execute('main() => $ctor.toString();'), '0:00:01.000000');
      expect(execute('main() => $ctor is Duration;'), isTrue);
      expect(execute('main() => $method is Duration;'), isTrue);
      expect(execute('main() => $ctor is! String;'), isTrue);
      expect(execute('main() => ($ctor as Duration).inSeconds;'), 1);
      expect(
        execute(
          'main() => Duration(seconds: 86400).hashCode == '
          'DateTime(2020,1,2).difference(DateTime(2020,1,1)).hashCode;',
        ),
        isTrue,
      );
    });

    test('F-SCD99-8: equality on every other receiver is unaffected '
        '[2026-09-14]', () {
      // The hoist runs before the bridged-operator dispatch, so these are the
      // cases that say it did not intercept anything it should not have.
      expect(execute('enum E { a, b }\nmain() => E.a == E.a;'), isTrue);
      expect(execute('enum E { a, b }\nmain() => E.a != E.b;'), isTrue);
      expect(execute("main() => 'a' == 'a';"), isTrue);
      expect(execute('main() => null == null;'), isTrue);
      expect(execute('main() => DateTime(2020) == DateTime(2020);'), isTrue);
      expect(
        execute('''
          class P {
            final int v;
            P(this.v);
            bool operator ==(Object o) => o is P && o.v == v;
            int get hashCode => v;
          }
          main() => P(1) == P(1);
        '''),
        isTrue,
      );
    });
  });
}
