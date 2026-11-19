// ghissues62 — an `await` inside an expression or statement form that did not
// hand its suspension up.
//
// Found 2026-11-16 while testing ghissues60; measured in both trees
// (identical) and in the published releases:
//
//   * `(await n()) is int` answered false, `is!` true; `(await n()) as int`
//     cast the interpreter's own AsyncSuspensionRequest; a conditional, a
//     switch expression (scrutinee and guard), a record literal and adjacent
//     strings used the request as a value.
//   * a switch statement, an `assert`, a pattern declaration or assignment
//     and a `throw` had no resumption: the function completed with null, and
//     `throw await f()` and an await in a `for` condition spun for ever.
//   * an if-case in an async function failed even WITHOUT an await ("If
//     condition must evaluate to a boolean, but got int"): the state machine
//     ran it as a plain condition.
//   * an async function returning `Future<(int, int)>` could not be declared
//     ("Type '(int, int)' not found"): the type between `<` and `>` was looked
//     up as text.
//
// Every expression visitor now returns the suspension; those statements are
// re-entered whole with the resolved awaits replaying; the machine matches an
// if-case and binds its variables in a scope its then branch runs in; a `for`
// whose condition suspended re-evaluates the condition. The table's expected
// values are what native Dart printed for each case.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

const _prelude =
    "class P { final int a; final int b; P(this.a, this.b); } class C { int v = 0; } Future<int> n() async => 3; Future<bool> t() async => true; Future<(int, int)> rec() async => (1, 2); Future<P> pp() async => P(4, 5); Future<C> cc() async => C(); Future<List<int>> l() async => [7, 8]; Future<Object?> nul() async => null;";

/// (label, main, what native Dart prints for main's value).
const _cases = <(String, String, String)>[
  ("is", "main() async => (await n()) is int;", "true"),
  ("is!", "main() async => (await n()) is! int;", "false"),
  ("!is", "main() async => !((await n()) is int);", "false"),
  ("as", "main() async => (await n()) as int;", "3"),
  ("?: cond", "main() async => (await t()) ? 'y' : 'n';", "y"),
  ("?: then", "main() async => true ? await n() : 0;", "3"),
  (
    "switch expr",
    "main() async => switch (await n()) { 3 => 'three', _ => 'other' };",
    "three",
  ),
  (
    "switch expr guard",
    "main() async => switch (3) { int x when await t() => 'g', _ => 'other' };",
    "g",
  ),
  (
    "switch expr body",
    "main() async => switch (3) { 3 => await n(), _ => 0 };",
    "3",
  ),
  (
    "switch stmt",
    "main() async { switch (await n()) { case 3: return 'three'; default: return 'other'; } }",
    "three",
  ),
  (
    "switch stmt guard",
    "main() async { switch (3) { case int x when await t(): return 'g'; default: return 'o'; } }",
    "g",
  ),
  (
    "if-case",
    "main() async { if ((await n()) case int x) return x; return -1; }",
    "3",
  ),
  (
    "if-case guard",
    "main() async { if (3 case int x when await t()) return x; return -1; }",
    "3",
  ),
  ("record", "main() async => ((await n()), 1);", "(3, 1)"),
  ("record named", "main() async => (a: await n(), b: 1);", "(a: 3, b: 1)"),
  (
    "pattern var record",
    "main() async { var (a, b) = await rec(); return a + b; }",
    "3",
  ),
  (
    "pattern var object",
    "main() async { var P(:a, :b) = await pp(); return a + b; }",
    "9",
  ),
  (
    "pattern var list",
    "main() async { var [x, y] = await l(); return x + y; }",
    "15",
  ),
  (
    "pattern assign",
    "main() async { int a, b; (a, b) = await rec(); return a * 10 + b; }",
    "12",
  ),
  ("cascade target", "main() async => ((await cc())..v = 5).v;", "5"),
  ("assert", "main() async { assert(await t()); return 'ok'; }", "ok"),
  (
    "assert msg",
    "main() async { assert(true, await n()); return 'ok'; }",
    "ok",
  ),
  (
    "while cond",
    "main() async { var i = 0; while (i < 1 && await t()) { i++; } return i; }",
    "1",
  ),
  (
    "for cond",
    "main() async { var i = 0; for (; i < (await n()); i++) {} return i; }",
    "3",
  ),
  (
    "do cond",
    "main() async { var i = 0; do { i++; } while (i < (await n())); return i; }",
    "3",
  ),
  (
    "throw",
    "main() async { try { throw await n(); } catch (e) { return e; } }",
    "3",
  ),
  ("?? rhs", "main() async => (await nul()) ?? await n();", "3"),
  ("|| rhs", "main() async => false || await t();", "true"),
  ("instance arg", "main() async => P(await n(), 1).a;", "3"),
  (
    "named arg",
    "main() async { int f({required int x}) => x; return f(x: await n()); }",
    "3",
  ),
  ("index key", "main() async => [1,2,3,4][await n()];", "4"),
  ("set literal", "main() async => {await n()};", "{3}"),
  ("if element", "main() async => [if (await t()) 1 else 2];", "[1]"),
  ("for element", "main() async => [for (var i in await l()) i];", "[7, 8]"),
  ("string juxt", "main() async => 'a\${await n()}b' 'c';", "a3bc"),
  (
    "return await is",
    "main() async { final r = await n() is int; return r; }",
    "true",
  ),
  (
    "nested is",
    "main() async => [(await n()) is int, (await t()) is bool];",
    "[true, true]",
  ),
  ("await in ?: both", "main() async => (await t()) ? await n() : 0;", "3"),
  (
    "list-pattern switch",
    "main() async => switch (await l()) { [7, var y] => y, _ => -1 };",
    "8",
  ),
  (
    "local fn",
    "main() async { Future<bool> f() async => (await n()) is int; return await f(); }",
    "true",
  ),
  (
    "arrow method",
    "class Q { Future<bool> m() async => (await n()) is int; } main() async => await Q().m();",
    "true",
  ),
];

