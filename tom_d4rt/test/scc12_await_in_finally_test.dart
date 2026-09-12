import 'dart:async';

import 'package:test/test.dart';
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
}
