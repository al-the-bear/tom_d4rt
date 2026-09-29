// SCE234 — a bare bridged class name and the `Type` it denotes are ONE object
// to `identical` and `identityHashCode`, as they are in Dart.
//
// SCD198 made `String == 'x'.runtimeType` true and gave the two one hash code,
// and deliberately did not pin identity. `identical(String, 'x'.runtimeType)`
// stayed false where Dart says true.
//
// THE FIX IS THE CARRIER RULE `identical` ALREADY HAD. A native proxy and the
// interpreted instance behind it were already one object to it; a class name's
// `BridgedClass` and the native `Type` are the same situation. Option (a) of
// the todo — making every class-name expression evaluate to the native `Type` —
// was measured and not taken. The interpreted half it worried about already
// agrees (both sides are the same `InterpretedClass`), and the only spellings
// the bridged half gets wrong are identity ones plus the method-stored hash
// keys that scf40 carries.
//
// Every expectation was computed against real Dart. `identical(List,
// [1].runtimeType)` is false in Dart as well: that is `List<int>`.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String expression) =>
    D4rt().execute(source: 'class A {}\nObject? main() => $expression;');

void main() {
  group('SCE234: class-name identity', () {
    test('F-SCE234-1: a bridged class name is identical to the runtime type '
        'of its instances [2026-09-29] (PASS)', () {
      expect(_run("identical(String, 'x'.runtimeType)"), isTrue);
      expect(_run('identical(int, 1.runtimeType)'), isTrue);
      expect(_run('identical(String, String)'), isTrue);
    });

    test('F-SCE234-2: identityHashCode agrees with identical [2026-09-29] '
        '(PASS)', () {
      expect(
        _run("identityHashCode(String) == identityHashCode('x'.runtimeType)"),
        isTrue,
      );
    });

    test('F-SCE234-3: different types stay non-identical [2026-09-29] '
        '(PASS)', () {
      expect(_run('identical(String, int)'), isFalse);
      expect(_run("identical(String, 1.runtimeType)"), isFalse);
      // Dart: `List` is `List<dynamic>`, `[1].runtimeType` is `List<int>`.
      expect(_run('identical(List, [1].runtimeType)'), isFalse);
    });

    test('F-SCE234-4 (control): an interpreted class already agreed '
        '[2026-09-29] (PASS)', () {
      expect(_run('identical(A, A().runtimeType)'), isTrue);
      expect(
        _run('identityHashCode(A) == identityHashCode(A().runtimeType)'),
        isTrue,
      );
    });
  });
}
