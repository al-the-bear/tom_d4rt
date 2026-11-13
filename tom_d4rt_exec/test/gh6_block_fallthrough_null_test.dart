// Pull request al-the-bear/tom_d4rt#6 — a block-bodied function that runs off
// its end returns null.
//
// Reproduced 2026-11-06 on tom_d4rt 1.229.0 and re-measured 2026-11-07 on
// 1.234.0: `int probe() => 41; Object? f() { probe(); }` returned 41, and
// `Future<Object?> f() async { await probe(); }` completed with 41; Dart gives
// null for both. The interpreter returned the value of a block body's LAST
// STATEMENT (executeBlock's carry value), and an async body completed with its
// last result or its last await's result. Only `return` yields a value: a
// block body that runs off its end returns null, sync and async, in every kind
// of callable; an expression body keeps its value.
//
// The cases follow the PR's description (trailing values and Futures, await,
// try/finally, explicit returns, expression bodies, constructors); the fix is
// this repo's own.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Future<Object?> run(String source) async {
  final result = D4rt().execute(source: source, name: 'main');
  return result is Future ? await result : result;
}

void main() {
  group('PR #6: sync block bodies return null when they run off the end', () {
    test('GH6-1: a trailing call, literal or Future is not returned '
        '[2026-11-07]', () async {
      expect(
        await run(
          'int probe() => 41;\n'
          'Object? call() { probe(); }\n'
          'Object? literal() { 41; }\n'
          'Object? future() { Future.value(41); }\n'
          'main() => [call(), literal(), future()];',
        ),
        [null, null, null],
      );
    });

    test('GH6-2: nor the last value of a branch, loop, switch or try/finally '
        '[2026-11-07]', () async {
      expect(
        await run(
          'Object? branch(bool b) { if (b) { 41; } else { 42; } }\n'
          'Object? loop() { for (var i = 0; i < 2; i++) { i; } }\n'
          'Object? sw(int x) { switch (x) { case 1: 41; } }\n'
          'Object? tf() { try { 41; } finally { 42; } }\n'
          'Object? tc() { try { throw 1; } catch (_) { 43; } }\n'
          'main() => [branch(true), branch(false), loop(), sw(1), tf(), tc()];',
        ),
        [null, null, null, null, null, null],
      );
    });

    test('GH6-3: in every kind of callable [2026-11-07]', () async {
      expect(
        await run(
          'class C {\n'
          '  Object? m() { 41; }\n'
          '  Object? get g { 41; }\n'
          '  static Object? s() { 41; }\n'
          '}\n'
          'extension E on int { Object? ext() { this + 1; } }\n'
          'main() {\n'
          '  Object? local() { 41; }\n'
          '  final closure = () { 41; };\n'
          '  return [C().m(), C().g, C.s(), 1.ext(), local(), closure()];\n'
          '}',
        ),
        [null, null, null, null, null, null],
      );
    });

    test('GH6-4: explicit returns and expression bodies keep their value; a '
        'constructor still yields its instance [2026-11-07]', () async {
      expect(
        await run(
          'Object? ret() { 41; return 7; }\n'
          'Object? early(bool b) { if (b) return 1; 2; }\n'
          'Object? bare() { 41; return; }\n'
          'int expr() => 41;\n'
          'class P { int v = 0; P() { v = 5; v + 1; } }\n'
          'main() => [ret(), early(true), early(false), bare(), expr(), P().v];',
        ),
        [7, 1, null, null, 41, 5],
      );
    });
  });

  group('PR #6: async block bodies complete with null when they run off the '
      'end', () {
    test(
      'GH6-5: a trailing await or value is not the result [2026-11-07]',
      () async {
        expect(
          await run(
            'int probe() => 41;\n'
            'Future<Object?> awaited() async { await probe(); }\n'
            'Future<Object?> delayed() async {\n'
            '  await Future.delayed(Duration(milliseconds: 1)); 41; }\n'
            'Future<Object?> value() async { 41; }\n'
            'Future<Object?> tf() async { try { await probe(); } finally { 42; } }\n'
            'main() async => [await awaited(), await delayed(), await value(),\n'
            '  await tf()];',
          ),
          [null, null, null, null],
        );
      },
    );

    test('GH6-6: async closures and methods too [2026-11-07]', () async {
      expect(
        await run(
          'class C { Future<Object?> m() async { await Future.value(41); } }\n'
          'main() async {\n'
          '  final closure = () async { await Future.value(41); };\n'
          '  return [await closure(), await C().m()];\n'
          '}',
        ),
        [null, null],
      );
    });

    test('GH6-7: returns, expression bodies and awaits mid-body still work '
        '[2026-11-07]', () async {
      expect(
        await run(
          'Future<int> ret() async { await Future.value(1); return 7; }\n'
          'Future<int> expr() async => 7;\n'
          'Future<int> awaitExpr() async => await Future.value(8);\n'
          'Future<int> loop() async {\n'
          '  var t = 0;\n'
          '  for (var i = 1; i <= 3; i++) { t += await Future.value(i); }\n'
          '  return t;\n'
          '}\n'
          'Future<String> caught() async {\n'
          "  try { await Future.error('x'); } catch (e) { return 'caught \$e'; }\n"
          "  return 'no';\n"
          '}\n'
          'main() async => [await ret(), await expr(), await awaitExpr(),\n'
          '  await loop(), await caught()];',
        ),
        [7, 7, 8, 6, 'caught x'],
      );
    });
  });
}
