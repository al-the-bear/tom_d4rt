// SCE101 — the element-type predicate answers the same question as `is`.
//
// `interpreter_visitor.dart` carries TWO predicates for "does this value have
// this type". `_valueHasType` answers the `is` operator, typed patterns, the
// declared-type check and `on` clauses — four call sites, one body, as SCB7 and
// SCC18 left it. `_checkValueMatchesType` answers the ELEMENT and KEY/VALUE
// types of a generic collection: it is what `_checkGenericListType` and
// `_checkGenericMapType` call, and it is reached only from inside the `List` /
// `Map` arms of the first one.
//
// So the same question is asked twice about the same value, and until this
// file the two answered differently. Measured before the fix:
//
//   | question                          | `x is T` | `[x] is List<T>` |
//   | --------------------------------- | -------- | ---------------- |
//   | null against `Null`               | true     | FALSE            |
//   | null against `dynamic`            | true     | FALSE            |
//   | a class against `Type`            | true     | FALSE            |
//   | a NATIVE bridged value against    | true     | FALSE            |
//   |   its own bridged class           |          |                  |
//   | a WRAPPED bridged value against   | true     | FALSE            |
//   |   `List`                          |          |                  |
//
// Every row is the small predicate being narrower than the large one, and the
// last two are mirror images of each other — which is the detail that makes
// this more than a list of missing cases. `_checkValueMatchesType` got the
// NATIVE form right in the shape arms and the WRAPPED form right in the
// user-type arm, and each was wrong about the other. A bridged value reaches
// the interpreter in both forms — `dart:collection`'s bridges hand back
// natives, a bridge whose constructor returns a `BridgedInstance` hands back a
// wrapper — so neither form is hypothetical and no single-sided fix is enough.
//
// THE PREDICTION THIS FILE WAS WRITTEN FROM WAS HALF RIGHT, and the half that
// was wrong is worth recording. It named the missing `BridgedInstance` unwrap
// and pointed at `UnmodifiableListView` and `HashMap` as the probe, the way
// SCB7 had. Those no longer wrap — measured, they evaluate to native
// `UnmodifiableListView` and `_HashMap` — so the probe came back green and the
// defect looked absent. It is not absent; it needs a bridge that still wraps,
// which is what `WrappedBag` below is for. A probe that cannot produce the
// input proves nothing about the code.
//
// WHY THE FIX IS FIVE ARMS AND NOT A DELEGATION. Pointing
// `_checkValueMatchesType` at `_valueHasType` is the right answer on the
// merits and is filed separately: the small predicate is deliberately LENIENT
// where the large one is strict — an unresolvable type name returns true here
// and false there — so delegation changes answers this file does not measure,
// on the hot path of every `is`. The arms below close the divergences that
// were measured, and nothing else.
//
// `void` IS LEFT DIVERGENT DELIBERATELY. `x is void` does not parse, so the
// large predicate's `void` arm is unreachable from the operator and its own
// comment hedges ("or error? - let's say false"). As an element type,
// `[1] is List<void>` answers true here. Making the two agree would mean
// picking which unreachable answer is correct with no case to appeal to, so
// the divergence stays and is named rather than silently closed.

import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A real `List` subtype, so a bridge over it can be asked both questions.
class Bag extends ListBase<Object?> {
  Bag(this._inner);
  final List<Object?> _inner;

  @override
  int get length => _inner.length;
  @override
  set length(int value) => _inner.length = value;
  @override
  Object? operator [](int i) => _inner[i];
  @override
  void operator []=(int i, Object? value) => _inner[i] = value;
}

