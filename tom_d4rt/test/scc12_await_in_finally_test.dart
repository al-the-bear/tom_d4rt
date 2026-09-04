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
      onTimeout: () => fail('the interpreted program never completed — the '
          'suspension raised inside try/finally was swallowed'));

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

    test('F-SCC12-4: a value awaited in finally is the awaited value [2026-09-04]',
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
    });

    test('F-SCC12-5: an awaiting finally still runs when the try body throws [2026-09-04]',
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
    });

    test('F-SCC12-6: an awaiting finally still runs on the way out of a return [2026-09-04]',
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
    });
  });

  group('SCC12: a finally runs once when its protected region suspends', () {
    test('F-SCC12-7: a finally runs once when the try body awaits [2026-09-04]',
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
    });

    test('F-SCC12-8: a finally runs once when a catch body awaits [2026-09-04]',
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
    });

    test('F-SCC12-9: a finally runs once when both the body and the finally await [2026-09-04]',
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
    });
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
  group('SCC12: an error passing through a finally reaches the enclosing catch',
      () {
    test('F-SCC12-10: an async function propagates out of a try/finally with no catch [2026-09-04]',
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
    });

    test('F-SCC12-11: an empty finally does not swallow the error [2026-09-04]',
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
    });

    test('F-SCC12-12: a failed read throws out through an awaited teardown [2026-09-04]',
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
        throwsA(predicate(
            (Object? e) => e.toString().contains('noSuchMember'),
            'an error naming the member that could not be read')),
      );
    });

    test('F-SCC12-13: the awaited teardown runs before the failed read is caught [2026-09-04]',
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
      expect(result, orderedEquals(['released', 'caught']),
          reason: 'the teardown must run, and the read must not be treated as '
              'having succeeded');
    });
  });
}
