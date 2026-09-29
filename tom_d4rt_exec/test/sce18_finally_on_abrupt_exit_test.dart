// SCE18 — a `return` that unwinds through a `finally` in an async body.
//
// `try { return 'r'; } finally { l.add(1); } return 'end';` answered `'end'`.
// The return was recorded, the finally ran, and then the machine carried on
// with the statement after the try, which won.
//
// WHY IT LOOKED LIKE IT WORKED. `_findNextSequentialNode`'s "End of a Finally
// block" case never consulted `returnAfterFinally`; it always returned the node
// after the try. When the try is the LAST thing in the function there is no
// such node, the machine stops, and the exit at the bottom of the loop
// completes with the stored value — so every shape without a trailing statement
// answered correctly, which is why the mechanism reads as present.
//
// It is worse than a lost value: an ordinary statement between the inner try
// and an outer finally RAN. The nested case answered `end:A,MID,B` where Dart
// answers `x`. A function that is unwinding must execute nothing but the
// finally blocks between the return and the function boundary.
//
// THE SYNCHRONOUS VISITOR IS THE ORACLE HERE. Every case below is also written
// as a sync function, and those passed before this fix. Two interpreters in one
// package disagreeing about `finally` is the strongest possible statement that
// one of them is wrong, and it costs one extra `expect` per case.
//
// THE JUMP ROUTE (scf6): `break` and `continue` out of a try in an async body
// used to skip its finally, and the last group pinned those wrong answers. It
// now asserts the sync oracle's answers, for the jump shapes as well.

import 'package:test/test.dart';

import 'interpreter_test.dart';