void main() {
  final d4rt = D4rt();

  // Two bridges over the same native type, differing only in what the
  // constructor hands back. That is the whole experiment: `Bag` returns the
  // native object, as `dart:collection`'s bridges do, and `WrappedBag` returns
  // the `BridgedInstance` wrapper, as a bridge is equally free to do.
  d4rt.registerBridgedClass(
    BridgedClass(
      nativeType: Bag,
      name: 'Bag',
      constructors: {
        '': (visitor, positional, named) =>
            Bag(List<Object?>.from(positional.first as List)),
      },
    ),
    'package:probe/bag.dart',
  );
  late final BridgedClass wrappedBag;
  wrappedBag = BridgedClass(
    nativeType: Bag,
    name: 'WrappedBag',
    constructors: {
      '': (visitor, positional, named) => BridgedInstance(
        wrappedBag,
        Bag(List<Object?>.from(positional.first as List)),
      ),
    },
  );
  d4rt.registerBridgedClass(wrappedBag, 'package:probe/wrapped.dart');

  /// Runs [body] as the body of `main`, with both bridges importable.
  Object? run(String body) => d4rt.execute(
    source:
        "import 'package:probe/bag.dart';\n"
        "import 'package:probe/wrapped.dart';\n"
        'class Foo {}\n'
        'Object? main() {\n$body\n}',
  );

  group('SCE101: a generic element is asked the same question as `is`', () {
    test('F-SCE101-1: null satisfies Null and dynamic as an element '
        '[2026-09-22] (PASS)', () {
      expect(run('var l = <Object?>[null]; return l is List<Null>;'), isTrue);
      expect(
        run('var l = <Object?>[null]; return l is List<dynamic>;'),
        isTrue,
      );
      expect(
        run(
          "var m = <String, Object?>{'a': null}; return m is Map<String, Null>;",
        ),
        isTrue,
      );
    });

    test(
      'F-SCE101-2: a class satisfies Type as an element [2026-09-22] (PASS)',
      () {
        expect(run('var l = <Object?>[int]; return l is List<Type>;'), isTrue);
        expect(run('var l = <Object?>[Foo]; return l is List<Type>;'), isTrue);
      },
    );

    test('F-SCE101-3: a NATIVE bridged element satisfies its bridged class '
        '[2026-09-22] (PASS)', () {
      expect(run('var l = <Object>[Bag([1])]; return l is List<Bag>;'), isTrue);
      expect(
        run(
          "var m = <String, Object>{'a': Bag([1])}; return m is Map<String, Bag>;",
        ),
        isTrue,
      );
    });

    test('F-SCE101-4: a WRAPPED bridged element satisfies the shape arms '
        '[2026-09-22] (PASS)', () {
      expect(
        run('var l = <Object>[WrappedBag([1])]; return l is List<List>;'),
        isTrue,
      );
      expect(
        run(
          "var m = <String, Object>{'a': WrappedBag([1])}; "
          'return m is Map<String, List>;',
        ),
        isTrue,
      );
    });

    // ---- the rails ---------------------------------------------------------
    //
    // Everything above is a `false` that should have been `true`, so a fix of
    // "answer true" satisfies all of it. These say what must stay false.

    test('F-SCE101-5 (control): a non-matching element is still rejected '
        '[2026-09-22] (PASS)', () {
      expect(run('var l = <Object?>[1]; return l is List<Null>;'), isFalse);
      expect(run('var l = <Object?>[1]; return l is List<Bag>;'), isFalse);
      expect(run("var l = <Object?>['s']; return l is List<int>;"), isFalse);
      expect(
        run(
          "var m = <String, Object?>{'a': 1}; return m is Map<String, Null>;",
        ),
        isFalse,
      );
    });

    test('F-SCE101-6 (control): Object still rejects null as an element '
        '[2026-09-22] (PASS)', () {
      // `Object` and `dynamic` were ONE case before this change, both
      // answering "non-null". Splitting them is only correct if the `Object`
      // half keeps its answer.
      expect(
        run('var l = <Object?>[null]; return l is List<Object>;'),
        isFalse,
      );
      expect(run('var l = <Object?>[1]; return l is List<Object>;'), isTrue);
    });

    test('F-SCE101-7 (control): an interpreted element is unaffected '
        '[2026-09-22] (PASS)', () {
      // This arm was already correct and shares the `default` branch with the
      // bridged one, which is what F-SCE101-3 changes.
      expect(run('var l = <Object>[Foo()]; return l is List<Foo>;'), isTrue);
      expect(run('var l = <Object>[1]; return l is List<Foo>;'), isFalse);
    });

    test('F-SCE101-8 (control): the nullable suffix still works on elements '
        '[2026-09-22] (PASS)', () {
      // SCD62 put this in the small predicate first; the arms added here must
      // not displace it.
      expect(
        run('var l = <Object?>[null]; return l is List<String?>;'),
        isTrue,
      );
      expect(
        run('var l = <Object?>[null]; return l is List<String>;'),
        isFalse,
      );
    });

    test('F-SCE101-9: the two predicates agree on every case above '
        '[2026-09-22] (PASS)', () {
      // The claim the file is named for, asked directly: the same value and
      // the same type name, once through `is` and once as an element. A future
      // change that fixes one predicate and not the other fails here even if
      // it satisfies every case above, because those pin the element side
      // alone.
      const pairs = <String, String>{
        'null': 'Null',
        'null ': 'dynamic',
        'int': 'Type',
        'Bag([1])': 'Bag',
        'WrappedBag([1])': 'List',
        '1': 'Object',
        'Foo()': 'Foo',
      };
      final disagreements = <String>[];
      pairs.forEach((expr, type) {
        final direct = run('Object? v = $expr; return v is $type;');
        final element = run(
          'var l = <Object?>[$expr]; return l is List<$type>;',
        );
        if (direct != element) {
          disagreements.add('$expr is $type: direct=$direct element=$element');
        }
      });
      expect(
        disagreements,
        isEmpty,
        reason:
            'These values are answered differently by `is` and by the same '
            'type as a generic element:\n${disagreements.join('\n')}',
      );
    });
  });
}
