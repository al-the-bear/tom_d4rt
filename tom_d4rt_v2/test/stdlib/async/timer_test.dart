/// Tests for the `Timer` bridge in `lib/src/stdlib/async/timer.dart`.
///
/// Cluster E #9 (see `tom_d4rt_flutter_ast/doc/testlog_20260522-1328-issue-analysis/error_analysis.md`):
/// the static `Timer.run(callback)` bridge indexed `positionalArgs[1]`
/// even though the native signature is single-argument, which threw
/// `RangeError (length): Invalid value: Only valid value is 0: 1` on
/// every call. This suite locks the contract in for the three static
/// entry points + the basic instance API.
library;

import 'package:test/test.dart';
import '../../interpreter_test.dart';

void main() {
  group('Timer bridge — static entry points', () {
    test('Timer.run(callback) — covers Cluster E #9 (foundation/key_test.dart)',
        () async {
      const source = '''
        import 'dart:async';
        Future<int> main() async {
          var fired = 0;
          Timer.run(() { fired = 42; });
          // Yield long enough for the scheduled task to fire.
          await Future.delayed(Duration(milliseconds: 20));
          return fired;
        }
      ''';
      expect(await executeAsync(source), equals(42));
    });

    test('Timer(duration, callback) constructor schedules and fires', () async {
      const source = '''
        import 'dart:async';
        Future<int> main() async {
          var fired = 0;
          Timer(Duration(milliseconds: 5), () { fired = 7; });
          await Future.delayed(Duration(milliseconds: 30));
          return fired;
        }
      ''';
      expect(await executeAsync(source), equals(7));
    });

    test('Timer.periodic fires repeatedly and cancel() stops it', () async {
      const source = '''
        import 'dart:async';
        Future<int> main() async {
          var ticks = 0;
          var t = Timer.periodic(Duration(milliseconds: 5), (timer) {
            ticks += 1;
            if (ticks >= 3) {
              timer.cancel();
            }
          });
          await Future.delayed(Duration(milliseconds: 80));
          // Sanity: timer was cancelled after the third tick.
          if (t.isActive) {
            ticks = -1;
          }
          return ticks;
        }
      ''';
      // Allow scheduler jitter — accept anything from 3 (the cancel
      // threshold) upward. The previous bug made this throw before
      // the first tick ever fired, so any non-negative count >= 3
      // proves the bridge works.
      final result = await executeAsync(source) as int;
      expect(result, greaterThanOrEqualTo(3));
    });
  });

  group('Timer bridge — arity guards', () {
    test('Timer.run(callback, extra) throws a clear error', () async {
      const source = '''
        import 'dart:async';
        main() {
          Timer.run(() {}, "extra");
          return 'unreachable';
        }
      ''';
      expect(
        () => execute(source),
        throwsA(predicate((e) =>
            e.toString().contains('Timer.run') ||
            e.toString().contains('callback'))),
      );
    });
  });
}
