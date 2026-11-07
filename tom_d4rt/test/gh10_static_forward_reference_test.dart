// GitHub al-the-bear/tom_d4rt#10 — a static field initializer that reads a
// static declared after it.
//
// Reported from a Slang 4.19.2 project; reproduced 2026-11-06 on tom_d4rt
// 1.229.0 and re-measured 2026-11-07 on 1.232.0:
//
//     class Config { static const values = [base]; static const base = 'x'; }
//     main() => Config.values.single;   // Undefined variable: base (Dart: 'x')
//     main() => [Config.base] ...       // null                      (Dart: 'x')
//     main() => 'ready';                // Undefined variable: base (Dart: 'ready')
//
// The interpreter evaluated every static initializer of a class eagerly, in
// declaration order, when the class was loaded: a sibling declared later was
// not defined yet (or read as the `null` it was pre-registered with), and a
// class nobody read was evaluated anyway. Dart initializes a static field on
// its first read, so declaration order does not matter and an unread class
// runs nothing. Static fields with an initializer are now initialized on first
// access; reading one during its own initialization is an error, not a hang.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String source) => D4rt().execute(source: source, name: 'main');

void main() {
  group('gh10: static initializers read siblings declared later', () {
    test('GH10-1: unqualified forward reference [2026-11-07]', () {
      expect(
        run(
          "class Config { static const values = [base]; static const base = 'x'; }\n"
          'main() => Config.values.single;',
        ),
        'x',
      );
    });

    test('GH10-2: qualified forward reference [2026-11-07]', () {
      expect(
        run(
          'class Config { static const values = [Config.base]; '
          "static const base = 'x'; }\n"
          'main() => Config.values.single;',
        ),
        'x',
      );
    });

    test('GH10-3: dependency declared first still works [2026-11-07]', () {
      expect(
        run(
          "class Config { static const base = 'x'; static const values = [base]; }\n"
          'main() => Config.values.single;',
        ),
        'x',
      );
    });

    test('GH10-4: a class nobody reads is not initialized [2026-11-07]', () {
      expect(
        run(
          "class Config { static const values = [base]; static const base = 'x'; }\n"
          "main() => 'ready';",
        ),
        'ready',
      );
      // And its initializers do not run: a side effect shows it.
      expect(
        run(
          'final log = <String>[];\n'
          "String note(String s) { log.add(s); return s; }\n"
          "class Config { static final a = note('a'); static final b = note('b'); }\n"
          'main() => log.length;',
        ),
        0,
      );
    });

    test('GH10-5: initializers run on first read, in read order, once '
        '[2026-11-07]', () {
      expect(
        run(
          'final log = <String>[];\n'
          "String note(String s) { log.add(s); return s; }\n"
          "class Config { static final a = note('a'); static final b = note('b'); }\n"
          'main() { Config.b; Config.a; Config.b; return log; }',
        ),
        ['b', 'a'],
      );
    });

    test('GH10-6: a write before the first read skips the initializer '
        '[2026-11-07]', () {
      expect(
        run(
          'final log = <String>[];\n'
          "String note(String s) { log.add(s); return s; }\n"
          "class Config { static String v = note('init'); }\n"
          "main() { Config.v = 'set'; return [Config.v, log]; }",
        ),
        ['set', <String>[]],
      );
    });

    test('GH10-7: reading a static during its own initialization is an error, '
        'not a hang [2026-11-07]', () {
      expect(
        () => run(
          'class Config { static const a = b; static const b = a; }\n'
          'main() => Config.a;',
        ),
        throwsA(
          predicate(
            (Object e) => e.toString().contains('during its initialization'),
            'names the cyclic read',
          ),
        ),
      );
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('GH10-8: an initializer that throws leaves the field uninitialized, '
        'and the next read runs it again [2026-11-07]', () {
      expect(
        run(
          'var calls = 0;\n'
          "int risky() { calls++; if (calls == 1) throw 'first'; return calls; }\n"
          'class Config { static final v = risky(); }\n'
          'main() { try { Config.v; } catch (_) {} return [Config.v, calls]; }',
        ),
        [2, 2],
      );
    });

    test('GH10-9: static fields still work from every kind of member '
        '[2026-11-07]', () {
      // A function-valued static called by its bare name, from a static and
      // an instance member; a static read and incremented from both.
      expect(
        run(
          "class K { static final f = () => 'f'; static int n = 0;\n"
          '  static String s() { n++; return f(); }\n'
          '  String i() { n++; return f(); } }\n'
          'main() => [K.s(), K().i(), K.n, K.f()];',
        ),
        ['f', 'f', 2, 'f'],
      );
      // An instance initializer and a constructor read a forward static.
      expect(
        run(
          'class C { final v = later; C() : w = later + 1; final int w;\n'
          '  static const later = 41; }\n'
          'main() { final c = C(); return [c.v, c.w]; }',
        ),
        [41, 42],
      );
    });

    test('GH10-10: late statics keep their semantics [2026-11-07]', () {
      expect(
        run(
          'class L { static late final int x; static late int y = 5; }\n'
          'main() { L.x = 1; L.y++; return [L.x, L.y]; }',
        ),
        [1, 6],
      );
    });

    test('GH10-11: top-level variables read later declarations '
        '[2026-11-07]', () {
      expect(
        run(
          "final values = [base];\nconst base = 'x';\n"
          'main() => values.single;',
        ),
        'x',
      );
    });

    test('GH10-12: top-level variables are initialized on first read, and a '
        'cycle among them is an error [2026-11-07]', () {
      expect(
        run(
          'final log = <String>[];\n'
          "String note(String s) { log.add(s); return s; }\n"
          "final a = note('a');\nfinal b = note('b');\nfinal unused = note('u');\n"
          'main() { b; a; b; return log; }',
        ),
        ['b', 'a'],
      );
      expect(
        () => run('final a = b;\nfinal b = a;\nmain() => a;'),
        throwsA(
          predicate(
            (Object e) => e.toString().contains('during its initialization'),
          ),
        ),
      );
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('GH10-13: lazily initialized names in every read and write shape '
        '[2026-11-07]', () {
      expect(
        run(
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
        ),
        ['7', 7, 26, 7],
      );
    });
  });
}
