/// GitHub al-the-bear/tom_d4rt#10 on the BUNDLE PATH: static and top-level
/// initializers that read a declaration made after them, compiled with
/// `createBundleFromSource`, sent through `toBytes` / `fromBytes` as an app
/// receives a bundle, and run by `D4rtRunner`.
///
/// `gh10_static_forward_reference_test.dart` next door is the verbatim port of
/// the analyzer-based suite and runs the same cases through `execute(source:)`.
/// This file is its bundle half, which has no counterpart in `tom_d4rt` and so
/// can only be pinned here; splitting them keeps the shared-name file a
/// verbatim port (see `_plan_e2_static_in_closure_bundle_test.dart`). Lazy
/// initialization is decided at runtime from the declarations the bundle
/// carries, so a bundle that lost a declaration's order or its initializer
/// would read differently here and nowhere else.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// [source] compiled to a bundle, serialised and read back, then run.
Future<Object?> run(String source) async {
  final bundle = await D4rt().createBundleFromSource(source);
  final received = AstBundle.fromBytes(bundle.toBytes());
  return D4rtRunner().executeBundle(received);
}

/// Cases whose `main` answers a value: (id, source, expected).
const _values = <(String, String, Object?)>[
  (
    'GH10-1 unqualified forward reference',
    "class Config { static const values = [base]; static const base = 'x'; }\n"
        'main() => Config.values.single;',
    'x',
  ),
  (
    'GH10-2 qualified forward reference',
    'class Config { static const values = [Config.base]; '
        "static const base = 'x'; }\n"
        'main() => Config.values.single;',
    'x',
  ),
  (
    'GH10-3 dependency declared first',
    "class Config { static const base = 'x'; static const values = [base]; }\n"
        'main() => Config.values.single;',
    'x',
  ),
  (
    'GH10-4 a class nobody reads is not initialized',
    "class Config { static const values = [base]; static const base = 'x'; }\n"
        "main() => 'ready';",
    'ready',
  ),
  (
    'GH10-4 an unread class runs no initializer',
    'final log = <String>[];\n'
        "String note(String s) { log.add(s); return s; }\n"
        "class Config { static final a = note('a'); static final b = note('b'); }\n"
        'main() => log.length;',
    0,
  ),
  (
    'GH10-5 first read, read order, once',
    'final log = <String>[];\n'
        "String note(String s) { log.add(s); return s; }\n"
        "class Config { static final a = note('a'); static final b = note('b'); }\n"
        'main() { Config.b; Config.a; Config.b; return log; }',
    ['b', 'a'],
  ),
  (
    'GH10-6 a write before the first read skips the initializer',
    'final log = <String>[];\n'
        "String note(String s) { log.add(s); return s; }\n"
        "class Config { static String v = note('init'); }\n"
        "main() { Config.v = 'set'; return [Config.v, log]; }",
    ['set', <String>[]],
  ),
  (
    'GH10-8 a throwing initializer runs again on the next read',
    'var calls = 0;\n'
        "int risky() { calls++; if (calls == 1) throw 'first'; return calls; }\n"
        'class Config { static final v = risky(); }\n'
        'main() { try { Config.v; } catch (_) {} return [Config.v, calls]; }',
    [2, 2],
  ),
  (
    'GH10-9 statics from every kind of member',
    "class K { static final f = () => 'f'; static int n = 0;\n"
        '  static String s() { n++; return f(); }\n'
        '  String i() { n++; return f(); } }\n'
        'main() => [K.s(), K().i(), K.n, K.f()];',
    ['f', 'f', 2, 'f'],
  ),
  (
    'GH10-9 instance initializer and constructor read a forward static',
    'class C { final v = later; C() : w = later + 1; final int w;\n'
        '  static const later = 41; }\n'
        'main() { final c = C(); return [c.v, c.w]; }',
    [41, 42],
  ),
  (
    'GH10-10 late statics',
    'class L { static late final int x; static late int y = 5; }\n'
        'main() { L.x = 1; L.y++; return [L.x, L.y]; }',
    [1, 6],
  ),
  (
    'GH10-11 top-level variables read later declarations',
    "final values = [base];\nconst base = 'x';\n"
        'main() => values.single;',
    'x',
  ),
  (
    'GH10-12 top-level variables on first read',
    'final log = <String>[];\n'
        "String note(String s) { log.add(s); return s; }\n"
        "final a = note('a');\nfinal b = note('b');\nfinal unused = note('u');\n"
        'main() { b; a; b; return log; }',
    ['b', 'a'],
  ),
  (
    'GH10-13 every read and write shape',
    "const kind = 'b';\n"
        'var counter = 1;\n'
        'final twice = (int x) => x * 2;\n'
        'int withDefault([int x = later]) => x;\n'
        'const later = 7;\n'
        'class K { static get g => () => later; }\n'
        'String pick(String s) { switch (s) { case kind: return later.toString(); '
        "default: return 'no'; } }\n"
        'main() { counter++; ++counter; counter += 10;\n'
        "  return [pick('b'), withDefault(), twice(counter), K.g()]; }",
    ['7', 7, 26, 7],
  ),
];

/// Cases that must fail naming the cyclic read: (id, source).
const _cycles = <(String, String)>[
  (
    'GH10-7 a static read during its own initialization',
    'class Config { static const a = b; static const b = a; }\n'
        'main() => Config.a;',
  ),
  (
    'GH10-12 a cycle among top-level variables',
    'final a = b;\nfinal b = a;\nmain() => a;',
  ),
];

void main() {
  group('gh10 on the bundle path: initializers read later declarations', () {
    for (final (id, source, expected) in _values) {
      test('$id [2026-11-13]', () async {
        expect(await run(source), expected);
      });
    }
    for (final (id, source) in _cycles) {
      test('$id is an error, not a hang [2026-11-13]', () async {
        await expectLater(
          run(source),
          throwsA(
            predicate(
              (Object e) => e.toString().contains('during its initialization'),
              'names the cyclic read',
            ),
          ),
        );
      }, timeout: const Timeout(Duration(seconds: 30)));
    }
  });
}
