// EXEC PORT of `tom_d4rt/test/scd35_bridged_tearoff_as_callback_test.dart`,
// BEHAVIOURAL CASES ONLY (SCG3). The reference is a repo-wide guard: F-SCD35-9,
// -13 and -14 scan the stdlib and every generated bridge in the repo off disk,
// so a copy here would re-read the identical files and produce a duplicate
// failure, not a second measurement. Those stay in tom_d4rt. The remaining
// cases run scripts, and here they run through exec's pipeline on the published
// tom_d4rt_ast. Recorded as a deliberate subtraction in
// `conformance_drift_test.dart`.
/// SCD35: a method torn off a bridged instance must be usable wherever a
/// function is expected.
///
/// The reproduction is one line of idiomatic Dart:
///
/// ```dart
/// final seen = <int>[]; stream.listen(seen.add);
/// ```
///
/// `seen.add` tears off a method from a bridged `List`, producing a
/// `BridgedMethodCallable`. Sixty-two stdlib bridge files then cast their
/// callback argument to `InterpretedFunction`, which a bridged callable is not
/// a subtype of, so the cast threw — `type 'BridgedMethodCallable' is not a
/// subtype of type 'InterpretedFunction?'`. Adapters that guarded with
/// `is! InterpretedFunction` instead reported `requires a Function`, which is
/// the same defect wearing a more confusing message: the argument *is* a
/// function.
///
/// `Callable` is the supertype both kinds already implement, and two files
/// (`core/list.dart`'s Bug-95 fix, `collection/unmodifiable_list_view.dart`)
/// had converged on it independently. The fix finishes that job across the
/// stdlib rather than adding a third case at each site.
///
/// ## Every case here is the BARE tear-off, on purpose
///
/// The SCC11 tests that first hit this worked around it by wrapping —
/// `stream.listen((v) => seen.add(v))` — and a wrapped call passes just as
/// well with the defect present as without it. An assertion written that way
/// measures nothing. The wrapped form appears exactly once below, labelled as
/// a control, to show the workaround still works and is no longer needed.
///
/// F-SCD35-9 is the ratchet: the surface of this bug grew with the bridge
/// corpus, because every newly bridged member is another tear-off and every
/// newly written adapter is another chance to narrow to `InterpretedFunction`.
/// A behavioural test covers the members it names; the scan covers the ones
/// nobody has written yet.
///
/// ## The generated half — F-SCD35-13 and F-SCD35-14
///
/// F-SCD35-9 scans `stdlib/` in the two interpreter trees. Those are the
/// HAND-WRITTEN adapters, and they are only part of the surface: the generator
/// emits a callback call for every bridged member that takes one, across 207
/// `.b.dart` files in this repository. One wrong template there multiplies.
///
/// The generator has been right for months — it emits
/// `D4.callInterpreterCallback`, which dispatches on `Callable` — and 201 of
/// the 207 files show it. The remaining six were generated on 2026-02-07,
/// before the generator carried a version stamp at all, and still read
/// `(xRaw as InterpretedFunction).call(...)`. They are `tom_d4rt_dcli`'s three
/// library bridges and `tom_dcli_exec`'s identical three.
///
/// They are recorded as DEBT WITH A COUNT, not exempted by path. The count is
/// what lets F-SCD35-14 fail in both directions: a regeneration that used a
/// generator still emitting the narrowing would make the number grow, and a
/// regeneration that fixed the file would make it zero — which is good news
/// and has to be recorded, or the entry stops describing debt and starts
/// granting permission. The remedy is a REGENERATION of those two packages,
/// not an edit — a `.b.dart` says "do not edit" on its first line — and it is
/// blocked on a generator/analyzer resolution rather than on anybody's time.
///
/// EACH OF THE TWO HAS BEEN SEEN TO FAIL:
///
///   | Injected fault                                        | Fires  |
///   | ----------------------------------------------------- | ------ |
///   | a narrowing added to a clean generated bridge          | 13     |
///   | a recorded count changed so it no longer matches disk  | 14     |
///   | the repo root pointed somewhere with no `.b.dart`      | 13, 14 |
///
/// The third row is the anti-vacuity check doing its job: both cases are
/// emptiness assertions over a walk, and a walk that found no generated
/// bridges finds no narrowings either.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

const _libUri = 'package:scd35/scd35.dart';

/// A bridged class with a method that takes a callback, so the "passed to a
/// bridged-function parameter" half does not depend on which stdlib member
/// happens to be wired up today.
class Relay {
  Relay();
  final List<Object?> received = [];
}

D4rt _interpreter() {
  final interpreter = D4rt();
  interpreter.registerBridgedClass(
    BridgedClass(
      nativeType: Relay,
      name: 'Relay',
      constructors: {'': (visitor, positional, named) => Relay()},
      methods: {
        // Takes a callback and invokes it. The adapter accepts any Callable,
        // which is the contract this todo establishes for bridge authors.
        'pump': (visitor, target, positional, named, typeArgs) {
          final callback = positional[0] as Callable;
          for (final v in [1, 2, 3]) {
            callback.call(visitor, [v], const {});
          }
          return null;
        },
      },
      getters: {'received': (visitor, target) => (target as Relay).received},
    ),
    _libUri,
    sourceUri: _libUri,
  );
  return interpreter;
}

