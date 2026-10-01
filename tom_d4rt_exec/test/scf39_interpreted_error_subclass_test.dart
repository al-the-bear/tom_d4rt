// SCF39: an interpreted `Error` subclass answers `toString` and `stackTrace`
// as its own class, not as the native `Error` it is built on.
//
// `class MyError extends Error {}` is backed by a native `Error` super-object.
// Two answers came from that native object instead of the script's class:
//
//   * `MyError().toString()` printed `Instance of 'Error'` — the native
//     object's `Object.toString`, naming the NATIVE class — while `'$e'` on
//     the same value printed `<instance of MyError>`. A script with no
//     `toString` now gets the interpreter's own default both ways, and so
//     does `super.toString()` inside an override. A super-object that DOES
//     override `toString` (`ArgumentError`'s message) is still the answer,
//     now for interpolation too.
//   * `stackTrace` stayed null after a throw. Dart sets it on the first throw;
//     the native super-object is never thrown and its `stackTrace` cannot be
//     assigned, so the instance records one on its first throw.
//
// `<instance of C>` is this interpreter's default rendering for every script
// class (`runtime_types.dart`, `_diagnosticString`); Dart's is
// `Instance of 'C'`. The point here is that an Error subclass renders like
// every other script class, and that its two spellings agree.
//
// The analyzer-free twin is
// `tom_d4rt_ast/test/runtime/scf39_interpreted_error_subclass_test.dart`.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? _run(String source) => D4rt().execute(source: source);

void main() {
  group('SCF39: toString of an interpreted Error subclass', () {
    test('F-SCF39-1: no override renders as the script class, both ways '
        '[2026-09-30] (PASS)', () {
      expect(
        _run(
          'class MyError extends Error {} '
          "List main() { final e = MyError(); return [e.toString(), '\$e', "
          '[e].toString()]; }',
        ),
        [
          '<instance of MyError>',
          '<instance of MyError>',
          '[<instance of MyError>]',
        ],
      );
    });

    test('F-SCF39-2: an override still wins, and its super.toString() names '
        'the script class [2026-09-30] (PASS)', () {
      expect(
        _run(
          'class MyError extends Error { String toString() => "mine"; } '
          'String main() => MyError().toString();',
        ),
        'mine',
      );
      expect(
        _run(
          'class MyError extends Error { '
          'String toString() => "X:" + super.toString(); } '
          'String main() => MyError().toString();',
        ),
        'X:<instance of MyError>',
      );
    });

    test('F-SCF39-3: a super-object that overrides toString is the answer, '
        'both ways [2026-09-30] (PASS)', () {
      expect(
        _run(
          "class MyError extends ArgumentError { MyError() : super('x'); } "
          "List main() { final e = MyError(); return [e.toString(), '\$e']; }",
        ),
        ['Invalid argument(s): x', 'Invalid argument(s): x'],
      );
      expect(
        _run(
          "class MyError extends StateError { MyError() : super('x'); } "
          'String main() => MyError().toString();',
        ),
        'Bad state: x',
      );
    });
  });

  group('SCF39: stackTrace of an interpreted Error subclass', () {
    test('F-SCF39-4: null before a throw, set by the throw '
        '[2026-09-30] (PASS)', () {
      expect(
        _run(
          'class MyError extends Error {} '
          'List main() { final e = MyError(); final before = e.stackTrace; '
          'try { throw e; } catch (c) { '
          'return [before == null, (c as MyError).stackTrace != null]; } }',
        ),
        [true, true],
      );
    });

    test('F-SCF39-5: a second throw keeps the first stack trace '
        '[2026-09-30] (PASS)', () {
      expect(
        _run(
          'class MyError extends Error {} '
          'bool main() { final e = MyError(); '
          'try { throw e; } catch (_) {} final first = e.stackTrace; '
          'try { throw e; } catch (_) {} '
          'return first != null && identical(first, e.stackTrace); }',
        ),
        isTrue,
      );
    });

    test('F-SCF39-6: control — a class that is not an Error gets no '
        'stackTrace member [2026-09-30] (PASS)', () {
      expect(
        () => _run(
          'class NotAnError {} '
          'main() { try { throw NotAnError(); } catch (e) { '
          'return (e as dynamic).stackTrace; } }',
        ),
        throwsA(predicate((e) => '$e'.contains('stackTrace'))),
      );
    });
  });
}
