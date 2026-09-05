import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'interpreter_test.dart' show execute, executeAsync;

/// SCC27 — an error that leaves `execute()` keeps its type, so a host `catch`
/// clause can name what a script raised.
///
/// `execute()` ends in a catch-all. Everything it did not recognise came back
/// out as `RuntimeD4rtException('Unexpected error: $e')`, and that message
/// asserts an interpreter bug — right for a stray internal failure, wrong for
/// every failure a script legitimately produces. A host calling
/// `execute(source: 'main() => int.parse("zz");')` read
/// `Unexpected error: FormatException: ...`, so `on FormatException` at the
/// **call site** could not match, even though `on FormatException` **inside**
/// the same script could. The boundary made a script's own errors less
/// catchable the moment they crossed it.
///
/// **The asymmetry was the bug, not the wrapping.** SCB10 had already carved
/// four types out of the catch-all — `AssertionError`, `TypeError`,
/// `NoSuchMethodError`, `RangeError` — because without the carve-out it would
/// have regressed the host-visible text for a failing `assert`. That left a
/// boundary a reader could not predict: four types escaped, everything else was
/// relabelled. The carve-out predicate is gone; the rule that replaces it is
/// stated once and holds for every type.
///
/// **The rule.** Anything that is an `Error` or an `Exception` escapes as
/// itself. Two things do not: a thrown value that is neither (nothing in the
/// SDK's vocabulary describes it, so the host gets a diagnostic instead of a
/// bare `toString()`), and the interpreter's own control-flow signals — a
/// `ReturnException` or `BreakException` reaching the host means the
/// interpreter lost track of a jump, which *is* an interpreter bug and is the
/// case the "Unexpected error" label was written for.
///
/// **Why the message prefix was the wrong diagnostic.** The argument for
/// wrapping was that a caller should be told when they hit an interpreter bug.
/// But the prefix cannot distinguish the two cases it is applied to, and the
/// stack trace already can: an internal fault shows d4rt frames all the way
/// down, a script's `FormatException` shows the bridge that raised it. Keeping
/// the type costs the host nothing and buys it a `catch` clause.
void main() {
  group('SCC27: errors keep their type across the host boundary', () {
    // ------------------------------------------------------------------
    // Errors raised by a NATIVE callee. These are the ones the SCB10
    // carve-out deliberately did not cover.

    test('F-SCC27-1: a FormatException from a native callee reaches the host '
        'as a FormatException [2026-09-05]', () {
      expect(
        () => execute('main() => int.parse("zz");'),
        throwsA(isA<FormatException>()),
      );
    });

    test('F-SCC27-2: a StateError from a native callee reaches the host as a '
        'StateError [2026-09-05]', () {
      expect(
        () => execute('main() { var l = []; return l.first; }'),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('No element'),
          ),
        ),
      );
    });

    test('F-SCC27-3: an ArgumentError from a native callee reaches the host as '
        'an ArgumentError [2026-09-05]', () {
      expect(
        () => execute('main() { var l = [1, 2]; return l.sublist(0, 9); }'),
        throwsA(isA<ArgumentError>()),
      );
    });

    // ------------------------------------------------------------------
    // Errors the INTERPRETER raises itself. SCB10 already let these four
    // through; the cases stay so that removing its predicate cannot regress
    // them.

    test('F-SCC27-4: the four types SCB10 carved out still reach the host '
        'unwrapped [2026-09-05]', () {
      expect(
        () => execute('main() { assert(1 == 2, "boom"); }'),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => execute('main() { var l = [1]; return l[9]; }'),
        throwsA(isA<RangeError>()),
      );
      expect(
        () => execute('main() { dynamic x = 1; return x as String; }'),
        throwsA(isA<TypeError>()),
      );
      expect(
        () => execute('main() { dynamic x = 1; return x.wibble(); }'),
        throwsA(isA<NoSuchMethodError>()),
      );
    });

    // ------------------------------------------------------------------
    // The contrast that made this a bug: the same failure, caught two ways.

    test('F-SCC27-5: the type a script can catch is the type the host gets '
        '[2026-09-05]', () {
      // Inside the script the type has always been visible — F-SCB10-17 pins
      // that. Asserting both halves against one program is what makes the
      // boundary's fidelity checkable rather than merely claimed.
      const source = '''
        main(List<String> args) {
          if (args.isEmpty) {
            try {
              int.parse("zz");
            } on FormatException {
              return "caught-inside";
            }
          }
          return int.parse("zz");
        }
      ''';
      expect(execute(source), 'caught-inside');
      // `args` is main's *positional argument list*, so the argv list has to be
      // its single element. Passing `['rethrow']` bound the String `'rethrow'`
      // to `List<String> args` — which reached the intended branch only because
      // `String` also has an `isEmpty`.
      expect(
        () => execute(
          source,
          args: [
            ['rethrow'],
          ],
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('F-SCC27-6: a user-defined exception class reaches the host as its '
        'own interpreted type [2026-09-05]', () {
      // An interpreted `throw` never reached the catch-all — it arrives as an
      // InternalInterpreterD4rtException and is unwrapped one clause earlier.
      // The case is here because a host reading the code cannot see that, and
      // would reasonably expect this to be the first thing SCC27 broke.
      expect(
        () => execute('''
          class BoomException implements Exception {
            final String why;
            BoomException(this.why);
          }
          main() { throw BoomException("no"); }
        '''),
        throwsA(
          isA<InterpretedInstance>().having(
            (e) => e.klass.name,
            'class',
            'BoomException',
          ),
        ),
      );
    });

    // ------------------------------------------------------------------
    // What still gets relabelled.

    test('F-SCC27-7: a native callee throwing a non-Error, non-Exception value '
        'is still reported as an unexpected error [2026-09-05]', () {
      // The host has no type to catch here, so a bare `toString()` would be
      // the whole diagnostic. The prefix earns its place in exactly this case.
      final d4rt = D4rt()..setDebug(false);
      d4rt.registerBridgedClass(
        BridgedClass(
          nativeType: _Detonator,
          name: 'Detonator',
          constructors: {'': (_, _, _) => _Detonator()},
          methods: {'boom': (_, _, _, _, _) => throw 'not-an-exception'},
        ),
        'package:scc27/detonator.dart',
        sourceUri: 'package:scc27/detonator.dart',
      );
      expect(
        () => d4rt.execute(
          library: 'package:test/main.dart',
          sources: {
            'package:test/main.dart': '''
              import 'package:scc27/detonator.dart';
              main() => Detonator().boom();
            ''',
          },
        ),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains('Unexpected error: not-an-exception'),
          ),
        ),
      );
    });

    test('F-SCC27-8: an escaped control-flow signal is classified as an '
        'interpreter fault [2026-09-05]', () {
      // These four exist to unwind the interpreter's own stack. One reaching a
      // host means a jump was lost, which is the failure the "Unexpected
      // error" wording actually describes.
      expect(isInterpreterControlFlowSignal(ReturnException(null)), isTrue);
      expect(isInterpreterControlFlowSignal(BreakException(null)), isTrue);
      expect(isInterpreterControlFlowSignal(ContinueException(null)), isTrue);
      expect(
        isInterpreterControlFlowSignal(const ContinueSwitchLabel()),
        isTrue,
      );

      expect(isInterpreterControlFlowSignal(FormatException('x')), isFalse);
      expect(isInterpreterControlFlowSignal(StateError('x')), isFalse);
      expect(
        isInterpreterControlFlowSignal(RuntimeD4rtException('x')),
        isFalse,
      );
    });

    // ------------------------------------------------------------------
    // The async path has its own catch-all.

    test('F-SCC27-9: an error from an async main reaches the host as itself '
        '[2026-09-05]', () async {
      await expectLater(
        executeAsync('main() async => int.parse("zz");'),
        throwsA(isA<FormatException>()),
      );
    });
  });
}

/// Stand-in native type for F-SCC27-7. Its only job is to throw a value that
/// is neither `Error` nor `Exception` from inside a bridged method.
class _Detonator {}