/// Runs [source] and returns its result, awaiting it when the script is async.
Future<Object?> _run(String source, {bool withRelay = false}) async {
  final interpreter = withRelay ? _interpreter() : D4rt();
  final result = interpreter.execute(
    source: withRelay ? "import '$_libUri';\n\n$source" : source,
  );
  return result is Future ? await result : result;
}

void main() {
  group('SCD35: a bridged tear-off is accepted wherever a function is', () {
    group('passed to a bridged-function parameter', () {
      test('F-SCD35-1: `stream.listen(seen.add)` — the reported case '
          '[2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final seen = <int>[];
  await Stream.fromIterable([1, 2, 3]).listen(seen.add).asFuture();
  return seen.join(',');
}
'''),
          '1,2,3',
        );
      });

      test('F-SCD35-2: `future.then(seen.add)` [2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final seen = <int>[];
  await Future.value(7).then(seen.add);
  return seen.join(',');
}
'''),
          '7',
        );
      });

      test('F-SCD35-3: `stream.map(buffer.write)` [2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final b = StringBuffer();
  await Stream.fromIterable([1, 2]).map(b.write).toList();
  return b.toString();
}
'''),
          '12',
        );
      });

      test('F-SCD35-4: `stream.where(seen.contains)` [2026-09-12]', () async {
        expect(
          await _run('''
main() async {
  final allowed = <int>{1, 3};
  final r = await Stream.fromIterable([1, 2, 3]).where(allowed.contains).toList();
  return r.join(',');
}
'''),
          '1,3',
        );
      });

      test('F-SCD35-5: a tear-off reaches a bridged method on a class the '
          'stdlib knows nothing about [2026-09-12]', () async {
        // Independent of which stdlib members happen to be wired up: this is
        // the contract a bridge author writing `as Callable` gets.
        expect(
          await _run('''
main() {
  final seen = <int>[];
  Relay().pump(seen.add);
  return seen.join(',');
}
''', withRelay: true),
          '1,2,3',
        );
      });
    });

    group('passed to an interpreted-function parameter', () {
      test('F-SCD35-6: a declared `void Function(int)` parameter '
          '[2026-09-12]', () async {
        expect(
          await _run('''
void apply(void Function(int) f) {
  f(1);
  f(2);
}

main() {
  final seen = <int>[];
  apply(seen.add);
  return seen.join(',');
}
'''),
          '1,2',
        );
      });

      test(
        'F-SCD35-7: stored in a typed local, then called [2026-09-12]',
        () async {
          expect(
            await _run('''
main() {
  final seen = <int>[];
  void Function(int) f = seen.add;
  f(9);
  return seen.join(',');
}
'''),
            '9',
          );
        },
      );
    });

    group('error handlers, where the widening had to make a choice', () {
      // `errorHandlerArgs` decides whether to hand a handler the stack trace by
      // reading `maxPositionalArity`, which only an interpreted function can
      // answer. Widening its parameter to `Callable` meant deciding what a
      // bridged callable gets. These three cases pin that decision.
      const controller = """
  final got = <Object?>[];
  final c = StreamController();
  c.addError(StateError('x'));
  c.close();
""";

      test('F-SCD35-10: an interpreted `(e, st)` handler still receives the '
          'trace [2026-09-12]', () async {
        // The regression guard on the introspection. Losing this would make
        // every two-parameter error handler silently trace-less.
        expect(
          await _run("""
main() async {
$controller  c.stream.listen((v) {}, onError: (e, st) {
    got.add(st == null ? 'no-trace' : 'trace');
  });
  await Future.delayed(Duration(milliseconds: 50));
  return got.join(',');
}
"""),
          'trace',
        );
      });

      test('F-SCD35-11: an interpreted `(e)` handler still receives one '
          'argument [2026-09-12]', () async {
        expect(
          await _run("""
main() async {
$controller  c.stream.listen((v) {}, onError: (e) { got.add('one'); });
  await Future.delayed(Duration(milliseconds: 50));
  return got.join(',');
}
"""),
          'one',
        );
      });

      test('F-SCD35-12: a bridged tear-off as `onError` is called with the '
          'error alone [2026-09-12]', () async {
        // A bridged callable carries no parameter metadata to introspect --
        // `BridgedMethodCallable.arity` is a hardcoded 0 because the adapter
        // validates arity itself. The single-argument form is chosen because
        // `(error)` is the shape every SDK error handler accepts, whereas
        // passing a second argument to a one-parameter tear-off such as
        // `got.add` fails inside the adapter.
        expect(
          await _run("""
main() async {
$controller  c.stream.listen((v) {}, onError: got.add);
  await Future.delayed(Duration(milliseconds: 50));
  return got.length;
}
"""),
          1,
        );
      });
    });

    test(
      'F-SCD35-8: CONTROL — the wrapped form still works [2026-09-12]',
      () async {
        // The SCC11 workaround. It passed before the fix too, which is exactly
        // why no other case in this file is written this way.
        expect(
          await _run('''
main() async {
  final seen = <int>[];
  await Stream.fromIterable([1, 2, 3]).listen((v) => seen.add(v)).asFuture();
  return seen.join(',');
}
'''),
          '1,2,3',
        );
      },
    );
  });
}
