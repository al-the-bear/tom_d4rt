import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCC31 — an undefined name cannot be caught by interpreted code.
///
/// Reading a name that resolves to nothing raised a plain
/// `RuntimeD4rtException`, and a bare `catch (e)` in the script caught it like
/// any other runtime condition. Real Dart never reaches that point: an
/// undefined identifier is a *compile-time* error, so the program does not run
/// and no handler can exist to see it. D4rt was therefore more permissive than
/// Dart in the one direction that hides bugs — a typo did not fail, it took
/// whichever branch the handler wrote and the script carried on with a value
/// the author never intended.
///
/// **The fix is a type, not a resolver.** The honest fix is to resolve names
/// before execution and reject the program, which is a project rather than an
/// afternoon (recorded as SCD95). What lands here is the cheap half that
/// removes the bug-swallowing: the failure is raised as
/// [UndefinedNameD4rtException], and both catch-dispatch sites decline to match
/// any clause against it, so it unwinds past every handler to the host.
///
/// **Two dispatch sites, and the second one is the surprise.**
/// `visitTryStatement` does proper `on T` matching, so a guard there is the
/// obvious half. But an `async` body takes an entirely different path —
/// `_handleAsyncError` in `callable.dart` — which picks
/// `catchClauses.first` with *no type matching at all*. Before this change an
/// undefined name inside an `async` function was swallowed even by a clause as
/// narrow as `on FormatException`, which is why the async cases below are not
/// redundant with the sync ones.
///
/// **`finally` still runs.** The property wanted is that no *catch clause* can
/// claim the error, not that cleanup is skipped. The guard therefore empties
/// the clause list rather than short-circuiting the whole block, so the finally
/// block executes on the way out and the error still propagates.
///
/// WHAT THIS COPY MEASURES, AND WHAT IT DELIBERATELY OMITS.
///
/// This is the `tom_d4rt_exec` port of `tom_d4rt`'s suite of the same name. It
/// runs the same scripts through the analyzer-free interpreter, so it says
/// whether the *published* `tom_d4rt_ast` (DGUC6) carries the guard — which is
/// the one thing the reference suite cannot tell you.
///
/// The twin's last group (F-SCC31-17/18) is **not** ported. Those two cases scan
/// the sources of every mirrored tree from one process, so they assert a
/// property of the repository rather than of the interpreter under test. A
/// second copy would re-derive the same verdict from the same files: a dropped
/// guard would turn two suites red for one cause, and the extra red says
/// nothing the first did not. The scan stays where it belongs, in `tom_d4rt`.
/// The omission is recorded in `conformance_drift_test.dart`'s
/// `_divergentBaseline`, so it is a declared difference rather than a silent
/// one — same treatment `scc32_bridged_value_key_test.dart` got.