Future<String> _run(String source) async {
  var result = D4rt().execute(source: source);
  if (result is Future) result = await result;
  return '$result';
}

void main() {
  group('ghissues62: every form answers what Dart answers', () {
    for (final (label, main, dart) in _cases) {
      test(
        'GHI62-1 $label [2026-11-16]',
        () async => expect(await _run('$_prelude\n$main'), dart),
        timeout: const Timeout(Duration(seconds: 30)),
      );
    }
  });

  group('ghissues62: if-case in an async function', () {
    test('GHI62-2: with and without an await, a guard, a loop, a catch '
        '[2026-11-16]', () async {
      expect(
        await _run('main() async { if (3 case int x) return x; return -1; }'),
        '3',
      );
      expect(
        await _run(
          'main() async { if (3 case String x) return x; return -1; }',
        ),
        '-1',
      );
      expect(
        await _run(
          'main() async { if ((1, 2) case (var a, var b) when a < b) '
          '{ return a + b; } else { return 0; } }',
        ),
        '3',
      );
      expect(
        await _run(
          'main() async { var out = []; for (var i = 0; i < 3; i++) '
          '{ if (i case int v when v.isOdd) { await null; out.add(v); } } '
          'return out; }',
        ),
        '[1]',
      );
      expect(
        await _run(
          "main() async { if (3 case int x) { try { throw 'e'; } catch (e) "
          r"{ await null; return '$x$e'; } } return '-'; }",
        ),
        '3e',
      );
    });

    test('GHI62-3: the pattern variable is scoped to the then branch '
        '[2026-11-16]', () async {
      expect(
        await _run(
          'main() async { var x = 1; if (5 case int x) { await null; } '
          'return x; }',
        ),
        '1',
      );
    });
  });

  group('ghissues62: Future of a record type', () {
    test('GHI62-4: an async function declares Future<(int, int)> and '
        'Future<({int a})> [2026-11-16]', () async {
      expect(
        await _run(
          'Future<(int, int)> rec() async => (1, 2); '
          'Future<({int a})> f() async => (a: 3); '
          r'main() async => (await rec()).$1 + (await f()).a;',
        ),
        '4',
      );
    });
  });
}
