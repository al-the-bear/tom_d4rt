import 'package:test/test.dart';

import 'interpreter_test.dart';

/// SCD4 — where `break` and `continue` go.
///
/// `break` in the body of an `await for` aborted the script with
/// `Break statement outside of a loop.` while the same body in a synchronous
/// `for-in` worked. It hid behind a green test: `I-FILE-179` in
/// `stdlib/io/socket_test.dart` breaks out of an `await for` over a socket, and
/// its catch-all — written for an unreachable network — reported the
/// interpreter error as a skip.
///
/// The cause was wider than `await for`. The async state machine sent a jump
/// to "the loop on top of `loopNodeStack`", and only `for` loops are pushed
/// there: `while` and `do` in an async body could not be left at all, a break
/// in a `while` nested in a `for` left the `for`, and labels were ignored. It
/// now reads the target from the AST. The synchronous visitor had its own
/// label defect — a label stayed in force for everything nested inside the
/// statement it was written on — and is covered in the last group.
///
/// Both loop-variable forms of `await for` are covered (`var v in` declares,
/// `v in` assigns an existing variable), because the two took different
/// branches of the state machine. The nesting cases pin the stack discipline:
/// a jump must leave exactly the loops between it and its target, and a loop
/// that was left early must not stay on a stack for the next one to find.
void main() {
  const gen = '''
    Stream<int> gen() async* { yield 1; yield 2; yield 3; }
  ''';

  group('SCD4: break and continue inside await for', () {
    test(
      'F-SCD4-01: break, declared loop variable [2026-09-11] (PASS)',
      () async {
        final result = await executeAsync('''
        $gen
        main() async {
          var seen = <int>[];
          await for (var v in gen()) {
            seen.add(v);
            if (v == 2) break;
          }
          return seen.join(',');
        }
      ''');
        expect(result, equals('1,2'));
      },
    );

    test(
      'F-SCD4-02: break, existing loop variable [2026-09-11] (PASS)',
      () async {
        final result = await executeAsync('''
        $gen
        main() async {
          var seen = <int>[];
          int v = 0;
          await for (v in gen()) {
            seen.add(v);
            if (v == 2) break;
          }
          return '\${seen.join(',')}|\$v';
        }
      ''');
        expect(result, equals('1,2|2'));
      },
    );

    test(
      'F-SCD4-03: continue, declared loop variable [2026-09-11] (PASS)',
      () async {
        final result = await executeAsync('''
        $gen
        main() async {
          var seen = <int>[];
          await for (var v in gen()) {
            if (v == 2) continue;
            seen.add(v);
          }
          return seen.join(',');
        }
      ''');
        expect(result, equals('1,3'));
      },
    );

    test(
      'F-SCD4-04: continue, existing loop variable [2026-09-11] (PASS)',
      () async {
        final result = await executeAsync('''
        $gen
        main() async {
          var seen = <int>[];
          int v = 0;
          await for (v in gen()) {
            if (v == 2) continue;
            seen.add(v);
          }
          return seen.join(',');
        }
      ''');
        expect(result, equals('1,3'));
      },
    );

    test('F-SCD4-05: break in an await-for body that awaits before breaking '
        '[2026-09-11] (PASS)', () async {
      // An await in the body suspends and resumes the frame, which is when
      // the loop's place on the stack is most likely to be lost.
      final result = await executeAsync('''
        $gen
        main() async {
          var seen = <int>[];
          await for (var v in gen()) {
            await Future.delayed(Duration(milliseconds: 1));
            seen.add(v);
            if (v == 2) break;
          }
          return seen.join(',');
        }
      ''');
      expect(result, equals('1,2'));
    });

    test('F-SCD4-06: a break in a sync for nested in await for leaves only '
        'the inner loop [2026-09-11] (PASS)', () async {
      final result = await executeAsync('''
        $gen
        main() async {
          var log = <String>[];
          await for (var a in gen()) {
            for (var b in [10, 20, 30]) {
              if (b == 20) break;
              log.add('\$a:\$b');
            }
            if (a == 2) break;
          }
          return log.join(',');
        }
      ''');
      expect(result, equals('1:10,2:10'));
    });

    test('F-SCD4-07: a break in an inner await for leaves only the inner '
        'loop [2026-09-11] (PASS)', () async {
      final result = await executeAsync('''
        $gen
        main() async {
          var log = <String>[];
          await for (var a in gen()) {
            await for (var b in gen()) {
              if (b == 2) break;
              log.add('\$a:\$b');
            }
            if (a == 2) continue;
            log.add('end\$a');
          }
          return log.join(',');
        }
      ''');
      expect(result, equals('1:1,end1,2:1,3:1,end3'));
    });

    test('F-SCD4-08: loops after a broken await for still break and continue '
        'correctly [2026-09-11] (PASS)', () async {
      // A loop left by `break` that stayed on the stack would be popped by
      // the NEXT loop's break, which would then leave the wrong loop.
      final result = await executeAsync('''
        $gen
        main() async {
          var log = <String>[];
          await for (var v in gen()) {
            if (v == 1) break;
          }
          await for (var v in gen()) {
            if (v == 2) continue;
            log.add('a\$v');
          }
          for (var i = 0; i < 5; i++) {
            if (i == 2) break;
            log.add('f\$i');
          }
          var n = 0;
          while (true) {
            n++;
            if (n < 3) continue;
            break;
          }
          log.add('w\$n');
          return log.join(',');
        }
      ''');
      expect(result, equals('a1,a3,f0,f1,w3'));
    });

    test('F-SCD4-09: a labelled break leaves the outer await for '
        '[2026-09-11] (PASS)', () async {
      final result = await executeAsync('''
        $gen
        main() async {
          var log = <String>[];
          outer:
          await for (var a in gen()) {
            for (var b in [10, 20]) {
              if (a == 2) break outer;
              log.add('\$a:\$b');
            }
          }
          return log.join(',');
        }
      ''');
      expect(result, equals('1:10,1:20'));
    });

    test(
      'F-SCD4-10: break stops the stream — the generator does not run '
      'past the element that was broken on [2026-09-11] (SKIP)',
      () async {
        // Dart cancels the subscription when an await-for is left early, so an
        // async* generator paused at `yield 2` never resumes.
        final result = await executeAsync('''
        var log = <String>[];
        Stream<int> gen() async* {
          yield 1;
          yield 2;
          log.add('resumed');
          yield 3;
        }
        main() async {
          await for (var v in gen()) {
            log.add('v\$v');
            if (v == 2) break;
          }
          await Future.delayed(Duration(milliseconds: 5));
          return log.join(',');
        }
      ''');
        expect(result, equals('v1,v2'));
      },
      skip:
          'sce16_aikt: `await for` reads the whole stream before running '
          'its body, and an async* generator runs to completion regardless '
          'of its listener, so the generator logs "resumed" before the loop '
          'body sees element 1.',
    );

    test('F-SCD4-11: break inside an await for inside a called async function '
        'returns to the caller normally [2026-09-11] (PASS)', () async {
      final result = await executeAsync('''
        $gen
        Future<int> firstAbove(int n) async {
          await for (var v in gen()) {
            if (v > n) return v;
          }
          return -1;
        }
        Future<int> countUntil(int n) async {
          var c = 0;
          await for (var v in gen()) {
            if (v == n) break;
            c++;
          }
          return c;
        }
        main() async {
          // Two awaits in one interpolation lose the string (sce17_aikt), so
          // each is awaited on its own.
          final above = await firstAbove(1);
          final count = await countUntil(3);
          return '\$above|\$count';
        }
      ''');
      expect(result, equals('2|2'));
    });
  });

  group('SCD4: break and continue in the other loops of an async body', () {
    // The same handler served every loop in an async body, and it only knew
    // about `for`: `while` and `do` could not be left at all, and a break in a
    // `while` nested in a `for` left the `for`.
    test('F-SCD4-12: while — break and continue [2026-09-11] (PASS)', () async {
      final result = await executeAsync('''
        main() async {
          var n = 0;
          var sum = 0;
          while (true) {
            n++;
            if (n == 2) continue;
            if (n == 5) break;
            sum += n;
          }
          return '\$n|\$sum';
        }
      ''');
      expect(result, equals('5|8'));
    });

    test('F-SCD4-13: do — break and continue [2026-09-11] (PASS)', () async {
      final result = await executeAsync('''
        main() async {
          var n = 0;
          var sum = 0;
          do {
            n++;
            if (n == 2) continue;
            if (n == 5) break;
            sum += n;
          } while (n < 10);
          return '\$n|\$sum';
        }
      ''');
      expect(result, equals('5|8'));
    });

    test('F-SCD4-14: a break in a while nested in a for leaves only the '
        'while [2026-09-11] (PASS)', () async {
      final result = await executeAsync('''
        main() async {
          var log = <int>[];
          for (var i = 0; i < 3; i++) {
            var k = 0;
            while (true) {
              k++;
              if (k == 2) break;
            }
            log.add(i * 10 + k);
          }
          return log.join(',');
        }
      ''');
      expect(result, equals('2,12,22'));
    });

    test('F-SCD4-15: a for-in left by break starts again from its first '
        'element when re-entered [2026-09-11] (PASS)', () async {
      // An iterator left behind by the break would be resumed at 30.
      final result = await executeAsync('''
        main() async {
          var log = <int>[];
          for (var o in [1, 2]) {
            for (var i in [10, 20, 30]) {
              if (i == 20) break;
              log.add(o * 100 + i);
            }
          }
          return log.join(',');
        }
      ''');
      expect(result, equals('110,210'));
    });

    test('F-SCD4-16: labelled break and continue across loops of an async '
        'body, with awaits in them [2026-09-11] (PASS)', () async {
      final result = await executeAsync('''
        main() async {
          var log = <String>[];
          outer:
          for (var i = 0; i < 3; i++) {
            var j = 0;
            while (j < 3) {
              await Future.value(0);
              j++;
              if (j == 2) continue outer;
              if (i == 2) break outer;
              log.add('\$i:\$j');
            }
          }
          return log.join(',');
        }
      ''');
      expect(result, equals('0:1,1:1'));
    });

    test('F-SCD4-17: a labelled loop in an async body is followed by the '
        'statements after it [2026-09-11] (PASS)', () async {
      // Stepping into the labelled statement exposed the next-statement
      // search skipping the rest of the enclosing block.
      final result = await executeAsync('''
        main() async {
          var log = <String>[];
          outer:
          for (var i in [1, 2]) {
            log.add('i\$i');
          }
          log.add('after');
          return log.join(',');
        }
      ''');
      expect(result, equals('i1,i2,after'));
    });

    test('F-SCD4-18: break leaves a labelled block in an async body '
        '[2026-09-11] (PASS)', () async {
      final result = await executeAsync('''
        main() async {
          var log = <String>[];
          block:
          {
            log.add('a');
            for (var i in [1, 2]) {
              if (i == 2) break block;
              log.add('i\$i');
            }
            log.add('not reached');
          }
          log.add('after');
          return log.join(',');
        }
      ''');
      expect(result, equals('a,i1,after'));
    });
  });

  group('SCD4: labels in synchronous code', () {
    // A label used to stay in force for everything inside the statement it was
    // written on, so an unlabelled inner loop took `break outer` and
    // `continue outer` as its own.
    test(
      'F-SCD4-19: break and continue to an outer for [2026-09-11] (PASS)',
      () async {
        final result = await executeAsync('''
        main() {
          var n = 0;
          outer:
          for (var i = 0; i < 3; i++) {
            for (var j = 0; j < 3; j++) {
              if (j == 1) continue outer;
              if (i == 2) break outer;
              n++;
            }
          }
          return n;
        }
      ''');
        expect(result, equals(2));
      },
    );

    test(
      'F-SCD4-20: break to an outer while and do [2026-09-11] (PASS)',
      () async {
        final result = await executeAsync('''
        main() {
          var log = <String>[];
          var i = 0;
          outer:
          while (i < 3) {
            i++;
            for (var j = 0; j < 3; j++) {
              if (i == 2) break outer;
              log.add('w\$i:\$j');
            }
          }
          var k = 0;
          loop:
          do {
            k++;
            for (var j in [1, 2]) {
              if (k == 2) break loop;
            }
          } while (k < 5);
          return '\${log.join(',')}|\$k';
        }
      ''');
        expect(result, equals('w1:0,w1:1,w1:2|2'));
      },
    );

    test('F-SCD4-21: a label on a block does not leak into the loop inside '
        'it [2026-09-11] (PASS)', () async {
      final result = await executeAsync('''
        main() {
          var log = <String>[];
          block:
          {
            for (var i in [1, 2, 3]) {
              if (i == 2) break block;
              log.add('i\$i');
            }
            log.add('not reached');
          }
          return log.join(',');
        }
      ''');
      expect(result, equals('i1'));
    });
  });
}