void main() {
  /// Runs [source] and returns the exception it threw, failing the test if it
  /// returned normally.
  ///
  /// Every case here asserts a *throw*, so the assertion that matters is the
  /// same in all of them; returning the error keeps each test to the part that
  /// differs.
  Object runExpectingThrow(String source) {
    try {
      final result = execute(source);
      fail('Expected a throw, got: $result');
    } catch (e) {
      return e;
    }
  }

  group('SCC31: an undefined name escapes every interpreted catch', () {
    test('F-SCC31-1: a bare `catch (e)` does not catch it [2026-09-05]', () {
      final e = runExpectingThrow('''
        main() {
          try {
            return totallyUndefinedThing;
          } catch (e) {
            return 'swallowed';
          }
        }
      ''');
      expect(e, isA<UndefinedNameD4rtException>());
      expect((e as UndefinedNameD4rtException).name, 'totallyUndefinedThing');
    });

    test('F-SCC31-2: `on Object` does not catch it [2026-09-05]', () {
      final e = runExpectingThrow('''
        main() {
          try {
            return totallyUndefinedThing;
          } on Object catch (e) {
            return 'swallowed';
          }
        }
      ''');
      expect(e, isA<UndefinedNameD4rtException>());
    });

    test('F-SCC31-3: `on Error` does not catch it [2026-09-05]', () {
      final e = runExpectingThrow('''
        main() {
          try {
            return totallyUndefinedThing;
          } on Error catch (e) {
            return 'swallowed';
          }
        }
      ''');
      expect(e, isA<UndefinedNameD4rtException>());
    });

    test('F-SCC31-4: `on Exception` does not catch it [2026-09-05]', () {
      final e = runExpectingThrow('''
        main() {
          try {
            return totallyUndefinedThing;
          } on Exception catch (e) {
            return 'swallowed';
          }
        }
      ''');
      expect(e, isA<UndefinedNameD4rtException>());
    });

    test('F-SCC31-5: an outer catch cannot claim it either [2026-09-05]', () {
      // The escape is not "past one frame" — it is all the way out. A handler
      // two levels up is as unable to see it as the immediately enclosing one.
      final e = runExpectingThrow('''
        main() {
          try {
            try {
              return totallyUndefinedThing;
            } catch (e) {
              return 'inner';
            }
          } catch (e) {
            return 'outer';
          }
        }
      ''');
      expect(e, isA<UndefinedNameD4rtException>());
    });

    test('F-SCC31-6: a catch in the calling function cannot claim it '
        '[2026-09-05]', () {
      final e = runExpectingThrow('''
        String inner() => totallyUndefinedThing;
        main() {
          try {
            return inner();
          } catch (e) {
            return 'swallowed';
          }
        }
      ''');
      expect(e, isA<UndefinedNameD4rtException>());
    });

    test('F-SCC31-7: an undefined name used as a call target escapes '
        '[2026-09-05]', () {
      // The raise site for an invocation differs from the one for a plain read,
      // and both have to be converted for the guard to mean anything.
      final e = runExpectingThrow('''
        main() {
          try {
            return totallyUndefinedFunction(1, 2);
          } catch (e) {
            return 'swallowed';
          }
        }
      ''');
      expect(e, isA<UndefinedNameD4rtException>());
      expect(
        (e as UndefinedNameD4rtException).name,
        'totallyUndefinedFunction',
      );
    });
  });

  group('SCC31: the async path escapes too', () {
    test('F-SCC31-8: a bare `catch (e)` in an async body does not catch it '
        '[2026-09-05]', () async {
      await expectLater(
        () async =>
            await (execute('''
          Future<String> go() async {
            try {
              await Future.value(1);
              return totallyUndefinedThing;
            } catch (e) {
              return 'swallowed';
            }
          }
          main() async => await go();
        ''')
                as Future),
        throwsA(isA<UndefinedNameD4rtException>()),
      );
    });

    test('F-SCC31-9: a typed clause in an async body does not catch it '
        '[2026-09-05]', () async {
      // `_handleAsyncError` takes `catchClauses.first` without asking what type
      // it names, so before SCC31 this `on FormatException` swallowed a name
      // error it could never legitimately match. The guard is what stops it.
      await expectLater(
        () async =>
            await (execute('''
          Future<String> go() async {
            try {
              await Future.value(1);
              return totallyUndefinedThing;
            } on FormatException catch (e) {
              return 'swallowed';
            }
          }
          main() async => await go();
        ''')
                as Future),
        throwsA(isA<UndefinedNameD4rtException>()),
      );
    });
  });

  group('SCC31: what deliberately still works', () {
    test('F-SCC31-10: a finally block still runs on the way out '
        '[2026-09-05]', () {
      // Emptying the clause list, rather than skipping the whole catch/finally
      // block, is what keeps this true. The list is owned by the host and
      // passed in, so what the finally wrote is readable after the throw.
      final ran = <String>[];
      expect(
        () => execute(
          '''
          main(List log) {
            try {
              return totallyUndefinedThing;
            } finally {
              log.add('cleanup');
            }
          }
        ''',
          args: [ran],
        ),
        throwsA(isA<UndefinedNameD4rtException>()),
      );
      expect(ran, ['cleanup'], reason: 'the finally block must still run');
    });

    test('F-SCC31-11: an ordinary error in the same try is still catchable '
        '[2026-09-05]', () {
      // The guard keys on one type. Everything else dispatches exactly as
      // before — this is the case that fails if the check is written too wide.
      expect(
        execute('''
        main() {
          try {
            throw FormatException('boom');
          } on FormatException catch (e) {
            return 'caught';
          }
        }
      '''),
        'caught',
      );
    });

    test('F-SCC31-12: an undefined *member* stays catchable [2026-09-05]', () {
      // SCC28's `UndefinedMemberD4rtException` is a sibling failure and a
      // sibling subtype, but it is NOT covered by this change: `x.nope` on a
      // real object is a `NoSuchMethodError` at runtime in Dart too, so
      // catching it is correct behaviour rather than bug-swallowing.
      expect(
        execute('''
        main() {
          try {
            return 'abc'.noSuchMemberHere();
          } catch (e) {
            return 'caught';
          }
        }
      '''),
        'caught',
      );
    });

    test('F-SCC31-13: a deliberately-unbridged name still carries its reason '
        '[2026-09-05]', () {
      // SCB30 appends "why this is absent" to the message for names the stdlib
      // does not bridge on purpose. Routing every raise through one factory is
      // what keeps the message and the new type together; this pins that the
      // reason survived the conversion.
      final e = runExpectingThrow('''
        main() {
          try {
            return Expando();
          } catch (e) {
            return 'swallowed';
          }
        }
      ''');
      expect(e, isA<UndefinedNameD4rtException>());
      expect(e.toString(), contains('Undefined variable: Expando'));
      expect(e.toString(), contains('not bridged:'));
      expect(e.toString(), contains('doc/d4rt_limitations.md'));
    });

    test('F-SCC31-14: it is still a RuntimeD4rtException for host code '
        '[2026-09-05]', () {
      // Subtyping is load-bearing, not cosmetic: `Environment.get` throws on
      // every miss and is called speculatively across the interpreter and the
      // module loader, each caller catching `RuntimeD4rtException` to try the
      // next strategy. A sibling type would have turned those fallbacks into
      // hard failures.
      final e = runExpectingThrow('main() => totallyUndefinedThing;');
      expect(e, isA<RuntimeD4rtException>());
      expect(e, isA<D4rtException>());
    });

    test('F-SCC31-15: host code around execute() can still catch it '
        '[2026-09-05]', () {
      // The change makes *interpreted* clauses skip; it says nothing about the
      // host. The REPLs (dcli / d4rt / tom) report a typo at the prompt by
      // catching around `eval()`, and that still works.
      var reported = false;
      try {
        execute('main() => totallyUndefinedThing;');
      } catch (_) {
        reported = true;
      }
      expect(reported, isTrue);
    });
  });

  group('SCC31: extension resolution still uses the signal', () {
    test('F-SCC31-16: `on <unknown type>` in an extension is a miss, not a '
        'crash [2026-09-05]', () {
      // The extension-resolution path used to branch on
      // `e.message.contains("Undefined variable: $onTypeName")` — a formatted
      // diagnostic as a branch condition, the exact pattern SCC28 removed for
      // members. It now asks `e is UndefinedNameD4rtException && e.name == …`.
      // An extension declared on a bridged core type still resolves, which is
      // what that branch exists to make possible.
      expect(
        execute('''
        extension on String {
          String shout() => this + '!';
        }
        main() => 'hi'.shout();
      '''),
        'hi!',
      );
    });
  });
}
