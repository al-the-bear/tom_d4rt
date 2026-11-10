// ghissues12 — in an `async` function a native error from a bridged call is
// caught as itself, as in a synchronous one.
//
// Measured 2026-11-09 on this tree (1.239.0): inside an `async` function an
// error THROWN BY NATIVE CODE behind a bridged call (`List.add` on an
// unmodifiable list, `int.parse`) reached the catch clause wrapped in the
// RuntimeD4rtException the bridge adapter raised: `on FormatException` did not
// match, `e is UnsupportedError` was false, and `e.runtimeType` named the
// wrapper. The synchronous path (`visitTryStatement`) recovers the original
// since OPEN B.5; the async state machine's `_handleAsyncError` did not. Now it
// chooses and binds the clause for the native error and its own trace. An
// error no clause takes propagates as it arrived, and an undefined name is
// still not catchable (SCC31).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Runs [source] and awaits its result when `main` is `async`.
Future<Object?> _run(String source) async {
  final result = D4rt().execute(source: source);
  return result is Future ? await result : result;
}

/// `main` with [body], `async` when [isAsync], after an `await` when
/// [afterAwait].
String _main(String body, {required bool isAsync, bool afterAwait = false}) =>
    isAsync
    ? 'main() async { ${afterAwait ? 'await null; ' : ''}$body }'
    : 'main() { $body }';

void main() {
  group('ghissues12: a native error from a bridged call in a catch clause', () {
    // Each case: the try body, what `catch` / `on T` / `is T` answer.
    const unmodifiableAdd = 'final l = List.unmodifiable([1]); l.add(2);';
    const badParse = "int.parse('x');";
    const scriptThrow = "throw UnsupportedError('x');";

    for (final mode in const [
      (isAsync: false, afterAwait: false, label: 'sync'),
      (isAsync: true, afterAwait: false, label: 'async'),
      (isAsync: true, afterAwait: true, label: 'async after an await'),
    ]) {
      test('GHI12-1: ${mode.label}: a bare catch binds the native error '
          '[2026-11-09]', () async {
        expect(
          await _run(
            _main(
              'try { $unmodifiableAdd } catch (e) { '
              'return [e.runtimeType.toString(), e is UnsupportedError]; }',
              isAsync: mode.isAsync,
              afterAwait: mode.afterAwait,
            ),
          ),
          ['UnsupportedError', true],
        );
      });

      test('GHI12-2: ${mode.label}: `on FormatException` matches a native '
          'FormatException [2026-11-09]', () async {
        expect(
          await _run(
            _main(
              'try { $badParse } on FormatException catch (e) { '
              "return 'on ' + e.runtimeType.toString(); } "
              "catch (e) { return 'other ' + e.runtimeType.toString(); }",
              isAsync: mode.isAsync,
              afterAwait: mode.afterAwait,
            ),
          ),
          'on FormatException',
        );
      });

      test('GHI12-3: ${mode.label}: a clause for another type is passed over '
          '[2026-11-09]', () async {
        expect(
          await _run(
            _main(
              'try { $badParse } on StateError { return "state"; } '
              'on FormatException { return "format"; }',
              isAsync: mode.isAsync,
              afterAwait: mode.afterAwait,
            ),
          ),
          'format',
        );
      });

      test('GHI12-4: ${mode.label}: a script throw of the same type '
          '[2026-11-09]', () async {
        expect(
          await _run(
            _main(
              'try { $scriptThrow } on UnsupportedError catch (e) { '
              'return [e.message, e is UnsupportedError]; }',
              isAsync: mode.isAsync,
              afterAwait: mode.afterAwait,
            ),
          ),
          ['x', true],
        );
      });
    }

    test('GHI12-5: an awaited Future that completes with a native error, from '
        'a bridged call or from Future.error [2026-11-09]', () async {
      expect(
        await _run(
          "main() async { try { await Future(() => int.parse('x')); } "
          "on FormatException catch (e) { return 'on ' + e.source; } }",
        ),
        'on x',
      );
      expect(
        await _run(
          'main() async { try { await Future<int>.error(StateError("s")); } '
          'on StateError catch (e) { return e.message; } }',
        ),
        's',
      );
    });

    test('GHI12-6: the stack trace parameter is bound, and rethrow carries the '
        'native error on [2026-11-09]', () async {
      expect(
        await _run(
          'main() async { try { try { int.parse("x"); } '
          'catch (e, st) { if (st == null) return "no trace"; rethrow; } } '
          'on FormatException catch (e) { return "rethrown " + '
          'e.runtimeType.toString(); } }',
        ),
        'rethrown FormatException',
      );
    });

    test('GHI12-7: an undefined name is still not catchable, and an uncaught '
        'native error still fails the call [2026-11-09]', () async {
      await expectLater(
        _run(
          'main() async { try { undefinedThing(); } catch (e) { return 1; } }',
        ),
        throwsA(
          predicate(
            (Object e) => e.toString().contains('undefinedThing'),
            'an error naming undefinedThing',
          ),
        ),
      );
      await expectLater(
        _run("main() async { int.parse('x'); }"),
        throwsA(anything),
      );
    });
  });
}
