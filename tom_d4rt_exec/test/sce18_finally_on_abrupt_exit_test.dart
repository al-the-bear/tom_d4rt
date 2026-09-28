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
// STILL BROKEN, DELIBERATELY NOT FIXED HERE: `break` and `continue` out of a
// try in an async body still skip its finally — see the last group, which pins
// today's wrong answers so the next change to this machinery cannot move them
// silently. That is scf6.

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

  group('SCE18: break and continue still skip their finally (scf6)', () {
    // NOT aspirational tests. They record what the interpreter does TODAY, so
    // that the next change to this machinery cannot move it without saying so —
    // and so that whoever takes scf6 has the before-picture already written
    // down. Each expectation names the Dart answer it is not yet giving.
    test(
      'F-SCE18-8: break skips the finally — today [2026-09-18] (PASS)',
      () async {
        final r = await both(
          "var log = [];"
          " for (var i in [1, 2]) { try { if (i == 1) break; }"
          " finally { log.add('f' + i.toString()); } }"
          " log.add('after');"
          " return log.join(',');",
        );
        expect(
          r.async,
          equals('after'),
          reason: 'Dart and the sync visitor answer f1,after — scf6',
        );
        expect(
          r.sync,
          equals('f1,after'),
          reason: 'the sync oracle is correct',
        );
      },
    );

    test(
      'F-SCE18-9: continue skips the finally — today [2026-09-18] (PASS)',
      () async {
        final r = await both(
          "var log = [];"
          " for (var i in [1, 2]) { try { if (i == 1) continue; }"
          " finally { log.add('f' + i.toString()); }"
          " log.add('b' + i.toString()); }"
          " return log.join(',');",
        );
        expect(
          r.async,
          equals('f2,b2'),
          reason: 'Dart and the sync visitor answer f1,f2,b2 — scf6',
        );
        expect(
          r.sync,
          equals('f1,f2,b2'),
          reason: 'the sync oracle is correct',
        );
      },
    );
  });
}
