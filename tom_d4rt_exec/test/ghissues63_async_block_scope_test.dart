// ghissues63 — in an async function a block's local variable leaked out of
// the block and overwrote an outer one of the same name.
//
// Found 2026-11-16 while working on ghissues62; measured in both trees
// (identical) and in the published releases: `main() async { var x = 1;
// if (true) { var x = 2; } return x; }` answered 2 where Dart answers 1, a
// bare block, an else branch, a labelled or nested block, a finally block and
// `var x = await f()` inside a block did the same, and a closure created in a
// loop body captured ONE variable for every iteration (`[10, 10]` for
// `[0, 10]`).
//
// The async state machine runs a block's statements one by one, so a block's
// declarations went into the enclosing scope. Each block the machine enters
// now gets an environment of its own (`_blockEnvironmentFor`), created on
// entry and reused while the machine stays inside it, an `await` included; a
// loop body gets a fresh one every iteration. The table's expected values are
// what native Dart printed for each case.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// (label, source, what native Dart prints for main's value).
const _cases = <(String, String, String)>[
  (
    "1 if block",
    "main() async { var x = 1; if (true) { var x = 2; } return x; }",
    "1",
  ),
  (
    "2 if block await",
    "main() async { var x = 1; if (true) { var x = 2; await null; } return x; }",
    "1",
  ),
  (
    "3 bare block await",
    "main() async { var x = 1; { var x = 2; await null; } return x; }",
    "1",
  ),
  (
    "4 else block",
    "main() async { var x = 1; if (false) {} else { var x = 2; await null; } return x; }",
    "1",
  ),
  (
    "5 inner value visible",
    "main() async { var x = 1; var r = 0; { var x = 5; await null; r = x; } return [x, r]; }",
    "[1, 5]",
  ),
  (
    "6 loop in block",
    "main() async { var s = 0; { var k = 10; for (var i = 0; i < 3; i++) { await null; s += k + i; } } return s; }",
    "33",
  ),
  (
    "7 block in loop fresh",
    "main() async { var out = []; for (var i = 0; i < 3; i++) { var v; if (i == 0) v = 'set'; await null; out.add(v); } return out; }",
    "[set, null, null]",
  ),
  (
    "8 while body fresh",
    "main() async { var out = []; var i = 0; while (i < 2) { var v; if (i == 0) v = 1; await null; out.add(v); i++; } return out; }",
    "[1, null]",
  ),
  (
    "9 try in block",
    "main() async { var e = 'outer'; { var e2 = 'in'; try { await null; throw 'x'; } catch (e) { await null; e2 = '\$e2-\$e'; } return [e, e2]; } }",
    "[outer, in-x]",
  ),
  (
    "10 if-case in block",
    "main() async { var x = 1; { var y = 2; if (3 case int x) { await null; y = x + y; } return [x, y]; } }",
    "[1, 5]",
  ),
  (
    "11 closure captures block var",
    "main() async { var fs = <Function>[]; for (var i = 0; i < 2; i++) { var c = i * 10; await null; fs.add(() => c); } return fs.map((f) => f()).toList(); }",
    "[0, 10]",
  ),
  (
    "12 labelled block",
    "main() async { var x = 1; lbl: { var x = 2; await null; if (x == 2) break lbl; } return x; }",
    "1",
  ),
  (
    "13 assign outer from block",
    "main() async { var x = 1; { x = 7; await null; } return x; }",
    "7",
  ),
  (
    "14 var await in block",
    "Future<int> f() async => 9; main() async { var x = 1; { var x = await f(); } return x; }",
    "1",
  ),
  (
    "15 nested blocks",
    "main() async { var x = 1; { var x = 2; { var x = 3; await null; } await null; if (x != 2) return 'bad'; } return x; }",
    "1",
  ),
  (
    "16 switch in block",
    "main() async { var x = 1; { var x = 4; switch (x) { case 4: await null; } } return x; }",
    "1",
  ),
  (
    "17 do body fresh",
    "main() async { var out = []; var i = 0; do { var v; if (i == 0) v = 'a'; await null; out.add(v); i++; } while (i < 2); return out; }",
    "[a, null]",
  ),
  (
    "18 for-in body",
    "main() async { var out = []; for (final i in [1, 2]) { var v; if (i == 1) v = 'a'; await null; out.add(v); } return out; }",
    "[a, null]",
  ),
  (
    "19 sync fn unaffected",
    "main() { var x = 1; { var x = 2; } return x; }",
    "1",
  ),
  (
    "20 finally block",
    "main() async { var x = 1; try { await null; } finally { var x = 3; await null; } return x; }",
    "1",
  ),
];

void main() {
  group('ghissues63: a block is a scope in an async function', () {
    for (final (label, source, dart) in _cases) {
      test('GHI63-1 $label [2026-11-16]', () async {
        var result = D4rt().execute(source: source);
        if (result is Future) result = await result;
        expect('$result', dart);
      }, timeout: const Timeout(Duration(seconds: 30)));
    }
  });
}
