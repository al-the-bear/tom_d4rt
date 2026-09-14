import 'dart:typed_data';

import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCD98 — one representation for a bridged value: the BARE NATIVE.
///
/// THE WRAPPING TABLE, measured on the working tree before the fix. The todo
/// made writing it down a precondition for choosing a direction, because the
/// two candidates (always wrap / never wrap) have very different blast radii
/// and only the table says which one the codebase is already closer to.
///
/// | site                                   | before      | after  |
/// | -------------------------------------- | ----------- | ------ |
/// | bridged constructor, default           | **wrapper** | native |
/// | bridged constructor, named             | **wrapper** | native |
/// | bridged constructor, generic factory   | **wrapper** | native |
/// | redirecting factory target             | **wrapper** | native |
/// | bridged method return                  | native      | native |
/// | bridged getter return                  | native      | native |
/// | bridged operator return                | native      | native |
/// | bridged static method / const          | native      | native |
/// | argument marshalled INTO a bridge      | native      | native |
/// | `toBridgedInstance(native)`            | wrapper     | wrapper |
///
/// The constructor was the lone outlier, and `toBridgedInstance` stays a
/// wrapper on purpose — it IS the bridge-dispatch boundary the wrapper is
/// supposed to be confined to. So "never wrap" was a four-site change at the
/// introduction point rather than a refactor of the value representation, which
/// is what the table was for.
///
/// WHY IT WAS NEARLY INVISIBLE, and how it was found anyway
///
/// Every observation route a script has already unwraps: the host boundary, the
/// `runtimeType` getter, argument marshalling into a bridge, and
/// `visitBinaryExpression`, which unwraps both operands before `==`. So
/// `runtimeType`, `is`, `==` and simple membership ALL agreed before the fix —
/// a probe built on any of them reports no defect.
///
/// It bites where a NATIVE container compares its own stored elements, because
/// then the interpreter is not in the loop:
///
/// ```dart
/// [Duration(seconds: 86400),                      // constructed -> wrapper
///  DateTime(2020,1,2).difference(DateTime(2020,1,1))  // method   -> native
/// ].toSet().length   // was 2, is 1
/// ```
///
/// And it is ORDER-DEPENDENT, which is the fingerprint: `[ctor, method]` failed
/// and `[method, ctor]` passed. SCC32 gave `BridgedInstance` cross-boundary
/// `==`/`hashCode`, so `wrapper == raw` is true — but `raw == wrapper` cannot
/// be, because a native's `==` rejects a foreign type and nothing in this
/// package can override that. A stored wrapper probed by a bare native runs the
/// direction that cannot work.
///
/// THE SECOND DEFECT, which was already live before this change
///
/// Chasing the first one surfaced a worse one, reachable today with no wrapper
/// involved: `_bridgeInterpreterValueToNative` rebuilt every `List` with
/// `.map(...).toList()`, which retypes unconditionally. So a `Uint8List`
/// reaching the host from a METHOD or GETTER arrived as `List<Object?>` and the
/// host's `as Uint8List` threw. The CONSTRUCTOR route survived only because its
/// wrapper took the `BridgedInstance` branch above and never reached the list
/// branch — the same split, showing up as a type loss rather than a duplicate.
/// The boundary now rebuilds only when an element actually changed (F-SCD98-5).
///
/// WHAT BECOMES OF SCC32. Its cross-boundary `==`/`hashCode` and hash-key
/// normalisation are no longer load-bearing for values this interpreter
/// produces — nothing it produces is a wrapper any more. They are NOT removed:
/// `toBridgedInstance` still hands a wrapper to bridge dispatch, and an
/// embedder can put one into a collection itself. They stop being a workaround
/// for an internal inconsistency and become what they read as — a courtesy to
/// a wrapper that arrives from outside. F-SCC32-10/11/12 keep passing, and
/// their comments are the place that says so.
void main() {
  group('SCD98: a bridged value has one representation', () {
    // The two routes that used to disagree. `C` is constructed (was a
    // wrapper), `M` comes from a method return (was always bare).
    const c = 'Duration(seconds: 86400)';
    const m = 'DateTime(2020,1,2).difference(DateTime(2020,1,1))';

    test('F-SCD98-1: a native container deduplicates across both routes '
        '[2026-09-14]', () {
      // The defect. `[C, M]` holds one Duration twice, so `toSet()` must give
      // one element — and did give two, because the native Set compared a
      // stored wrapper against a bare probe.
      expect(execute('main() => [$c, $m].toSet().length;'), 1);
      expect(execute('main() => Set.of([$c, $m]).length;'), 1);
      expect(execute('main() => [$c].followedBy([$m]).toSet().length;'), 1);
    });

    test('F-SCD98-2: and it is no longer order-dependent [2026-09-14]', () {
      // The fingerprint that identified the cause: before the fix the
      // wrapper-first order failed and the native-first order passed. Both
      // orders are asserted so a partial fix cannot pass this file.
      expect(execute('main() => [$c, $m].toSet().length;'), 1);
      expect(execute('main() => [$m, $c].toSet().length;'), 1);
      expect(
        execute(
          'main() { var x = {}; x[$c] = 1; x[$m] = 2; return x.length; }',
        ),
        1,
      );
      expect(
        execute(
          'main() { var x = {}; x[$m] = 1; x[$c] = 2; return x.length; }',
        ),
        1,
      );
    });

    test('F-SCD98-3: the four observations the todo names all agree '
        '[2026-09-14]', () {
      // `runtimeType`, `is`, `==` and membership. These agreed BEFORE the fix
      // too — every route a script has to look at a value already unwrapped —
      // so they are pinned as the floor rather than as the finding.
      expect(execute('main() => $c.runtimeType.toString();'), 'Duration');
      expect(execute('main() => $m.runtimeType.toString();'), 'Duration');
      expect(execute('main() => $c is Duration;'), isTrue);
      expect(execute('main() => $m is Duration;'), isTrue);
      expect(execute('main() => $c == $m;'), isTrue);
      expect(execute('main() => $m == $c;'), isTrue);
      expect(execute('main() => [$c].contains($m);'), isTrue);
      expect(execute('main() => [$m].contains($c);'), isTrue);
    });

    test('F-SCD98-4: every production route yields the same shape '
        '[2026-09-14]', () {
      // Constructor, named constructor, method, getter, operator, static. The
      // table in this file\'s header in assertion form: if any one of these
      // started wrapping again, the collection cases above would go
      // order-dependent again and this case says which route did it.
      const routes = <String>[
        'Duration(seconds: 1)',
        'Duration.zero',
        'Duration(seconds: -1).abs()',
        'DateTime(2020).timeZoneOffset',
        'Duration(seconds: 1) * 1',
        'Duration(milliseconds: 500) + Duration(milliseconds: 500)',
      ];
      for (final route in routes) {
        expect(
          // Parenthesised: `Duration(seconds: 1) * 1.runtimeType` would bind
          // the getter to the `1`, not to the operator's result.
          execute('main() => ($route).runtimeType.toString();'),
          'Duration',
          reason: '$route did not produce a bare Duration',
        );
      }
    });

    test('F-SCD98-5: a typed-data list keeps its type on every route '
        '[2026-09-14]', () {
      // The second defect, which was live before this change and had nothing
      // to do with the wrapper: the host boundary rebuilt every List with
      // `.map(...).toList()`, so a `Uint8List` from a METHOD or GETTER reached
      // the host as `List<Object?>`. The constructor route survived only
      // because its wrapper skipped the list branch entirely.
      Object? run(String expr) =>
          execute("import 'dart:typed_data';\nmain() => $expr;");
      expect(run('Uint8List.fromList(<int>[1, 2])'), isA<Uint8List>());
      expect(run('Uint8List(2)'), isA<Uint8List>());
      expect(
        run('Uint8List.fromList(<int>[1, 2]).sublist(0)'),
        isA<Uint8List>(),
      );
      expect(
        run('Uint8List.fromList(<int>[1, 2]).buffer.asUint8List()'),
        isA<Uint8List>(),
      );
    });

    test('F-SCD98-6: an ordinary list is still bridged element-wise '
        '[2026-09-14]', () {
      // The boundary now returns the ORIGINAL list when nothing changed, so
      // this is the case that says it still converts when something did.
      expect(execute('main() => [1, 2, 3];'), [1, 2, 3]);
      expect(execute('main() => [Duration(seconds: 1)].first.inSeconds;'), 1);
      expect(execute('main() => {"a": 1};'), {'a': 1});
    });
  });
}
