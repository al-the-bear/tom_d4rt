// SC1: dart:core Stopwatch must be bridged.
//
// Stopwatch is a pure, I/O-free timing primitive, so it needs no permission
// gate. The assertions below deliberately avoid depending on wall-clock
// durations — elapsed time is not reproducible in CI — and instead pin the
// state machine (isRunning transitions, reset semantics) and the presence and
// types of every exposed member.

import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('Stopwatch tests', () {
    test('F-SC1-1: Stopwatch construction starts stopped and at zero '
        '[2026-07-27]', () {
      const source = '''
      main() {
        final sw = Stopwatch();
        return [sw.isRunning, sw.elapsedTicks, sw.elapsedMicroseconds];
      }
      ''';
      expect(execute(source), equals([false, 0, 0]));
    });

    test('F-SC1-2: start()/stop() drive isRunning [2026-07-27]', () {
      const source = '''
      main() {
        final sw = Stopwatch();
        final before = sw.isRunning;
        sw.start();
        final during = sw.isRunning;
        sw.stop();
        final after = sw.isRunning;
        return [before, during, after];
      }
      ''';
      expect(execute(source), equals([false, true, false]));
    });

    test('F-SC1-3: reset() returns the counter to zero [2026-07-27]', () {
      // Busy-work between start and stop so elapsed is plausibly non-zero,
      // then assert only that reset lands exactly on zero — the one value
      // that is deterministic.
      const source = '''
      main() {
        final sw = Stopwatch();
        sw.start();
        var acc = 0;
        for (var i = 0; i < 2000; i++) { acc += i; }
        sw.stop();
        sw.reset();
        return [sw.elapsedTicks, sw.elapsedMicroseconds, sw.elapsedMilliseconds];
      }
      ''';
      expect(execute(source), equals([0, 0, 0]));
    });

    test('F-SC1-4: elapsed is a Duration and elapsed* getters are ints '
        '[2026-07-27]', () {
      const source = '''
      main() {
        final sw = Stopwatch();
        sw.start();
        sw.stop();
        return [
          sw.elapsed is Duration,
          sw.elapsedTicks is int,
          sw.elapsedMicroseconds is int,
          sw.elapsedMilliseconds is int,
          sw.frequency is int,
        ];
      }
      ''';
      expect(execute(source), equals([true, true, true, true, true]));
    });

    test('F-SC1-5: frequency is positive and elapsed never goes backwards '
        '[2026-07-27]', () {
      const source = '''
      main() {
        final sw = Stopwatch();
        sw.start();
        var acc = 0;
        for (var i = 0; i < 2000; i++) { acc += i; }
        final first = sw.elapsedMicroseconds;
        for (var i = 0; i < 2000; i++) { acc += i; }
        final second = sw.elapsedMicroseconds;
        sw.stop();
        return [sw.frequency > 0, first >= 0, second >= first];
      }
      ''';
      expect(execute(source), equals([true, true, true]));
    });

    test('F-SC1-6: a stopped Stopwatch stops accumulating [2026-07-27]', () {
      const source = '''
      main() {
        final sw = Stopwatch();
        sw.start();
        var acc = 0;
        for (var i = 0; i < 2000; i++) { acc += i; }
        sw.stop();
        final frozen = sw.elapsedTicks;
        for (var i = 0; i < 20000; i++) { acc += i; }
        return sw.elapsedTicks == frozen;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('F-SC1-7: Stopwatch is usable as a typed variable and field '
        '[2026-07-27]', () {
      // Scripts commonly declare the type explicitly; that requires the name
      // `Stopwatch` to resolve as a type, not just as a constructor.
      const source = '''
      class Timer2 {
        Stopwatch sw = Stopwatch();
        bool go() { sw.start(); return sw.isRunning; }
      }
      main() {
        Stopwatch local = Stopwatch();
        final t = Timer2();
        return [local is Stopwatch, t.go(), t.sw is Stopwatch];
      }
      ''';
      expect(execute(source), equals([true, true, true]));
    });
  });
}