void main() {
  /// Runs [body] as both an async and a synchronous `main`, and returns the
  /// pair. The sync answer is this interpreter's own reference behaviour.
  Future<({Object? async, Object? sync})> both(String body) async => (
    async: await executeAsync('main() async { $body }'),
    sync: await executeAsync('main() { $body }'),
  );

  group('SCE18: a return unwinds through the finallys it crosses', () {
    test('F-SCE18-1: a return before a trailing statement survives '
        '[2026-09-18] (PASS)', () async {
      final r = await both(
        "var l = []; try { return 'r'; } finally { l.add(1); } return 'end';",
      );
      expect(r.async, equals('r'));
      expect(r.sync, equals('r'), reason: 'the sync oracle');
    });

    test('F-SCE18-2: nested tries — both finallys run, then the return '
        '[2026-09-18] (PASS)', () async {
      final r = await both(
        "var log = [];"
        " try { try { return 'x'; } finally { log.add('A'); } }"
        " finally { log.add('B'); }"
        " return 'end';",
      );
      expect(r.async, equals('x'));
      expect(r.sync, equals('x'), reason: 'the sync oracle');
    });

    test('F-SCE18-3: a statement between the inner try and the outer finally '
        'is skipped [2026-09-18] (PASS)', () async {
      // The case that says this is an unwind and not merely a lost value:
      // `MID` must not run. Before the fix this answered 'end:A,MID,B'.
      final r = await both(
        "var log = [];"
        " try { try { return 'x'; } finally { log.add('A'); } log.add('MID'); }"
        " finally { log.add('B'); }"
        " return 'end:' + log.join(',');",
      );
      expect(r.async, equals('x'));
      expect(r.sync, equals('x'), reason: 'the sync oracle');
    });

    test('F-SCE18-4: the crossed finallys really did run, innermost first '
        '[2026-09-18] (PASS)', () async {
      // F-SCE18-2 proves the VALUE survives; this proves the side effects
      // happened, and in Dart's order. Without it, a fix that simply stopped
      // the machine at the return would pass F-SCE18-2 while skipping B.
      final r = await both(
        "var log = [];"
        " String join() { return log.join(','); }"
        " try { try { log.add('t'); } finally { log.add('A'); } }"
        " finally { log.add('B'); }"
        " return join();",
      );
      expect(r.async, equals('t,A,B'));
      expect(r.sync, equals('t,A,B'), reason: 'the sync oracle');
    });

    test('F-SCE18-5: a return after an await inside the try [2026-09-18] '
        '(PASS)', () async {
      // The async-only shape: the frame has already suspended and resumed once
      // before the return, so the pending-return slot has survived a
      // suspension.
      final result = await executeAsync(
        "main() async { var l = [];"
        " try { await Future.value(1); return 'r'; } finally { l.add(1); }"
        " return 'end'; }",
      );
      expect(result, equals('r'));
    });

    test('F-SCE18-6: an ordinary try/finally with no return is unaffected '
        '[2026-09-18] (PASS)', () async {
      final r = await both(
        "var log = [];"
        " try { log.add('t'); } finally { log.add('f'); }"
        " log.add('after');"
        " return log.join(',');",
      );
      expect(r.async, equals('t,f,after'));
      expect(r.sync, equals('t,f,after'), reason: 'the sync oracle');
    });

    test(
      'F-SCE18-7: an empty finally still returns [2026-09-18] (PASS)',
      () async {
        // The walk skips an empty finally rather than scheduling a no-op, so this
        // is the case that would hang or misroute if that skip were wrong.
        final r = await both("try { return 'r'; } finally { } return 'end';");
        expect(r.async, equals('r'));
        expect(r.sync, equals('r'), reason: 'the sync oracle');
      },
    );
  });

  group('SCF6: break and continue run the finallys they cross', () {
    // These pinned TODAY'S WRONG ANSWERS until scf6 ('after' and 'f2,b2'); the
    // synchronous visitor has always been right and is the oracle for every
    // case, so each asserts async == sync == Dart.
    Future<void> agree(String body, String dart) async {
      final r = await both(body);
      expect(r.sync, equals(dart), reason: 'the sync oracle');
      expect(r.async, equals(dart));
    }

    test(
      'F-SCE18-8: break runs the finally it crosses [2026-09-29] (PASS)',
      () async {
        await agree(
          "var log = [];"
              " for (var i in [1, 2]) { try { if (i == 1) break; }"
              " finally { log.add('f' + i.toString()); } }"
              " log.add('after');"
              " return log.join(',');",
          'f1,after',
        );
      },
    );

    test('F-SCE18-9: continue runs the finally, then the next iteration '
        '[2026-09-29] (PASS)', () async {
      await agree(
        "var log = [];"
            " for (var i in [1, 2]) { try { if (i == 1) continue; }"
            " finally { log.add('f' + i.toString()); }"
            " log.add('b' + i.toString()); }"
            " return log.join(',');",
        'f1,f2,b2',
      );
    });

    test('F-SCF6-1: two tries between the break and its loop run innermost '
        'first, and nothing between them [2026-09-29] (PASS)', () async {
      await agree(
        "var log = [];"
            " for (var i in [1, 2]) {"
            "   try { try { break; } finally { log.add('A'); } log.add('MID'); }"
            "   finally { log.add('B'); }"
            " }"
            " log.add('after');"
            " return log.join(',');",
        'A,B,after',
      );
    });

    test('F-SCF6-2: a return inside the crossed finally overrides the break '
        '[2026-09-29] (PASS)', () async {
      await agree(
        "var log = [];"
            " for (var i in [1, 2]) { try { break; } finally { return 'r'; } }"
            " return 'after';",
        'r',
      );
    });

    test('F-SCF6-3: a labelled break out of two loops runs a finally that is '
        'not inside the inner loop [2026-09-29] (PASS)', () async {
      await agree(
        "var log = [];"
            " outer: for (var i in [1, 2]) {"
            "   try { for (var j in [1, 2]) { if (j == 2) break outer; log.add('j' + j.toString()); } }"
            "   finally { log.add('f' + i.toString()); }"
            " }"
            " log.add('after');"
            " return log.join(',');",
        'j1,f1,after',
      );
    });

    test('F-SCF6-4: a finally whose try is OUTSIDE the target loop does not '
        'run on the break [2026-09-29] (PASS)', () async {
      await agree(
        "var log = [];"
            " try { for (var i in [1, 2]) { if (i == 1) break; } log.add('after'); }"
            " finally { log.add('F'); }"
            " return log.join(',');",
        'after,F',
      );
    });

    test('F-SCF6-5: a break local to a loop INSIDE the running finally keeps '
        'the pending jump [2026-09-29] (PASS)', () async {
      await agree(
        "var log = [];"
            " for (var i in [1, 2]) {"
            "   try { break; }"
            "   finally { for (var k in [1, 2]) { log.add('k' + k.toString()); break; } }"
            "   log.add('body');"
            " }"
            " log.add('after');"
            " return log.join(',');",
        'k1,after',
      );
    });

    test('F-SCF6-6: a throw inside the crossed finally overrides the break '
        '[2026-09-29] (PASS)', () async {
      await agree(
        "var log = [];"
            " try {"
            "   for (var i in [1, 2]) { try { break; } finally { throw 'x'; } }"
            "   log.add('after');"
            " } catch (e) { log.add('caught ' + e.toString()); }"
            " return log.join(',');",
        'caught x',
      );
    });

    test('F-SCF6-7: an await inside the crossed finally is resumed, then the '
        'jump completes [2026-09-29] (PASS)', () async {
      final r = await executeAsync(
        "main() async { var log = [];"
        " for (var i in [1, 2]) { try { if (i == 1) break; }"
        " finally { await Future.value(0); log.add('f' + i.toString()); } }"
        " log.add('after');"
        " return log.join(','); }",
      );
      expect(r, equals('f1,after'));
    });
  });
}
