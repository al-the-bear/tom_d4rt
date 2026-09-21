import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart' show UndefinedNameD4rtException;
import 'interpreter_test.dart' show executeAsync;

/// SCC12 — `await` inside a `finally` block, and the once-only execution of a
/// `finally` whose protected region suspends.
///
/// Found by the stdlib member-diff oracle rather than by a bug report, which is
/// the part worth recording: the audit tool needs to acquire a live resource,
/// read one member off it and release it again, so every one of its `dart:io`
/// recipes is shaped `try { read } finally { await release; }`. The first run
/// with a teardown clause wedged at 100 % CPU with no output for eight minutes.
///
/// The interpreter drives `await` by *replay*: `visitAwaitExpression` returns an
/// `AsyncSuspensionRequest` sentinel instead of blocking, every statement visitor
/// propagates it upwards as its own value, and the async driver awaits the future
/// and then re-executes the function body, feeding each already-completed `await`
/// its recorded result. A visitor that discards a sub-visit's value therefore
/// does not merely lose a value — it swallows the suspension, the driver never
/// learns there is a future to wait for, and the program never completes.
///
/// `visitTryStatement` discarded exactly one such value: the finally block's.
/// `await` in a try body worked (its value becomes the statement's value) and
/// `await` in a catch body worked (likewise), so the defect was invisible from
/// every direction except the one the oracle happened to need.
///
/// The second half is subtler and was found by writing the first test rather than
/// by observing a failure. When the *try body* suspends, the try statement must
/// return the suspension **without running the finally block**: the protected
/// region has not finished, it is going to be replayed, and a finally that runs
/// on the suspending pass runs again on the resuming one. Native Dart runs a
/// finally exactly once, so a teardown that closes a socket twice — or a counter
/// that increments twice — is a behavioural difference a script can see.
void main() {
  /// Fails fast and with a legible reason instead of hanging until the suite's
  /// own timeout: the failure mode under test is "never completes", and a test
  /// that reports it as a 30-second timeout on an unnamed future is much harder
  /// to read than one that says the program did not answer.
  Future<Object?> run(String source) => executeAsync(source).timeout(
    const Duration(seconds: 10),
    onTimeout: () => fail(
      'the interpreted program never completed — the '
      'suspension raised inside try/finally was swallowed',
    ),
  );

  group('SCC12: await inside finally', () {
    test('F-SCC12-3: a finally block may await [2026-09-04]', () async {
      // The reported shape, reduced: no dart:io, no bridge, just a suspension
      // raised from a finally block. Before the fix this never completed.
      final result = await run('''
        main() async {
          var log = [];
          try {
            log.add('body');
          } finally {
            await Future.value(0);
            log.add('finally');
          }
          return log;
        }
      ''');
      expect(result, orderedEquals(['body', 'finally']));
    });

    test(
      'F-SCC12-4: a value awaited in finally is the awaited value [2026-09-04]',
      () async {
        // Propagating the suspension is not enough on its own — the replay has to
        // feed the recorded result back into the same `await`, so assert on the
        // value rather than only on completion.
        final result = await run('''
        main() async {
          var seen;
          try {
            seen = 1;
          } finally {
            seen = await Future.value(9);
          }
          return seen;
        }
      ''');
        expect(result, 9);
      },
    );

    test(
      'F-SCC12-5: an awaiting finally still runs when the try body throws [2026-09-04]',
      () async {
        // The interesting case for a teardown clause: the probes that matter are
        // the ones that throw, and a release that only runs on the happy path
        // leaks exactly when it is most needed.
        final result = await run('''
        main() async {
          var log = [];
          try {
            try {
              throw 'boom';
            } finally {
              await Future.value(0);
              log.add('released');
            }
          } catch (e) {
            log.add('caught:\$e');
          }
          return log;
        }
      ''');
        expect(result, orderedEquals(['released', 'caught:boom']));
      },
    );

    test(
      'F-SCC12-6: an awaiting finally still runs on the way out of a return [2026-09-04]',
      () async {
        final result = await run('''
        main() async {
          var log = [];
          Future<dynamic> inner() async {
            try {
              return 'value';
            } finally {
              await Future.value(0);
              log.add('released');
            }
          }
          final v = await inner();
          log.add('got:\$v');
          return log;
        }
      ''');
        expect(result, orderedEquals(['released', 'got:value']));
      },
    );
  });

  group('SCC12: a finally runs once when its protected region suspends', () {
    test(
      'F-SCC12-7: a finally runs once when the try body awaits [2026-09-04]',
      () async {
        // The replay hazard. The try body suspends, so the whole try statement is
        // re-executed after the future completes; if the suspending pass also ran
        // the finally, the block runs twice and a teardown double-releases.
        final result = await run('''
        main() async {
          var count = 0;
          var value;
          try {
            value = await Future.value(3);
          } finally {
            count = count + 1;
          }
          return [value, count];
        }
      ''');
        expect(result, orderedEquals([3, 1]));
      },
    );

    test(
      'F-SCC12-8: a finally runs once when a catch body awaits [2026-09-04]',
      () async {
        final result = await run('''
        main() async {
          var count = 0;
          var value;
          try {
            throw 'boom';
          } catch (e) {
            value = await Future.value(4);
          } finally {
            count = count + 1;
          }
          return [value, count];
        }
      ''');
        expect(result, orderedEquals([4, 1]));
      },
    );

    test(
      'F-SCC12-9: a finally runs once when both the body and the finally await [2026-09-04]',
      () async {
        final result = await run('''
        main() async {
          var count = 0;
          var value;
          try {
            value = await Future.value(5);
          } finally {
            await Future.value(0);
            count = count + 1;
          }
          return [value, count];
        }
      ''');
        expect(result, orderedEquals([5, 1]));
      },
    );
  });

  /// The second defect the same investigation exposed, and the one that made the
  /// gap oracle's numbers wrong rather than merely making it hang.
  ///
  /// Inside an *async* function the interpreter does not run `visitTryStatement`
  /// at all: the state machine in `callable.dart` decomposes the try into
  /// statements so that any of them may suspend. Its error path looked for a
  /// handler exactly one level out, and when the try it found had a `finally` but
  /// no catch it jumped to the finally leaving the error in
  /// `AsyncExecutionState.currentError` — a field the main loop clears after
  /// every statement that completes normally. The first statement of the finally
  /// therefore erased the exception, and the enclosing `catch` never ran.
  ///
  /// The audit tool in `tool/stdlib_member_diff.dart` reads every candidate
  /// member as `try { probed = o.member; } finally { await o.close(); }`, so for
  /// each of its async recipes a *missing* member was silently reported as
  /// present. That is the failure mode the whole three-bucket design exists to
  /// prevent, which is why these cases are pinned here.
  group('SCC12: an error passing through a finally reaches the enclosing catch', () {
    test(
      'F-SCC12-10: an async function propagates out of a try/finally with no catch [2026-09-04]',
      () async {
        // Nothing suspends inside the protected region, and the finally is
        // synchronous — the mechanism is the async state machine, not `await`.
        // The synchronous interpreter has always got this right, so a reader who
        // assumes the two paths agree would not look here.
        final result = await run('''
        main() async {
          var log = [];
          try {
            try {
              throw 'boom';
            } finally {
              log.add('released');
            }
          } catch (e) {
            log.add('caught:\$e');
          }
          await Future.value(0);
          return log;
        }
      ''');
        expect(result, orderedEquals(['released', 'caught:boom']));
      },
    );

    test(
      'F-SCC12-11: an empty finally does not swallow the error [2026-09-04]',
      () async {
        // An empty finally is not a handler. It used to be treated as one: the
        // machine jumped to a block with no statements, the state machine ran out
        // of nodes, and the function's Future never completed at all.
        final result = await run('''
        main() async {
          var log = [];
          try {
            try {
              throw 'boom';
            } finally {
            }
          } catch (e) {
            log.add('caught:\$e');
          }
          return log;
        }
      ''');
        expect(result, orderedEquals(['caught:boom']));
      },
    );

    test(
      'F-SCC12-12: a failed read throws out through an awaited teardown [2026-09-04]',
      () async {
        // The gap oracle's own shape, and the reason this defect corrupted a
        // measurement rather than merely hanging a tool: `probed` must never be
        // *returned*. While the error was being dropped, this program completed
        // normally with `null`, and the oracle read a missing member as present.
        //
        // The error here is raised by the interpreter itself (an unresolved
        // member), not by a `throw` statement — which is what the probes do, and
        // which travels a different path into the state machine than an explicit
        // throw does.
        await expectLater(
          executeAsync('''
          class Resource {
            var released = false;
            Future<void> close() async {
              await Future.value(0);
              released = true;
            }
          }
          Future<dynamic> main() async {
            final o = Resource();
            dynamic probed;
            try {
              probed = o.noSuchMember;
            } finally {
              await o.close();
            }
            return probed;
          }
        ''').timeout(const Duration(seconds: 10)),
          throwsA(
            predicate(
              (Object? e) => e.toString().contains('noSuchMember'),
              'an error naming the member that could not be read',
            ),
          ),
        );
      },
    );

    test(
      'F-SCC12-13: the awaited teardown runs before the failed read is caught [2026-09-04]',
      () async {
        // The other half of the oracle's shape: the teardown must still run, and
        // it must run *before* the error surfaces. Observed from inside the
        // script, because the release is only visible to the interpreter — the
        // ordering is the assertion, so a log rather than a flag.
        final result = await run('''
        class Resource {
          Future<void> close(List log) async {
            await Future.value(0);
            log.add('released');
          }
        }
        main() async {
          var log = [];
          final o = Resource();
          try {
            dynamic probed;
            try {
              probed = o.noSuchMember;
            } finally {
              await o.close(log);
            }
            log.add('returned:\$probed');
          } catch (e) {
            log.add('caught');
          }
          return log;
        }
      ''');
        expect(
          result,
          orderedEquals(['released', 'caught']),
          reason:
              'the teardown must run, and the read must not be treated as '
              'having succeeded',
        );
      },
    );
  });

  /// SCD40 — the held error is dropped when the `try` is the LAST thing in the
  /// function.
  ///
  /// SCC12 parked an uncaught error on `AsyncExecutionState.errorAfterFinally`
  /// so it would survive the finally block, and `_findNextSequentialNode`
  /// re-raises it when the block ends. That works whenever something follows
  /// the try — which is why F-SCC12-12 passes, and why this defect survived: it
  /// uses the assign-then-return shape, and every other case in this file has a
  /// statement after the try too.
  ///
  /// When the try/finally is the last thing in the function there is no next
  /// node, so the state machine's loop simply ends. Its terminal exits checked
  /// `returnAfterFinally` and `currentError` and never `errorAfterFinally`, so
  /// the held error was discarded and the function completed with `lastResult`
  /// — the finally block's last evaluated value.
  ///
  /// **It answers, and the answer is wrong**, which is what makes it worse than
  /// the hang SCC12 fixed. The shape is what a careful programmer writes:
  /// acquire, use, release in a finally.
  ///
  /// ## The preconditions are broader than first recorded
  ///
  /// `await` in the finally is NOT one of them — F-SCD40-7 uses a wholly
  /// synchronous finally and failed the same way. Nor is `return`-in-try:
  /// F-SCD40-6 uses a bare `throw`. What matters is: async function, an error
  /// in the try body, a non-empty finally, no catch, and nothing after the try.
  ///
  /// F-SCD40-2..5 and F-SCD40-10/11 are rows that were already correct. They
  /// are pinned because they are correct *for a different reason* — the error
  /// takes another path — and widening the hold is exactly the fix that would
  /// capture them too and change their answers.
  group('SCD40: an error held across a finally survives to the function end', () {
    /// Asserts the program throws something naming [fragment].
    Future<void> expectThrows(String source, String fragment) => expectLater(
      executeAsync(source).timeout(const Duration(seconds: 10)),
      throwsA(
        predicate(
          (Object? e) => e.toString().contains(fragment),
          'an error mentioning "$fragment"',
        ),
      ),
    );

    test('F-SCD40-1: `return <throwing>` in a try whose finally awaits '
        '[2026-09-12]', () async {
      // The reported reproduction. Before the fix this completed normally and
      // returned 42 — the value of the finally block's last expression.
      await expectThrows(r"""
        class Thing { Future<int> tidy() async { await Future.value(0); return 42; } }
        Future<dynamic> main() async {
          final o = Thing();
          try { return o.nonsenseXyz; } finally { await o.tidy(); }
        }
      """, 'nonsenseXyz');
    });

    test('F-SCD40-2: the same shape in a SYNC function still throws '
        '[2026-09-12]', () async {
      await expectThrows(r"""
        class Thing { int tidy() => 42; }
        main() {
          final o = Thing();
          try { return o.nonsenseXyz; } finally { o.tidy(); }
        }
      """, 'nonsenseXyz');
    });

    test('F-SCD40-3: an EMPTY finally still throws [2026-09-12]', () async {
      // Correct for a different reason: `_handleAsyncError` walks outward past
      // a try with no catch and an empty finally, so the error never enters the
      // hold at all. That is SCC12's guard, and this case is here to notice if
      // the SCD40 fix disturbs it.
      await expectThrows(
        r"Future<dynamic> main() async { try { return (1).nonsenseXyz; } finally { } }",
        'nonsenseXyz',
      );
    });

    test('F-SCD40-4: no try at all still throws [2026-09-12]', () async {
      await expectThrows(
        r"Future<dynamic> main() async { return (1).nonsenseXyz; }",
        'nonsenseXyz',
      );
    });

    test('F-SCD40-5: assign in the try and return after it still throws '
        '[2026-09-12]', () async {
      // The workaround shape the audit tool was forced into, and the shape
      // F-SCC12-12 already uses. Correct because the `return` after the try
      // gives the machine a next node, which is where the re-raise lives.
      await expectThrows(r"""
        class Thing { Future<int> tidy() async { await Future.value(0); return 42; } }
        Future<dynamic> main() async {
          final o = Thing();
          dynamic v;
          try { v = o.nonsenseXyz; } finally { await o.tidy(); }
          return v;
        }
      """, 'nonsenseXyz');
    });

    test('F-SCD40-6: a bare `throw` in a try whose finally awaits '
        '[2026-09-12]', () async {
      // Not a `return` and not a member-lookup failure: the defect is about ANY
      // error held across the finally, which the original framing did not
      // cover. Before the fix this returned 99.
      await expectThrows(
        r"Future<dynamic> main() async { try { throw StateError('boom'); } finally { await Future.value(99); } }",
        'boom',
      );
    });

    test('F-SCD40-7: a wholly SYNCHRONOUS finally in an async function '
        '[2026-09-12]', () async {
      // `await` in the finally is not a precondition. This one suspends nowhere
      // at all and failed identically, which is why the fix belongs at the
      // state machine's terminal exits rather than on the await path.
      await expectThrows(r"""
        Future<dynamic> main() async {
          int x = 0;
          try { throw StateError('boom'); } finally { x = 99; }
        }
      """, 'boom');
    });

    test('F-SCD40-8: a SUCCESSFUL return is not overwritten by the finally '
        '[2026-09-12]', () async {
      // The question the todo asked, and the reason its title is right: if the
      // finally's value could overwrite a successful return too, this would be
      // a much broader defect. It cannot — measured before the fix — and this
      // case exists so the fix does not make it one.
      expect(
        await run(r"""
          Future<dynamic> main() async {
            try { return 7; } finally { await Future.value(99); }
          }
        """),
        7,
      );
    });

    test('F-SCD40-9: a statement-level error, try last [2026-09-12]', () async {
      await expectThrows(
        r"Future<dynamic> main() async { try { (1).nonsenseXyz; } finally { await Future.value(99); } }",
        'nonsenseXyz',
      );
    });

    test(
      'F-SCD40-10: a catch still wins over the finally [2026-09-12]',
      () async {
        expect(
          await run(r"""
          Future<dynamic> main() async {
            try { throw StateError('boom'); }
            catch (e) { return 'caught'; }
            finally { await Future.value(99); }
          }
        """),
          'caught',
        );
      },
    );

    test(
      'F-SCD40-11: a statement after the try still throws [2026-09-12]',
      () async {
        // The path that already worked, and the one the fix must not disturb:
        // here `_findNextSequentialNode` has a next node, so the re-raise happens
        // in the loop rather than at its terminal exit.
        await expectThrows(r"""
        Future<dynamic> main() async {
          try { throw StateError('boom'); } finally { await Future.value(9); }
          return 'after';
        }
      """, 'boom');
      },
    );
  });

  /// SCD41 — the async path approximated two things `visitTryStatement` already
  /// decides properly, and both were observable from a script.
  ///
  /// **Which clause matches.** `_handleAsyncError` took
  /// `enclosingTry.catchClauses.first`, with a comment admitting it was
  /// "simplified". So in an async function `on StateError catch` ran for an
  /// `ArgumentError`, and a clause that must not match caught anyway — the same
  /// script behaving differently depending only on whether the enclosing
  /// function is `async`, which is the property that makes it easy to
  /// misdiagnose as a bridge problem. The synchronous path had already
  /// converged on one predicate in SCC20 (`on T` asks exactly what `x is T`
  /// asks); this extracts that decision so both paths call it.
  ///
  /// **Which try a `rethrow` targets.** The async path answered from
  /// `AsyncExecutionState.activeTryStatement`, a single mutable field, by
  /// testing whether it equalled the try found for the rethrow node. Any try
  /// that completed in between cleared the field, and the test then failed —
  /// so the error was re-offered to the SAME try, whose catch rethrew again.
  /// F-SCD41-7 is that shape and it **hung** rather than failing; the answer is
  /// now read from the AST, where it does not depend on what else has run.
  ///
  /// The controls are half the point. F-SCD41-4/5 and F-SCD41-8..11 were
  /// already correct, several of them *for a different reason* than the fixed
  /// cases, and they are what a careless widening of either rule would break.
  group('SCD41: async try/catch decides like the synchronous path', () {
    /// Asserts the program throws something naming [fragment].
    Future<void> expectThrows(String source, String fragment) => expectLater(
      executeAsync(source).timeout(const Duration(seconds: 10)),
      throwsA(
        predicate(
          (Object? e) => e.toString().contains(fragment),
          'an error mentioning "$fragment"',
        ),
      ),
    );

    test('F-SCD41-1: a SECOND typed clause matches when the first does not '
        '[2026-09-12]', () async {
      expect(
        await run(r"""
          Future<dynamic> main() async {
            try { throw ArgumentError('a'); }
            on StateError catch (e) { return 'StateError'; }
            on ArgumentError catch (e) { return 'ArgumentError'; }
          }
        """),
        'ArgumentError',
      );
    });

    test('F-SCD41-2: a clause that does not match does not catch '
        '[2026-09-12]', () async {
      // The dangerous half. Before the fix this returned 'caught': a script's
      // `on StateError` swallowed an ArgumentError that had to propagate, so
      // the error surfaced nowhere at all.
      await expectThrows(
        r"Future<dynamic> main() async { try { throw ArgumentError('a'); } "
            r"on StateError catch (e) { return 'caught'; } }",
        'a',
      );
    });

    test('F-SCD41-3: a bare `catch` after a non-matching typed clause '
        '[2026-09-12]', () async {
      expect(
        await run(r"""
          Future<dynamic> main() async {
            try { throw ArgumentError('a'); }
            on StateError catch (e) { return 'StateError'; }
            catch (e) { return 'bare'; }
          }
        """),
        'bare',
      );
    });

    test('F-SCD41-4: the first clause still wins when it genuinely matches '
        '[2026-09-12]', () async {
      // Correct before the fix too — by accident, because first-clause-always
      // happens to be right when the first clause is the right one.
      expect(
        await run(r"""
          Future<dynamic> main() async {
            try { throw StateError('s'); }
            on StateError catch (e) { return 'StateError'; }
            on ArgumentError catch (e) { return 'ArgumentError'; }
          }
        """),
        'StateError',
      );
    });

    test('F-SCD41-5: the SYNC path is unchanged [2026-09-12]', () async {
      // The reference the async path is being made to agree with. If a shared
      // predicate ever regresses, this is the case that says the damage is not
      // confined to async code.
      expect(
        await run(r"""
          main() {
            try { throw ArgumentError('a'); }
            on StateError catch (e) { return 'StateError'; }
            on ArgumentError catch (e) { return 'ArgumentError'; }
          }
        """),
        'ArgumentError',
      );
    });

    test('F-SCD41-6: `on Exception` matches a script class that implements it, '
        'in an async function [2026-09-12]', () async {
      // SCC20's property, which the async path could not have had while it was
      // choosing by position: matching goes through the same predicate as
      // `is`, so an interpreted class implementing Exception is matched.
      expect(
        await run(r"""
          class Mine implements Exception {}
          Future<dynamic> main() async {
            try { throw Mine(); }
            on StateError catch (e) { return 'StateError'; }
            on Exception catch (e) { return 'Exception'; }
          }
        """),
        'Exception',
      );
    });

    /// SCD168 named a case the eleven above do not reach: every one of them
    /// dispatches on an `Error` subclass or the `Exception` interface, so the
    /// whole group exercises one shape of `_valueHasType` — a bridged class
    /// against a bridged instance. `on String` is a different question. The
    /// clause type is a PRIMITIVE, the thrown value is a bridged exception, and
    /// nothing above would notice if the primitive branch answered `true` for
    /// everything the way `catchClauses.first` once did.
    test('F-SCD168-1: `on String` does not catch a FormatException in an '
        'async body [2026-09-15] (PASS)', () async {
      expect(
        await run(r"""
          Future<dynamic> main() async {
            try { throw FormatException('boom'); }
            on String catch (e) { return 'String'; }
            on FormatException catch (e) { return 'FormatException'; }
          }
        """),
        'FormatException',
      );
    });

    test('F-SCD168-2: a non-matching primitive clause alone does not swallow '
        '[2026-09-15] (PASS)', () async {
      // The dangerous half of F-SCD168-1, and the exact sentence SCD168 was
      // written around: with `catchClauses.first`, `on String` caught a
      // FormatException and the error surfaced nowhere.
      await expectThrows(
        r"Future<dynamic> main() async { try { throw FormatException('boom'); } "
            r"on String catch (e) { return 'swallowed'; } }",
        'boom',
      );
    });

    test('F-SCD168-3 (control): `on String` DOES catch a thrown String '
        '[2026-09-15] (PASS)', () async {
      // Without this, F-SCD168-1/2 are satisfied by a primitive branch that
      // answers `false` for everything — which would be a different bug with
      // the same test results.
      expect(
        await run(r"""
          Future<dynamic> main() async {
            try { throw 'plain'; }
            on String catch (e) { return 'String:$e'; }
            on FormatException catch (e) { return 'FormatException'; }
          }
        """),
        'String:plain',
      );
    });

    test('F-SCD168-4: the async and sync paths agree on the same program '
        '[2026-09-15] (PASS)', () async {
      // SCD168's framing: the defect was "the same script behaving differently
      // depending only on whether the enclosing function is `async`". That is
      // the property to assert, rather than two separately-pinned answers.
      const body = r"""
            try { throw FormatException('boom'); }
            on String catch (e) { return 'String'; }
            on FormatException catch (e) { return 'FormatException'; }
      """;
      expect(
        await run('Future<dynamic> main() async {$body}'),
        await run('dynamic main() {$body}'),
      );
    });

    test('F-SCD41-7: a rethrow after a nested try ran inside the catch '
        '[2026-09-12]', () async {
      // Defect 2, and it HUNG rather than failing: the inner try/finally
      // cleared `activeTryStatement`, so the rethrow could not tell it should
      // skip the try it was already inside. The error was re-offered to that
      // same try, whose catch rethrew again.
      //
      // A synchronous spin is not interruptible by `run`'s timeout, so before
      // the fix this case wedged the whole suite rather than failing it. If it
      // ever regresses, expect a hang and reach for a wall-clock kill
      // (`perl -e 'alarm 25; exec @ARGV' dart test …`) rather than a longer
      // timeout.
      expect(
        await run(r"""
          Future<dynamic> main() async {
            var log = [];
            try {
              try { throw StateError('x'); }
              catch (e) {
                try { await Future.value(0); } finally { log.add('if'); }
                log.add('pre');
                rethrow;
              }
            } catch (e) { log.add('oc'); }
            return log;
          }
        """),
        orderedEquals(['if', 'pre', 'oc']),
      );
    });

    test('F-SCD41-8: a plain nested rethrow still reaches the outer catch '
        '[2026-09-12]', () async {
      expect(
        await run(r"""
          Future<dynamic> main() async {
            var log = [];
            try {
              try { throw StateError('x'); } catch (e) { log.add('ic'); rethrow; }
            } catch (e) { log.add('oc'); }
            return log;
          }
        """),
        orderedEquals(['ic', 'oc']),
      );
    });

    test('F-SCD41-9: a rethrow at each of three levels [2026-09-12]', () async {
      expect(
        await run(r"""
          Future<dynamic> main() async {
            var log = [];
            try {
              try {
                try { throw StateError('x'); } catch (e) { log.add('1'); rethrow; }
              } catch (e) { log.add('2'); rethrow; }
            } catch (e) { log.add('3'); }
            return log;
          }
        """),
        orderedEquals(['1', '2', '3']),
      );
    });

    test('F-SCD41-10: a rethrow with no outer handler leaves the function '
        '[2026-09-12]', () async {
      await expectThrows(
        r"Future<dynamic> main() async { try { throw StateError('escape-me'); } "
            r"catch (e) { rethrow; } }",
        'escape-me',
      );
    });

    test('F-SCD41-11: a try nested inside a catch handles its own errors '
        '[2026-09-12]', () async {
      // The boundary the structural rethrow rule must respect: a try written
      // INSIDE a catch block is a real handler for what happens in it, and must
      // not be skipped the way the rethrow's own try is.
      expect(
        await run(r"""
          Future<dynamic> main() async {
            var log = [];
            try { throw StateError('a'); }
            catch (e) {
              log.add('oc');
              try { throw StateError('b'); } catch (e2) { log.add('ic'); }
            }
            return log;
          }
        """),
        orderedEquals(['oc', 'ic']),
      );
    });
  });

  /// SCD42 — an `await` in argument position lost the enclosing environment,
  /// but only inside a bare block.
  ///
  /// The reported shape was `log.add(await Future.value(1))` reporting
  /// `Undefined variable: log` for a local plainly in scope. At the top level
  /// of a function body it works, and it works inside an `if`, `for` or
  /// `while` body too — which is what made it look like an unrelated scoping
  /// bug each of the three times SCC12 hit it.
  ///
  /// The distinguishing condition is a BARE block. The async state machine
  /// flattens the statement tree: it steps into if/for/while bodies and runs
  /// their statements in the function's own frame, so declarations there are
  /// visible after a resumption. A standalone `{ … }` had no such handler, so
  /// it went to `visitBlock`, which opens a CHILD environment and runs the
  /// statements synchronously. An `await` inside then suspended, the machine
  /// resumed at a statement *inside* the block, and that child environment was
  /// gone.
  ///
  /// The fix steps into a bare block like every sibling construct. It carries
  /// the same limitation those already have — block-scoped shadowing is not
  /// honoured in async code, because the machine flattens — and that is a
  /// smaller problem than a hard error on ordinary code.
  ///
  /// F-SCD42-5 is not decoration: before the fix that program returned `1`
  /// rather than `[1]`, so the bare block was also corrupting a value silently,
  /// not only failing loudly.
  group('SCD42: a bare block keeps its locals across an await', () {
    test('F-SCD42-1: the reported shape — `log.add(await …)` in a bare block '
        '[2026-09-12]', () async {
      expect(
        await run(r"""
          main() async {
            { var log = []; log.add(await Future.value(1)); return log; }
          }
        """),
        orderedEquals([1]),
      );
    });

    test('F-SCD42-2: two nested bare blocks [2026-09-12]', () async {
      expect(
        await run(r"""
          main() async {
            { { var log = []; log.add(await Future.value(1)); return log; } }
          }
        """),
        orderedEquals([1]),
      );
    });

    test('F-SCD42-3: the local need not appear in the argument list '
        '[2026-09-12]', () async {
      // It is the method TARGET that was lost, not anything in the arguments —
      // worth pinning, because the todo described this as "an await in argument
      // position loses the environment" and that framing points at the wrong
      // expression.
      expect(
        await run(r"""
          main() async {
            { var unused = 1; final l = []; l.add(await Future.value(9)); return l; }
          }
        """),
        orderedEquals([9]),
      );
    });

    test('F-SCD42-4: a top-level call with an awaited argument, in a bare '
        'block [2026-09-12]', () async {
      // Already worked: the callee is resolved globally, so no environment of
      // the block is needed to find it. Pinned as a control — it is the half of
      // the reported shape that was never broken.
      expect(
        await run(r"""
          f(a) => a;
          main() async { { var n = 1; return f(await Future.value(n)); } }
        """),
        1,
      );
    });

    test('F-SCD42-5: a hoisted await in a bare block returns the right value '
        '[2026-09-12]', () async {
      // The workaround shape, and it was ALSO wrong: this returned `1` — the
      // awaited value — instead of the list. A test that only checked for the
      // absence of an exception would have called the bare block healthy.
      expect(
        await run(r"""
          main() async {
            { var log = []; final v = await Future.value(1); log.add(v); return log; }
          }
        """),
        orderedEquals([1]),
      );
    });

    test('F-SCD42-6: an if body still works [2026-09-12]', () async {
      // Control: the machine already stepped into these, and the fix must not
      // disturb the path that was correct.
      expect(
        await run(r"""
          main() async {
            if (true) { var log = []; log.add(await Future.value(1)); return log; }
          }
        """),
        orderedEquals([1]),
      );
    });

    test('F-SCD42-7: a for body still works [2026-09-12]', () async {
      expect(
        await run(r"""
          main() async {
            for (var i = 0; i < 1; i++) {
              var log = [];
              log.add(await Future.value(1));
              return log;
            }
          }
        """),
        orderedEquals([1]),
      );
    });

    test(
      'F-SCD42-8: a bare block with no await is unaffected [2026-09-12]',
      () async {
        expect(
          await run(r"""
          main() async { { var log = []; log.add(1); return log; } }
        """),
          orderedEquals([1]),
        );
      },
    );
  });

  /// SCD43 — a `throw` inside an async `finally` re-entered that same finally
  /// for ever.
  ///
  /// `_handleAsyncError` asked `_findEnclosingTryStatement` which try protects
  /// the throwing node, and for a node inside a finally block that is the try
  /// whose finally is currently running. It has a finally, so the machine
  /// scheduled that finally again, which threw again. **A finally block is not
  /// protected by its own try**, so the search has to continue at the try's
  /// parent.
  ///
  /// Every async shape hung: with and without an outer catch, with and without
  /// an `await` before the throw, and whether or not the finally's exception
  /// was replacing one already in flight. The synchronous path was correct
  /// throughout, and is the reference these cases are written against.
  ///
  /// ## The replacement rule is the part worth getting right
  ///
  /// Dart specifies that an exception raised in a `finally` REPLACES one
  /// propagating from the try body, and the replaced one is lost. A fix that
  /// merely stops the loop but propagates the ORIGINAL would pass any test that
  /// only asserts "something was thrown" — so F-SCD43-3 and F-SCD43-6 name the
  /// exception that must win AND the one that must not appear.
  ///
  /// ## These cases HANG when they regress, they do not fail
  ///
  /// The machine reschedules itself through `Future.microtask`, so a loop here
  /// starves the event loop and the file's `run` timeout never fires. Before
  /// the fix this group wedged the suite rather than failing it. To see a red
  /// state, use a wall clock: `perl -e 'alarm 90; exec @ARGV' dart test …`.
  /// SCD169 — a throw raised inside an async CATCH BLOCK never left the
  /// machine.
  ///
  /// `_findEnclosingTryStatement` returns the try whose catch block contains
  /// the throw, `selectCatchClause` then matched a clause of that same try, the
  /// clause ran and threw again, and the machine re-offered the error to the
  /// same try forever. The symptom is a HANG and the cause is a SPIN: measured
  /// before the fix, the catch block of a four-line script ran **135,239 times
  /// in six seconds**.
  ///
  /// That distinction is what makes these tests dangerous to write carelessly.
  /// A spinning isolate never runs a Timer, so neither `dart test`'s per-test
  /// timeout nor a `Future.timeout` in the harness can contain a regression —
  /// verified: a host-side `.timeout(seconds: 5)` around `execute()` did not
  /// fire, and the process had to be killed with a signal after 120 s. A
  /// regression here would therefore wedge the whole suite rather than fail.
  ///
  /// So EVERY case whose script throws from a catch block is written to be
  /// SELF-LIMITING: it counts its own catch-block entries and, on the second,
  /// yields `SCD169-LOOPED` instead of throwing again. On the fixed machine the
  /// count never reaches two; on a regressed machine the script terminates and
  /// the test FAILS with a readable message instead of hanging.
  ///
  /// Doing this for one case is not enough, and that was measured rather than
  /// assumed: with only F-SCD169-1 self-limiting, reverting the selection guard
  /// left F-SCD169-3 to wedge the whole suite. The two guards cover DIFFERENT
  /// cases — the search loop skips an ineligible try that has nothing else to
  /// do, and the selection guard stops a try that stays in the search because
  /// it has a `finally` from matching anyway — so a regression in either one
  /// spins a different script.
  ///
  /// The oracle throughout is the synchronous path, which already behaves the
  /// way Dart specifies: a catch block's own exception is not catchable by its
  /// own try, the try's `finally` still runs, and an enclosing try whose BODY
  /// contains the inner try may catch it.
  group('SCD169: a throw inside an async catch block leaves the machine', () {
    Future<void> expectThrows(String source, String fragment) => expectLater(
      executeAsync(source).timeout(const Duration(seconds: 10)),
      throwsA(
        predicate(
          (Object? e) => e.toString().contains(fragment),
          'an error mentioning "$fragment"',
        ),
      ),
    );

    test('F-SCD169-1: the catch block runs exactly once '
        '[2026-09-15] (PASS)', () async {
      // Self-limiting, deliberately — see the group doc. `entries` is returned
      // rather than asserted on directly because a looping machine never
      // returns at all unless the script stops it.
      expect(
        await run(r"""
          int entries = 0;
          Future<dynamic> f() async {
            try { throw StateError('x'); }
            catch (e) {
              entries = entries + 1;
              if (entries > 1) { return 'LOOPED'; }
              throw ArgumentError('B');
            }
          }
          Future<dynamic> main() async {
            try { await f(); } catch (e) { return 'propagated:$entries'; }
          }
        """),
        'propagated:1',
        reason:
            'A result of LOOPED means the machine re-offered the error to the '
            'try whose catch block raised it — the SCD169 spin. Before the fix '
            'this script did not return at all.',
      );
    });

    test('F-SCD169-2: the error propagates out of the function '
        '[2026-09-15] (PASS)', () async {
      await expectThrows(r"""
          Future<dynamic> f() async {
            try { throw StateError('x'); }
            catch (e) {
              entries = entries + 1;
              if (entries > 1) { throw StateError('SCD169-LOOPED'); }
              throw ArgumentError('B');
            }
          }
          int entries = 0;
          Future<dynamic> main() async { return await f(); }
        """, 'B');
    });

    test('F-SCD169-3: the try\'s own finally still runs before it propagates '
        '[2026-09-15] (PASS)', () async {
      // The half a naive fix gets wrong. Skipping the try outright stops the
      // spin and silently drops its finally; Dart runs it. The search loop
      // therefore skips an ineligible try only when it has nothing else to do.
      expect(
        await run(r"""
          int ran = 0;
          int entries = 0;
          Future<dynamic> f() async {
            try { throw StateError('x'); }
            catch (e) {
              entries = entries + 1;
              if (entries > 1) { return 'SCD169-LOOPED'; }
              throw ArgumentError('B');
            }
            finally { ran = ran + 1; }
          }
          Future<dynamic> main() async {
            try { await f(); } catch (e) { return 'finally ran $ran times'; }
          }
        """),
        'finally ran 1 times',
      );
    });

    test('F-SCD169-4: an enclosing try whose BODY holds the inner try catches '
        'it [2026-09-15] (PASS)', () async {
      expect(
        await run(r"""
          int entries = 0;
          Future<dynamic> main() async {
            try {
              try { throw StateError('x'); }
              catch (e) {
                entries = entries + 1;
                if (entries > 1) { return 'SCD169-LOOPED'; }
                throw ArgumentError('B');
              }
            } catch (e2) { return 'outer caught'; }
          }
        """),
        'outer caught',
      );
    });

    test('F-SCD169-5: an enclosing try whose CATCH holds the inner try does '
        'NOT catch it [2026-09-15] (PASS)', () async {
      // The rule has to hold at every level: a handler that is already running
      // cannot claim an exception raised beneath it. A single-level skip would
      // let the outer clause catch here, which is why the search continues
      // outward rather than stepping out once.
      await expectThrows(r"""
          int entries = 0;
          Future<dynamic> main() async {
            try { throw StateError('a'); }
            catch (e) {
              try { throw StateError('c'); }
              catch (e2) {
                entries = entries + 1;
                if (entries > 1) { throw StateError('SCD169-LOOPED'); }
                throw ArgumentError('B');
              }
            }
          }
        """, 'B');
    });

    test('F-SCD169-6: an interpreter-level error in a catch block surfaces '
        '[2026-09-15] (PASS)', () async {
      // SCD169's original reproduction, found because F-SCC61-13 hung rather
      // than failed. An unresolvable name is only one way in; F-SCD169-2 shows
      // a plain `throw` did the same, which is why the fix is not about error
      // kinds.
      await expectThrows(r"""
          Future<dynamic> g() async { throw StateError('x'); }
          Future<dynamic> main() async {
            try { await g(); } catch (e) { return e is NoSuchBridgedName; }
          }
        """, 'NoSuchBridgedName');
    });

    test('F-SCD169-7 (control): a catch block that does NOT throw still '
        'catches [2026-09-15] (PASS)', () async {
      // Without this, F-SCD169-2/5/6 are satisfied by a machine that has
      // stopped letting ANY clause match — which would be a different bug with
      // the same test results.
      expect(
        await run(r"""
          Future<dynamic> main() async {
            try { throw StateError('x'); } catch (e) { return 'caught'; }
          }
        """),
        'caught',
      );
    });

    test('F-SCD169-8 (control): the SYNC path is unchanged '
        '[2026-09-15] (PASS)', () async {
      expect(
        await run(r"""
          int ran = 0;
          dynamic main() {
            try {
              try { throw StateError('x'); }
              catch (e) { throw ArgumentError('B'); }
              finally { ran = ran + 1; }
            } catch (e2) { return 'outer caught, finally ran $ran times'; }
          }
        """),
        'outer caught, finally ran 1 times',
      );
    });
  });

  group('SCD43: a throw inside an async finally propagates', () {
    /// Asserts the program throws something naming [fragment].
    Future<void> expectThrows(String source, String fragment) => expectLater(
      executeAsync(source).timeout(const Duration(seconds: 10)),
      throwsA(
        predicate(
          (Object? e) => e.toString().contains(fragment),
          'an error mentioning "$fragment"',
        ),
      ),
    );

    test('F-SCD43-1: an outer try catches it [2026-09-12]', () async {
      expect(
        await run(r"""
          Future<dynamic> main() async {
            try { try { } finally { throw StateError('fin'); } }
            catch (e) { return 'caught'; }
          }
        """),
        'caught',
      );
    });

    test('F-SCD43-2: with no outer handler it leaves the function '
        '[2026-09-12]', () async {
      await expectThrows(
        r"Future<dynamic> main() async { try { } finally { throw StateError('fin'); } }",
        'fin',
      );
    });

    test(
      "F-SCD43-3: it REPLACES the try body's exception [2026-09-12]",
      () async {
        // Dart loses the body's exception. Asserting only that something was
        // caught would pass while the original propagated, which is the wrong
        // answer arrived at by a fix that merely stops the loop.
        final caught = await run(r"""
        Future<dynamic> main() async {
          try {
            try { throw StateError('body'); } finally { throw StateError('fin'); }
          } catch (e) { return e.toString(); }
        }
      """);
        expect(caught, contains('fin'));
        expect(
          caught,
          isNot(contains('body')),
          reason:
              "the finally's exception replaces the body's, and the replaced one "
              'is lost — propagating the original instead would satisfy any '
              '"did it throw" assertion',
        );
      },
    );

    test('F-SCD43-4: with an await before the throw, an outer try catches it '
        '[2026-09-12]', () async {
      expect(
        await run(r"""
          Future<dynamic> main() async {
            try {
              try { } finally { await Future.value(0); throw StateError('fin'); }
            } catch (e) { return 'caught'; }
          }
        """),
        'caught',
      );
    });

    test('F-SCD43-5: with an await and no outer handler it leaves the '
        'function [2026-09-12]', () async {
      await expectThrows(
        r"Future<dynamic> main() async { try { } finally { await Future.value(0); throw StateError('fin'); } }",
        'fin',
      );
    });

    test('F-SCD43-6: with an await it still REPLACES the body exception '
        '[2026-09-12]', () async {
      final caught = await run(r"""
        Future<dynamic> main() async {
          try {
            try { throw StateError('body'); }
            finally { await Future.value(0); throw StateError('fin'); }
          } catch (e) { return e.toString(); }
        }
      """);
      expect(caught, contains('fin'));
      expect(caught, isNot(contains('body')));
    });

    test('F-SCD43-7: a throwing finally discards a pending return '
        '[2026-09-12]', () async {
      // Real Dart throws here — the finally's abrupt completion replaces the
      // pending return exactly as it replaces a pending exception. scd40 left
      // this contest undecided because the shape hung before reaching the
      // state machine's terminal exits; it no longer does.
      await expectThrows(
        r"Future<dynamic> main() async { try { return 7; } finally { throw StateError('fin'); } }",
        'fin',
      );
    });

    test('F-SCD43-8: the SYNC path is unchanged [2026-09-12]', () async {
      // The reference. It was already correct, and it is what the async path
      // is being made to agree with.
      final caught = await run(r"""
        main() {
          try {
            try { throw StateError('body'); } finally { throw StateError('fin'); }
          } catch (e) { return e.toString(); }
        }
      """);
      expect(caught, contains('fin'));
      expect(caught, isNot(contains('body')));
    });

    test('F-SCD43-9: a try nested INSIDE a finally handles its own errors '
        '[2026-09-12]', () async {
      // The boundary the structural rule must respect, and the exact parallel
      // of F-SCD41-11 for catch clauses: skipping to the owner unconditionally
      // would make a try written inside a finally unable to catch anything.
      expect(
        await run(r"""
          Future<dynamic> main() async {
            var log = [];
            try { }
            finally {
              try { throw StateError('inner'); } catch (e) { log.add('ic'); }
              log.add('done');
            }
            return log;
          }
        """),
        orderedEquals(['ic', 'done']),
      );
    });
  });
  group('SCE78: a return issued BY a finally', () {
    // SCD43 closed the error half of this shape: a throw inside a finally is
    // offered to the try ENCLOSING that try, and the pending return is dropped
    // in the same step. A `return` is not an error, so it never reaches
    // `_handleAsyncError` — it travels the ReturnException / returnAfterFinally
    // path instead, which is why the two shapes looked identical and needed
    // different fixes.
    //
    // THE SYMPTOM WAS A HANG, not a wrong answer. `activeTryStatement` was
    // still the try whose finally was running, so the machine stored the value
    // and jumped back to the first statement of the block that had just issued
    // the return — and did it again. A starved event loop is invisible to the
    // 10-second `onTimeout` in `run` above, so before the fix these cases
    // WEDGED this file rather than failing it. Reproduce one in isolation with
    // a wall-clock kill: `perl -e 'alarm 20; exec @ARGV' dart run <case>.dart`.

    test('F-SCE78-1: a return in a finally discards a pending exception '
        '[2026-09-21]', () async {
      // The reported shape. Real Dart returns 5: the finally completes
      // abruptly, and that replaces whatever the try body was doing.
      expect(
        await run('''
          Future<dynamic> f() async {
            try { throw StateError('x'); } finally { return 5; }
          }
          main() async => await f();
        '''),
        5,
      );
    });

    test('F-SCE78-2: a return in a finally replaces a pending return '
        '[2026-09-21]', () async {
      expect(
        await run('''
          Future<dynamic> f() async {
            try { return 7; } finally { return 5; }
          }
          main() async => await f();
        '''),
        5,
      );
    });

    test('F-SCE78-3: the discarded exception does not resurface at an '
        'enclosing catch [2026-09-21]', () async {
      // The exception is GONE, not deferred. If the fix merely stopped the
      // loop and left the error held, this would answer 9 — a fix that ends
      // the hang and still answers wrongly, which is the trap SCD43 records
      // for its own half.
      expect(
        await run('''
          Future<dynamic> f() async {
            try {
              try { throw StateError('x'); } finally { return 5; }
            } catch (e) { return 9; }
          }
          main() async => await f();
        '''),
        5,
      );
    });

    test('F-SCE78-4: an ENCLOSING finally still runs, and its return wins '
        '[2026-09-21]', () async {
      // The case that caught the first attempt at this fix. Completing the
      // function as soon as the inner finally returned answered 1; real Dart
      // answers 2, because the return has to leave through the outer finally,
      // which issues a return of its own that replaces it.
      expect(
        await run('''
          Future<dynamic> f() async {
            try {
              try { throw StateError('x'); } finally { return 1; }
            } finally { return 2; }
          }
          main() async => await f();
        '''),
        2,
      );
    });

    test(
      'F-SCE78-5: a finally that awaits before returning [2026-09-21]',
      () async {
        // The suspension is what this whole file is about, so the shape has to
        // be exercised with one: a finally that yields and THEN returns puts the
        // machine through a resumption before the return is issued.
        expect(
          await run('''
          Future<dynamic> f() async {
            try {
              throw StateError('x');
            } finally {
              await Future.delayed(Duration.zero);
              return 5;
            }
          }
          main() async => await f();
        '''),
          5,
        );
      },
    );

    test('F-SCE78-6 (control): the finally still RUNS, it is not skipped '
        '[2026-09-21]', () async {
      // Every case above reads the returned value, and a machine that skipped
      // the finally entirely and returned the literal would satisfy them all.
      // This one reads a side effect the finally must have performed.
      expect(
        await run('''
          Future<dynamic> f() async {
            var log = [];
            try { throw StateError('x'); } finally { log.add('ran'); return log; }
          }
          main() async => await f();
        '''),
        orderedEquals(['ran']),
      );
    });

    test('F-SCE78-7 (control): a finally with no return still propagates the '
        'exception [2026-09-21]', () async {
      // The other direction. If the fix made every finally discard the pending
      // error rather than only one that completes abruptly, this would answer
      // instead of throwing.
      await expectLater(
        run('''
          Future<dynamic> f() async {
            var log = [];
            try { throw StateError('x'); } finally { log.add('ran'); }
          }
          main() async => await f();
        '''),
        throwsA(isA<StateError>()),
      );
    });

    test('F-SCE78-8: the SYNC path is unchanged [2026-09-21]', () async {
      // It was already correct, and is the reference the async path is being
      // made to match — so it is pinned rather than assumed.
      expect(
        await run('''
          dynamic f() {
            try { throw StateError('x'); } finally { return 5; }
          }
          main() async => f();
        '''),
        5,
      );
    });
  });
  group('SCE79: the catch variable is scoped to its block', () {
    // The third thing the async error path approximated rather than decided.
    // `_handleAsyncError` bound the exception variable into the FUNCTION's
    // environment — its own comment said "can cause collisions" — while
    // `visitTryStatement` has always given the synchronous path a child
    // environment, which is what Dart requires.
    //
    // BOTH SHAPES ARE PINNED, and the second is why the first is not enough:
    // the leak alone could be "fixed" by clearing the variable after the
    // block, which would leave the clobber untouched and look green. The
    // clobber is also the serious one and the silent one — `e` is one of the
    // most common names in any codebase, so in an async function a caught
    // exception overwrote the caller's own local and nothing threw or logged.
    //
    // Each case carries its SYNCHRONOUS control, because the sync path was
    // already correct and is the reference the async path is being made to
    // agree with.

    test('F-SCE79-1: the catch variable does not outlive its block '
        '[2026-09-21]', () async {
      await expectLater(
        run('''
          Future<dynamic> f() async {
            try { throw StateError('x'); } catch (e) { }
            return e;
          }
          main() async => await f();
        '''),
        throwsA(isA<UndefinedNameD4rtException>()),
      );
    });

    test(
      'F-SCE79-2 (control): the SYNC path already scoped it [2026-09-21]',
      () async {
        await expectLater(
          run('''
          dynamic f() {
            try { throw StateError('x'); } catch (e) { }
            return e;
          }
          main() async => f();
        '''),
          throwsA(isA<UndefinedNameD4rtException>()),
        );
      },
    );

    test('F-SCE79-3: the catch variable does not clobber an outer local '
        '[2026-09-21]', () async {
      // The silent one. Before the fix this returned the exception.
      expect(
        await run('''
          Future<dynamic> f() async {
            var e = 'outer';
            try { throw StateError('x'); } catch (e) { }
            return e;
          }
          main() async => await f();
        '''),
        'outer',
      );
    });

    test('F-SCE79-4 (control): the SYNC path already protected it '
        '[2026-09-21]', () async {
      expect(
        await run('''
          dynamic f() {
            var e = 'outer';
            try { throw StateError('x'); } catch (e) { }
            return e;
          }
          main() async => f();
        '''),
        'outer',
      );
    });

    test('F-SCE79-5: the outer local survives a SUSPENSION in the catch '
        '[2026-09-21]', () async {
      // The scope has to survive resumption, which is the part of this that
      // made a pushed-and-popped stack the wrong shape: the machine resumes at
      // a NODE rather than executing a block, so every exit would have needed
      // to pop. Selecting the environment from the node's position instead
      // means there is nothing to undo — and this is the case that would fail
      // if the binding were merely cleared at the end of the block.
      expect(
        await run('''
          Future<dynamic> f() async {
            var e = 'outer';
            try { throw StateError('x'); } catch (e) { await Future.delayed(Duration.zero); }
            return e;
          }
          main() async => await f();
        '''),
        'outer',
      );
    });

    test('F-SCE79-6: a catch inside a LOOP still sees the loop variable '
        '[2026-09-21]', () async {
      // The catch environment is a child of whatever was selected when the
      // error was handled, so the loop's variables stay reachable through the
      // chain — and each iteration gets a fresh binding rather than resuming a
      // stale one.
      expect(
        await run('''
          Future<dynamic> f() async {
            var out = [];
            for (var i = 0; i < 2; i++) {
              try { throw StateError('e' + i.toString()); } catch (e) { out.add(i.toString() + ':' + e.message); }
            }
            return out.join(',');
          }
          main() async => await f();
        '''),
        '0:e0,1:e1',
      );
    });

    test('F-SCE79-7: a LOOP inside a catch still sees the exception '
        '[2026-09-21]', () async {
      // The other nesting, and the one that decides the selection rule: a loop
      // opened inside a catch built its environment as a child of the catch's,
      // so it already reaches the exception variable and must keep winning.
      // Preferring the catch environment unconditionally would lose the loop's.
      expect(
        await run('''
          Future<dynamic> f() async {
            try { throw StateError('x'); } catch (e) {
              var out = [];
              for (var i = 0; i < 2; i++) { out.add(i.toString() + '-' + e.message); }
              return out.join(',');
            }
          }
          main() async => await f();
        '''),
        '0-x,1-x',
      );
    });

    test('F-SCE79-8: a closure written in the catch captures the variable '
        '[2026-09-21]', () async {
      expect(
        await run('''
          Future<dynamic> f() async {
            try { throw StateError('x'); } catch (e) { var g = () => e.message; return g(); }
          }
          main() async => await f();
        '''),
        'x',
      );
    });

    test('F-SCE79-9: the stack-trace parameter is scoped the same way '
        '[2026-09-21]', () async {
      // It is bound beside the exception variable and would have leaked with
      // it. Asserting only the exception variable would leave half the fix
      // unpinned.
      await expectLater(
        run('''
          Future<dynamic> f() async {
            try { throw StateError('x'); } catch (e, st) { }
            return st;
          }
          main() async => await f();
        '''),
        throwsA(isA<UndefinedNameD4rtException>()),
      );
    });

    test('F-SCE79-10 (control): the variable IS visible inside the block '
        '[2026-09-21]', () async {
      // Every case above asserts an absence, which is the shape that passes
      // when the binding is simply broken. This one reads it where it must be
      // present.
      expect(
        await run('''
          Future<dynamic> f() async {
            try { throw StateError('x'); } catch (e) { return e.message; }
          }
          main() async => await f();
        '''),
        'x',
      );
    });
  });
  group('SCE80: await inside a collection literal', () {
    // `_processCollectionElement` returned `void`, so it had no way to say
    // "the element I was evaluating has not finished" — it stored the
    // interpreter's own `AsyncSuspensionRequest` sentinel as the element
    // instead. `[await Future.value(1)]` evaluated to a list containing one of
    // those, silently, and only the spread case reported anything, and only
    // because a sentinel is not an `Iterable`.
    //
    // EVERY CASE COMPARES CONTENTS, never a length and never absence-of-throw.
    // A sentinel counts as an element perfectly well: a first probe of the map
    // and set shapes checked `.length` and reported them healthy. SCD42 was
    // caught by the same trap from the other side, where a hoisted-await case
    // returned `1` instead of `[1]` and read as a pass.

    test('F-SCE80-1: a list element [2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async { return [await Future.value(1)]; }
        main() async => await f();
      '''),
        orderedEquals([1]),
      );
    });

    test('F-SCE80-2: a later element, with an earlier one already stored '
        '[2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async { return [1, await Future.value(2)]; }
        main() async => await f();
      '''),
        orderedEquals([1, 2]),
      );
    });

    test('F-SCE80-3: two awaits in one literal [2026-09-21]', () async {
      // Replay resumes the whole literal, so the second await must suspend
      // again rather than replay the first one's value — SCC40's per-site
      // cache is what makes that work, and this is where it is exercised
      // through a collection.
      expect(
        await run('''
        Future<dynamic> f() async {
          return [await Future.value(1), await Future.value(2)];
        }
        main() async => await f();
      '''),
        orderedEquals([1, 2]),
      );
    });

    test('F-SCE80-4: a nested literal [2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async { return [[await Future.value(1)]]; }
        main() async => await f();
      '''),
        orderedEquals([
          orderedEquals([1]),
        ]),
      );
    });

    test('F-SCE80-5: an `if` element, both branches [2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async { return [if (true) await Future.value(1)]; }
        main() async => await f();
      '''),
        orderedEquals([1]),
      );
      expect(
        await run('''
        Future<dynamic> f() async {
          return [if (false) await Future.value(1) else await Future.value(9)];
        }
        main() async => await f();
      '''),
        orderedEquals([9]),
      );
    });

    test('F-SCE80-6: a map KEY [2026-09-21]', () async {
      // The key is checked before `_unwrapHashKey`, which would otherwise
      // normalise the sentinel into a perfectly good map key.
      expect(
        await run('''
        Future<dynamic> f() async { return {await Future.value('a'): 1}; }
        main() async => await f();
      '''),
        equals({'a': 1}),
      );
    });

    test('F-SCE80-7: a map VALUE, and two of them [2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async { return {'a': await Future.value(1), 'b': 2}; }
        main() async => await f();
      '''),
        equals({'a': 1, 'b': 2}),
      );
      expect(
        await run('''
        Future<dynamic> f() async {
          return {'a': await Future.value(1), 'b': await Future.value(2)};
        }
        main() async => await f();
      '''),
        equals({'a': 1, 'b': 2}),
      );
    });

    test('F-SCE80-8: a set element [2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async { return {await Future.value(1), 2}; }
        main() async => await f();
      '''),
        unorderedEquals([1, 2]),
      );
    });

    test('F-SCE80-9: a spread [2026-09-21]', () async {
      // The one shape that already reported something, and it reported the
      // wrong thing: `requires an Iterable, but got AsyncSuspensionRequest`.
      expect(
        await run('''
        Future<dynamic> f() async { return [...await Future.value([1, 2])]; }
        main() async => await f();
      '''),
        orderedEquals([1, 2]),
      );
    });

    test('F-SCE80-10: a null-aware element [2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async { return [?await Future.value(1)]; }
        main() async => await f();
      '''),
        orderedEquals([1]),
      );
    });

    test('F-SCE80-11: a `for` element\'s ITERABLE [2026-09-21]', () async {
      // The iterable is evaluated once, so it propagates like any other
      // expression. Only the BODY is refused — see F-SCE80-12.
      expect(
        await run('''
        Future<dynamic> f() async {
          return [for (var i in await Future.value([1, 2])) i * 10];
        }
        main() async => await f();
      '''),
        orderedEquals([10, 20]),
      );
    });

    test('F-SCE80-12: an await in a `for` BODY is refused, not corrupted '
        '[2026-09-21]', () async {
      // The one shape a suspension cannot propagate through. Replay
      // re-evaluates the whole literal, so the loop would run its earlier
      // iterations again — and `resolvedAwaitResults` is keyed by the
      // `AwaitExpression` NODE, which every iteration shares, so the second
      // iteration would replay the FIRST one's value. Before this todo the
      // result was two sentinels; a naive propagation would have made it two
      // copies of the same number, which is the same class of silent defect
      // wearing a better disguise.
      await expectLater(
        run('''
          Future<dynamic> f() async {
            return [for (var i in [1, 2]) await Future.value(i)];
          }
          main() async => await f();
        '''),
        throwsA(
          predicate<Object>(
            (e) => '$e'.contains(
              'not supported in the body of a '
              'collection-literal `for` element',
            ),
            'names the construct and points at the statement form',
          ),
        ),
      );
    });

    test('F-SCE80-13: the statement form the diagnostic recommends works '
        '[2026-09-21]', () async {
      // A refusal that points nowhere is not much better than a wrong answer.
      expect(
        await run('''
        Future<dynamic> f() async {
          var out = [];
          for (var i in [1, 2]) { out.add(await Future.value(i * 10)); }
          return out;
        }
        main() async => await f();
      '''),
        orderedEquals([10, 20]),
      );
    });

    test('F-SCE80-14 (control): a `for` element with no await still works '
        '[2026-09-21]', () async {
      // The refusal is conditioned on the body actually suspending, not on the
      // element being a `for`. Without this, refusing every collection `for`
      // would pass F-SCE80-12 and break ordinary code.
      expect(
        await run('''
        Future<dynamic> f() async {
          return [1, 2, for (var i in [3, 4]) i, if (true) 5];
        }
        main() async => await f();
      '''),
        orderedEquals([1, 2, 3, 4, 5]),
      );
    });

    test('F-SCE80-15 (control): a classic `for` element with no await '
        '[2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async {
          return [for (var i = 0; i < 3; i++) i];
        }
        main() async => await f();
      '''),
        orderedEquals([0, 1, 2]),
      );
    });
  });
  group('SCE81: a cascade section takes an awaited argument', () {
    // `sb..write(await f())..write('b')` failed with `type
    // 'AsyncSuspensionRequest' is not a subtype of type '(List<Object?>,
    // Map<String, Object?>)'` — an interpreter internal, surfaced to the script
    // author. The same code without the cascade always worked.
    //
    // OPTION (b) WAS REACHABLE, which the decision preferred: the target and
    // the completed sections are memoised the way `await` results already are,
    // so replay evaluates the target once and skips the sections whose side
    // effects have happened. The alternative was to refuse the construct.
    //
    // THE SIDE-EFFECT QUESTION IS THE WHOLE POINT, so F-SCE81-4 puts an
    // OBSERVABLE side effect before and after the awaiting section and asserts
    // each happened exactly once. Without it a naive propagate-and-replay fix
    // silently doubles work and every other case here still passes.

    test('F-SCE81-1: an await in the first section [2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async {
          var sb = StringBuffer();
          sb..write(await Future.value('a'))..write('b');
          return sb.toString();
        }
        main() async => await f();
      '''),
        'ab',
      );
    });

    test('F-SCE81-2: an await in a LATER section, after one has already run '
        '[2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async {
          var sb = StringBuffer();
          sb..write('a')..write(await Future.value('b'));
          return sb.toString();
        }
        main() async => await f();
      '''),
        'ab',
      );
    });

    test('F-SCE81-3: two awaiting sections [2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async {
          var sb = StringBuffer();
          sb..write(await Future.value('p'))..write(await Future.value('q'));
          return sb.toString();
        }
        main() async => await f();
      '''),
        'pq',
      );
    });

    test('F-SCE81-4: sections around the awaiting one run EXACTLY ONCE '
        '[2026-09-21]', () async {
      // The case the notes demanded. `_t` appends to a log declared outside the
      // cascade statement, so a re-run cannot hide behind a fresh object.
      // Real Dart: 'xyz' and a log of 'x,z'.
      expect(
        await run('''
        _t(l, s) { l.add(s); return s; }
        Future<dynamic> f() async {
          var log = [];
          var sb = StringBuffer();
          sb..write(_t(log, 'x'))..write(await Future.value('y'))..write(_t(log, 'z'));
          return sb.toString() + ' / ' + log.join(',');
        }
        main() async => await f();
      '''),
        'xyz / x,z',
      );
    });

    test(
      'F-SCE81-5: statements AFTER the cascade still run [2026-09-21]',
      () async {
        // Lifting the resumption context to the cascade without admitting it to
        // the re-execution branch left nothing to re-execute, so the machine
        // completed the function with `lastAwaitResult` and everything after the
        // cascade was skipped. That passed F-SCE81-1 by accident, because the
        // value it completed with happened to be the target.
        expect(
          await run('''
        Future<dynamic> f() async {
          var log = [];
          var sb = StringBuffer();
          sb..write(await Future.value('a'))..write('b');
          log.add('after');
          return [sb.toString(), log.join()];
        }
        main() async => await f();
      '''),
          orderedEquals(['ab', 'after']),
        );
      },
    );

    test('F-SCE81-6: an index-assignment section [2026-09-21]', () async {
      // A different resumption shape: here the context node is the whole
      // `ExpressionStatement` rather than the section, so an upward-only walk
      // missed the cascade and NONE of the sections were applied.
      expect(
        await run('''
        Future<dynamic> f() async {
          var g = {};
          g..['k'] = await Future.value(1)..['m'] = 2;
          return g.toString();
        }
        main() async => await f();
      '''),
        '{k: 1, m: 2}',
      );
    });

    test('F-SCE81-7: a list cascade [2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async {
          var c = [];
          c..add(await Future.value(1))..add(2);
          return c;
        }
        main() async => await f();
      '''),
        orderedEquals([1, 2]),
      );
    });

    test('F-SCE81-8: a cascade inside a LOOP starts fresh each iteration '
        '[2026-09-21]', () async {
      // The memo is dropped when the cascade completes, not at statement
      // level. Holding it would make iteration two skip every section it ran
      // in iteration one.
      expect(
        await run('''
        Future<dynamic> f() async {
          var out = [];
          for (var i = 0; i < 2; i++) {
            var s = StringBuffer();
            s..write(i.toString())..write(await Future.value('!'));
            out.add(s.toString());
          }
          return out.join(',');
        }
        main() async => await f();
      '''),
        '0!,1!',
      );
    });

    test('F-SCE81-9 (control): a cascade with no await is unchanged '
        '[2026-09-21]', () async {
      expect(
        await run('''
        Future<dynamic> f() async {
          var sb = StringBuffer();
          sb..write('n')..write('o');
          return sb.toString();
        }
        main() async => await f();
      '''),
        'no',
      );
    });

    test('F-SCE81-10 (control): the same code without a cascade '
        '[2026-09-21]', () async {
      // The reference the cascade form is being made to agree with. It always
      // worked, which is what made the cascade failure a d4rt defect rather
      // than a limitation of the replay model.
      expect(
        await run('''
        Future<dynamic> f() async {
          var sb = StringBuffer();
          sb.write(await Future.value('a'));
          sb.write('b');
          return sb.toString();
        }
        main() async => await f();
      '''),
        'ab',
      );
    });
  });
}
