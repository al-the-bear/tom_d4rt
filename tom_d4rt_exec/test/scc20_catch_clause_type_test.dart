import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// SCC20 — the catch clause was the last hand-written copy of the type test.
///
/// SCC18 extracted [`_valueHasType`] out of `visitIsExpression` and pointed the
/// typed-pattern paths at it, leaving one copy behind: the `on T` switch in the
/// try-statement visitor. That copy was not a stylistic duplicate. It was a
/// *different, smaller* predicate — a flat switch over sixteen hardcoded names
/// plus a bridge-identity probe — and the gap between the two was measurable
/// from a script.
///
/// Every case below was **measured before the fix**, by running the pair
/// (`on T` vs `x is T`) over the same value and comparing. The four that
/// disagreed are the four this file exists for; they are user-visible bugs, not
/// tidiness. That matters because SCC20's own filing predicted the opposite —
/// "it fixes no user-visible behaviour by itself" — and the probe says
/// otherwise. The realignment was worth doing for the reason given (the next
/// type-system fix would otherwise be taxed twice), but it also fixed four live
/// defects on the way, and the record should say so.
///
/// The measured pre-fix behaviour:
///
/// | probe                                          | `on T`        | `is T`  |
/// |------------------------------------------------|---------------|---------|
/// | `class MyEx implements Exception` / `on Exception` | not caught | `true`  |
/// | `class MyErr implements Error` / `on Error`    | not caught    | `true`  |
/// | `throw <String>['a']` / `on List<int>`         | **caught**    | `false` |
/// | `throw Box<String>(..)` / `on Box<int>`        | **caught**    | `false` |
/// | `throw (int x) => x` / `on int Function(int)`  | not caught    | n/a     |
/// | `throw c.HashSet()` / `on c.HashSet` (prefixed)| not caught    | `true`  |
///
/// Two of them are the dangerous direction: the clause caught a value whose
/// type it does not name, so the handler ran with the wrong exception bound.
///
/// The prefixed row is also where the two trees had silently drifted apart —
/// `tom_d4rt` did not catch, `tom_d4rt_ast` did — because the analyzer's
/// `NamedType.name` drops the prefix while the mirror's `SNamedType.name` did
/// not. Folding both onto the shared predicate is what re-converges them.
void main() {
  const String testLibPath = 'd4rt-mem:/scc20_catch_clause_type_test.dart';

  dynamic run(String scriptBody, {String prelude = ''}) {
    final fullScript =
        '''
$prelude
main() {
  $scriptBody
}
''';
    return D4rt().execute(
      library: testLibPath,
      name: 'main',
      sources: {testLibPath: fullScript},
    );
  }

  group('SCC20: an interpreted class reaches its bridged supertype', () {
    test('F-SCC20-1: `on Exception` catches a script class that implements it '
        '[2026-09-04]', () {
      // The catch switch answered this with the host operator
      // `thrownValue is Exception`, and an `InterpretedInstance` is not a
      // native `Exception` no matter what it declares — so the clause never
      // matched and the exception escaped to a bare `catch` or out of the
      // function. `is Exception` on the same value was already `true`, because
      // the shared predicate asks `InterpretedClass.isSubtypeOf`, which walks
      // the bridged-interface chain (RC-7).
      expect(
        run('''
          try { throw MyEx(); }
          on Exception catch (e) { return 'on-Exception'; }
          catch (e) { return 'fell-through'; }
        ''', prelude: 'class MyEx implements Exception {}'),
        equals('on-Exception'),
      );
    });

    test('F-SCC20-2: the `is` operator already agreed [2026-09-04]', () {
      // The control for F-SCC20-1. This passed before the fix; it is here so a
      // future regression cannot be mistaken for the operator having changed.
      expect(
        run(
          'return MyEx() is Exception;',
          prelude: 'class MyEx implements Exception {}',
        ),
        isTrue,
      );
    });

    test('F-SCC20-3: `on Error` catches a script class that implements it '
        '[2026-09-04]', () {
      // Same defect, second root. `Error` and `Exception` were two of the
      // sixteen hardcoded names in the old switch; the fix removes the switch
      // rather than adding a seventeenth.
      expect(
        run(
          '''
          try { throw MyErr(); }
          on Error catch (e) { return 'on-Error'; }
          catch (e) { return 'fell-through'; }
        ''',
          prelude:
              'class MyErr implements Error { StackTrace? get stackTrace => null; }',
        ),
        equals('on-Error'),
      );
    });

    test('F-SCC20-4: a script class NOT implementing Exception still escapes '
        '[2026-09-04]', () {
      // The negative half. Routing through the shared predicate must not turn
      // `on Exception` into a catch-all: a plain class implements nothing, so
      // the clause must still miss and the bare `catch` must win.
      expect(
        run('''
          try { throw Plain(); }
          on Exception catch (e) { return 'on-Exception'; }
          catch (e) { return 'fell-through'; }
        ''', prelude: 'class Plain {}'),
        equals('fell-through'),
      );
    });
  });

  group('SCC20: type arguments on the catch type are honoured', () {
    test('F-SCC20-5: `on List<int>` does not catch a `List<String>` '
        '[2026-09-04]', () {
      // The dangerous direction. The old `case 'List'` was
      // `thrownValue is List` with the type arguments discarded entirely, so
      // this clause caught a list of the wrong element type and bound it to
      // `e` — the handler then ran believing it held `List<int>`.
      expect(
        run('''
          try { throw <String>['a']; }
          on List<int> catch (e) { return 'on-List-int'; }
          catch (e) { return 'fell-through'; }
        '''),
        equals('fell-through'),
      );
    });

    test(
      'F-SCC20-6: `on List<int>` still catches a `List<int>` [2026-09-04]',
      () {
        expect(
          run('''
          try { throw <int>[1]; }
          on List<int> catch (e) { return 'on-List-int'; }
          catch (e) { return 'fell-through'; }
        '''),
          equals('on-List-int'),
        );
      },
    );

    test('F-SCC20-7: a bare `on List` still catches any list [2026-09-04]', () {
      // Without arguments the predicate must not start demanding them.
      expect(
        run('''
          try { throw <String>['a']; }
          on List catch (e) { return 'on-List'; }
          catch (e) { return 'fell-through'; }
        '''),
        equals('on-List'),
      );
    });

    test('F-SCC20-8: `on Box<int>` does not catch a `Box<String>` '
        '[2026-09-04]', () {
      // The same defect over an interpreted generic class. The old default
      // branch called `klass.isSubtypeOf(targetType)` with no applied
      // arguments, so every `Box<..>` matched every `on Box<..>`. The shared
      // predicate builds an `AppliedRuntimeType` and compares element-wise
      // (DFUB6).
      expect(
        run('''
          try { throw Box<String>('x'); }
          on Box<int> catch (e) { return 'on-Box-int'; }
          catch (e) { return 'fell-through'; }
        ''', prelude: 'class Box<T> { final T v; Box(this.v); }'),
        equals('fell-through'),
      );
    });

    test(
      'F-SCC20-9: `on Box<String>` catches a `Box<String>` [2026-09-04]',
      () {
        expect(
          run('''
          try { throw Box<String>('x'); }
          on Box<String> catch (e) { return e.v; }
          catch (e) { return 'fell-through'; }
        ''', prelude: 'class Box<T> { final T v; Box(this.v); }'),
          equals('x'),
        );
      },
    );
  });

  group('SCC20: non-named type annotations in the on-clause', () {
    test('F-SCC20-10: `on int Function(int)` catches a matching closure '
        '[2026-09-04]', () {
      // The old code tested `typeNode is NamedType` and, for anything else,
      // logged "Unsupported catch clause type node" and answered false. The
      // shared predicate has resolved function and record annotations since
      // DFUB5, so routing through it makes the on-clause understand them for
      // free — no new branch.
      expect(
        run('''
          try { throw (int x) => x; }
          on int Function(int) catch (e) { return 'on-fn'; }
          catch (e) { return 'fell-through'; }
        '''),
        equals('on-fn'),
      );
    });

    test('F-SCC20-11: `on (int, String)` catches a matching record '
        '[2026-09-04]', () {
      expect(
        run('''
          try { throw (1, 'a'); }
          on (int, String) catch (e) { return 'on-record'; }
          catch (e) { return 'fell-through'; }
        '''),
        equals('on-record'),
      );
    });
  });

  group('SCC20: prefixed on-clause types, and the tree convergence', () {
    test('F-SCC20-12: `on c.HashSet` catches a prefixed bridged type '
        '[2026-09-04]', () {
      // `NamedType.name` is the bare identifier and the prefix hangs off
      // `importPrefix`, so the old switch looked up `HashSet` — a name that is
      // not in scope when the library was imported `as c`. Resolution failed,
      // the warn-and-answer-false path ran, and the clause missed.
      //
      // This case is also the one that measured DIFFERENTLY in the two trees
      // before the fix: `tom_d4rt` fell through, `tom_d4rt_ast` caught, because
      // the mirror's `SNamedType.name` carries what the analyzer's does not.
      // Both now ask the same predicate, which reassembles `c.HashSet` the way
      // `_resolveTypeAnnotationWithEnvironment` does.
      expect(
        run('''
          try { throw c.HashSet<int>(); }
          on c.HashSet catch (e) { return 'on-prefixed'; }
          catch (e) { return 'fell-through'; }
        ''', prelude: "import 'dart:collection' as c;"),
        equals('on-prefixed'),
      );
    });
  });

  group('SCC20: the behaviour the fold must NOT disturb', () {
    test('F-SCC20-13: a bridged error thrown by script is caught by its own '
        'type [2026-09-04]', () {
      // SC5's case. `throw StateError('x')` arrives as a `BridgedInstance`, and
      // the predicate is handed the WRAPPER rather than the pre-unwrapped
      // native — deliberately, because its bridged path consults the wrapper's
      // own `bridgedClass` first, which is more precise than the native
      // fallback the old code went straight to.
      expect(
        run('''
          try { throw StateError('boom'); }
          on StateError catch (e) { return e.message; }
          catch (e) { return 'fell-through'; }
        '''),
        equals('boom'),
      );
    });

    test('F-SCC20-14: the catch variable is still bound to the wrapper '
        '[2026-09-04]', () {
      // Unwrapping was always a matching concern only. `e.message` works
      // because `e` holds the `BridgedInstance`, not the raw native object.
      expect(
        run('''
          try { throw FormatException('bad'); }
          on Exception catch (e) { return e.message; }
        '''),
        equals('bad'),
      );
    });

    test(
      'F-SCC20-15: subtype-correct bridged matching survives [2026-09-04]',
      () {
        // SCB7's case (`F-SCB7-11`): a thrown bridged collection matched by a
        // supertype the bridge does not declare an `isAssignable` for. It used to
        // need its own hand-placed fix inside the catch clause; it now rides on
        // the shared predicate's bridged path.
        expect(
          run('''
          try { throw UnmodifiableSetView(<int>{1}); }
          on Iterable catch (e) { return 'on-Iterable'; }
          catch (e) { return 'fell-through'; }
        ''', prelude: "import 'dart:collection';"),
          equals('on-Iterable'),
        );
      },
    );

    test('F-SCC20-16: an unresolvable on-type misses instead of throwing '
        '[2026-09-04]', () {
      // The one thing the catch clause legitimately needs that `is` does not.
      // `_valueHasType` reports a failed type lookup by THROWING; a catch
      // clause must not do that, because the throw would replace the exception
      // being dispatched with a lookup failure and lose the original. So the
      // call is wrapped and a resolution failure means "this clause does not
      // match" — which is exactly what the old warn-and-continue path did.
      expect(
        run('''
          try { throw 'boom'; }
          on NoSuchTypeAnywhere catch (e) { return 'on-missing'; }
          catch (e) { return 'fell-through'; }
        '''),
        equals('fell-through'),
      );
    });

    test('F-SCC20-17: `on dynamic` still catches anything [2026-09-04]', () {
      expect(
        run("try { throw 1; } on dynamic catch (e) { return 'on-dynamic'; }"),
        equals('on-dynamic'),
      );
    });

    test('F-SCC20-18: `on void` is a parse error, as it is in real Dart '
        '[2026-09-04]', () {
      // Measured while writing this file. Both switches carried a
      // `case 'void': typeMatch = false;` arm, and it was DEAD CODE: `void` is
      // not a valid on-clause type, so the parser rejects the script before
      // any visitor sees it. Pinned as a parse failure rather than deleted
      // silently, so that removing the arm is recorded as a deletion of
      // something unreachable rather than a behaviour change.
      expect(
        () => run('''
          try { throw 1; }
          on void catch (e) { return 'on-void'; }
          catch (e) { return 'fell-through'; }
        '''),
        throwsA(isA<SourceCodeD4rtException>()),
      );
    });

    test('F-SCC20-19: `on Object` catches, `on int` does not catch a double '
        '[2026-09-04]', () {
      expect(
        run("try { throw 1.5; } on Object catch (e) { return 'on-Object'; }"),
        equals('on-Object'),
      );
      expect(
        run('''
          try { throw 1.5; }
          on int catch (e) { return 'on-int'; }
          catch (e) { return 'fell-through'; }
        '''),
        equals('fell-through'),
      );
    });

    test('F-SCC20-20: clause order still decides, first match wins '
        '[2026-09-04]', () {
      // The fold changes what each clause answers, not how the loop uses the
      // answers. A more specific clause placed first must still win.
      expect(
        run('''
          try { throw StateError('x'); }
          on StateError catch (e) { return 'specific'; }
          on Error catch (e) { return 'general'; }
        '''),
        equals('specific'),
      );
      expect(
        run('''
          try { throw StateError('x'); }
          on Error catch (e) { return 'general'; }
          on StateError catch (e) { return 'specific'; }
        '''),
        equals('general'),
      );
    });

    test('F-SCC20-21: rethrow from a matched clause still propagates '
        '[2026-09-04]', () {
      expect(
        run('''
          try {
            try { throw StateError('x'); }
            on StateError catch (e) { rethrow; }
          } on Error catch (e) { return 'outer'; }
        '''),
        equals('outer'),
      );
    });
  });

  group('SCC20: the exception hierarchy the fold exposed', () {
    // Deleting the hand-written switch removed a `case 'Exception'` arm that
    // had been ANSWERING FOR a registry that was never populated. The error
    // side of `dart:core` has declared its supertype edges since RC-7; the
    // exception side had none at all, so `is Exception` was false for every
    // bridged exception in the workspace and only the catch clause's private
    // arm hid it. `ExceptionHierarchyCore` supplies the missing edges.

    test('F-SCC20-22: a bridged exception is an Exception [2026-09-04]', () {
      expect(
        run("""
          return [
            FormatException('x') is Exception,
            TimeoutException('x') is Exception,
          ];
        """, prelude: "import 'dart:async';"),
        equals([true, true]),
      );
    });

    test('F-SCC20-23: an Error is still not an Exception [2026-09-04]', () {
      // The negative half. `Error` and `Exception` are unrelated roots in the
      // SDK, and a blanket "anything throwable is an Exception" edge set would
      // satisfy F-SCC20-22 and break here.
      expect(
        run("""
          return [
            StateError('x') is Exception,
            StateError('x') is Error,
            ArgumentError('x') is Exception,
          ];
        """),
        equals([false, true, false]),
      );
    });

    test(
      'F-SCC20-24: the leaf bridge still owns member dispatch [2026-09-04]',
      () {
        // The reason the fix is registry edges and NOT an `isAssignable` on the
        // `Exception` bridge. `isAssignable` decides which bridge owns a native
        // value, so one on a root type makes the root match everything in its
        // hierarchy and steal dispatch from its own subtypes. These getters live
        // on `FormatException` alone and would disappear if that happened.
        // `source` and `offset` come back null, and that is a SEPARATE defect
        // measured here rather than papered over: the `FormatException` bridge
        // reads them from namedArgs while the SDK constructor takes them
        // positionally, so the two positional arguments are dropped. Filed as
        // SCD68. What this case proves is unaffected — the `Exception` bridge
        // declares no `source` or `offset` getter at all, so reaching them and
        // getting null means the FormatException bridge answered.
        expect(
          run("""
          var e = FormatException('bad', 'src', 2);
          return [e.message, e.source, e.offset];
        """),
          equals(['bad', null, null]),
        );
      },
    );

    test('F-SCC20-25: the io exceptions reach Exception through IOException '
        '[2026-09-04]', () {
      // Three hops for the path exceptions
      // (`PathNotFoundException -> FileSystemException -> IOException ->
      // Exception`), which only answers correctly because SCC19 made the
      // subtype walk transitive. `IOException` is not bridged, so it is named
      // as an intermediate rather than asked about directly.
      expect(
        BridgedClass.transitiveSupertypeNames('PathNotFoundException'),
        containsAll(<String>[
          'FileSystemException',
          'IOException',
          'Exception',
        ]),
      );
      expect(
        BridgedClass.transitiveSupertypeNames('SocketException'),
        containsAll(<String>['IOException', 'Exception']),
      );
    });
  });
}
