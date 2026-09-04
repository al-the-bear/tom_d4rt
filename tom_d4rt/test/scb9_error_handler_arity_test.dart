import 'dart:async';

import 'package:test/test.dart';
import 'interpreter_test.dart' show executeAsync;

/// SCB9 — script-supplied error handlers are invoked with the arity they
/// declare.
///
/// The SDK accepts an error handler in either arity: `void Function(Object
/// error)` or `void Function(Object error, StackTrace stackTrace)`. The platform
/// inspects the callback (`_invokeErrorHandler` does a type test against
/// `ZoneBinaryCallback`) and invokes whichever it was given. Every d4rt adapter
/// hardcoded the binary call, so the unary form — the one most scripts reach for
/// first — died with `Too many positional arguments. Expected at most 1, got 2.`
/// The message named argument counts rather than the callback the author wrote,
/// so it read as an interpreter bug rather than a signature mismatch.
///
/// **The gap was 15 sites, not one.** The todo named `Stream.listen` and asked
/// for three others to be *checked*; grepping for the two-argument invocation
/// found it hardcoded in `async/future.dart` (3), `async/stream.dart` (3),
/// `io/socket.dart` (6), `io/http.dart` (2) and `io/stdio.dart` (1). The io
/// sites are not merely similar — `io/socket.dart`'s listen adapter is a
/// byte-identical copy of `async/stream.dart`'s, `onDataWrapper` /
/// `onErrorWrapper` / `onDoneWrapper` naming included. One adapter, copy-pasted.
/// All 15 now route through `errorHandlerArgs`.
///
/// (This paragraph said "14 sites" and "`async/stream.dart` (2)" until SCC22
/// recounted it. The undercount was in the enumeration only — the SCB9 commit
/// itself already routed three stream sites, and the "6 async sites are covered
/// below" summary and F-SCB9-8 were both right. A hand-maintained count in a
/// header is exactly the thing that goes quietly wrong, which is why
/// F-SCC22-11 now asserts the site map instead of restating it in prose.)
///
/// Which of the 15 this file can *assert* on is limited by what a script can
/// reach without a network or a terminal: the 6 async sites are covered below.
/// The 9 io sites (socket, http, stdio) are covered by
/// `tom_d4rt/test/scc22_io_error_handler_arity_test.dart` — it drives a real
/// loopback connection for the three a script can force an error out of, and
/// guards the other six structurally, each with its measured reason for being
/// unreachable. That file replaces this paragraph's earlier claim that the io
/// sites were "verified by construction rather than by test".
///
/// **`maxPositionalArity`, not `arity`.** `arity` counts only *required*
/// positional parameters, so it reports 1 for `(e, [st])` — and native Dart
/// passes both arguments to that closure, because
/// `Function(Object, [StackTrace])` is a subtype of
/// `Function(Object, StackTrace)`. Selecting on `arity` would therefore have
/// silently dropped the stack trace for the optional form. F-SCB9-3 and
/// F-SCB9-11 pin that, and F-SCB9-11 is the one that would have caught the
/// pre-existing `Stream.handleError` implementation, which did select on
/// `arity`.
///
/// **Two error handlers, two destinations.** Writing the "must still reject a
/// genuinely wrong signature" guard exposed something the todo did not
/// anticipate: an error raised inside a *future* handler (`catchError`,
/// `then`'s `onError`) propagates through the future chain and out of
/// `execute`, but the same error raised inside a *stream* callback adapter
/// (`listen`'s `onError`) escapes to the host zone while `main()` returns
/// normally. So a script cannot try/catch a signature mistake in its own stream
/// callback. F-SCB9-12 asserts the guard where it is observable and F-SCB9-14
/// pins the zone route, so neither half is left to inference — an earlier draft
/// of F-SCB9-12 used `listen` and would have passed vacuously.
void main() {
  group('SCB9: Stream.listen onError arity', () {
    /// Drives an `onError` of the given signature and reports what it received.
    Future<Object?> listenOnError(String signature) => executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController();
          final seen = [];
          c.stream.listen((v) {}, onError: $signature);
          c.sink.addError(StateError('boom'));
          await c.sink.close();
          await Future.delayed(Duration(milliseconds: 10));
          return seen;
        }
      ''');

    test('F-SCB9-1: a unary onError receives the error [2026-07-28]', () async {
      // The reported bug. Before this fix: "Too many positional arguments.
      // Expected at most 1, got 2." thrown from _prepareExecutionEnvironment.
      final result = await listenOnError("(e) => seen.add('e:\$e')") as List;
      expect(result, orderedEquals(['e:Bad state: boom']));
    });

    test(
      'F-SCB9-2: a binary onError still receives both arguments [2026-07-28]',
      () async {
        // Regression guard: the binary form was the only one that worked, so it
        // is the shape most likely to be broken by a fix that over-corrects.
        final result =
            await listenOnError(
                  "(e, st) => seen.add('e:\$e st:\${st != null}')",
                )
                as List;
        expect(result, orderedEquals(['e:Bad state: boom st:true']));
      },
    );

    test(
      'F-SCB9-3: an onError with an optional second parameter still receives the stack trace [2026-07-28]',
      () async {
        // `(e, [st])` declares ONE required positional, so a fix that selected on
        // `arity` would call it with one argument and silently drop the stack
        // trace. Native Dart passes both, because `Function(Object, [StackTrace])`
        // is a subtype of `Function(Object, StackTrace)`. This is the case that
        // forces `maxPositionalArity` rather than `arity`.
        final result =
            await listenOnError(
                  "(e, [st]) => seen.add('e:\$e st:\${st != null}')",
                )
                as List;
        expect(result, orderedEquals(['e:Bad state: boom st:true']));
      },
    );
  });

  group('SCB9: Future error-handler arity', () {
    test(
      'F-SCB9-4: Future.catchError accepts a unary handler [2026-07-28]',
      () async {
        // Not in the todo's fix list — it said catchError "may already handle
        // this; confirm before changing it". It did not.
        final result = await executeAsync('''
        import 'dart:async';
        main() async {
          return await Future.error(StateError('boom')).catchError((e) => 'c:\$e');
        }
      ''');
        expect(result, 'c:Bad state: boom');
      },
    );

    test(
      'F-SCB9-5: Future.catchError still accepts a binary handler [2026-07-28]',
      () async {
        final result = await executeAsync('''
        import 'dart:async';
        main() async {
          return await Future.error(StateError('boom'))
              .catchError((e, st) => 'c:\$e st:\${st != null}');
        }
      ''');
        expect(result, 'c:Bad state: boom st:true');
      },
    );

    test(
      'F-SCB9-6: Future.then onError accepts a unary handler [2026-07-28]',
      () async {
        // Found by grepping rather than by the todo, which did not name it.
        final result = await executeAsync('''
        import 'dart:async';
        main() async {
          return await Future.error(StateError('boom'))
              .then((v) => 'v:\$v', onError: (e) => 't:\$e');
        }
      ''');
        expect(result, 't:Bad state: boom');
      },
    );

    test(
      'F-SCB9-7: the Future.onError extension accepts a unary handler [2026-07-28]',
      () async {
        // Also unnamed by the todo. `FutureExtensions.onError` is a third copy of
        // the same adapter in the same file.
        final result = await executeAsync('''
        import 'dart:async';
        main() async {
          return await Future.error(StateError('boom'))
              .onError((e) => 'o:\$e');
        }
      ''');
        expect(result, 'o:Bad state: boom');
      },
    );
  });

  group('SCB9: Stream.handleError and subscription handlers', () {
    test(
      'F-SCB9-8: the StreamSubscription.onError setter accepts a unary handler [2026-07-28]',
      () async {
        final result =
            await executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController();
          final seen = [];
          final sub = c.stream.listen((v) {});
          sub.onError = (e) => seen.add('s:\$e');
          c.sink.addError(StateError('boom'));
          await c.sink.close();
          await Future.delayed(Duration(milliseconds: 10));
          return seen;
        }
      ''')
                as List;
        expect(result, orderedEquals(['s:Bad state: boom']));
      },
    );

    test(
      'F-SCB9-9: Stream.handleError returns a usable stream [2026-07-28]',
      () async {
        // Not an arity assertion, and not something the todo anticipated. The
        // handleError adapter already had an arity check, but its RESULT could
        // not be used: `_HandleErrorStream` was absent from the Stream bridge's
        // nativeNames, so every member of the returned stream failed with
        // "Undefined property or method 'toList' on _HandleErrorStream". This is
        // the same defect SC4 fixed for `_StreamSinkWrapper`, on a neighbouring
        // method in the same file — and it is why handleError's arity handling
        // had never been exercised by any test.
        final result =
            await executeAsync('''
        import 'dart:async';
        main() async {
          final seen = [];
          await Stream.error(StateError('boom'))
              .handleError((e) => seen.add('h:\$e'))
              .toList();
          return seen;
        }
      ''')
                as List;
        expect(result, orderedEquals(['h:Bad state: boom']));
      },
    );

    test(
      'F-SCB9-10: Stream.handleError accepts a binary handler [2026-07-28]',
      () async {
        final result =
            await executeAsync('''
        import 'dart:async';
        main() async {
          final seen = [];
          await Stream.error(StateError('boom'))
              .handleError((e, st) => seen.add('h:\$e st:\${st != null}'))
              .toList();
          return seen;
        }
      ''')
                as List;
        expect(result, orderedEquals(['h:Bad state: boom st:true']));
      },
    );

    test(
      'F-SCB9-11: Stream.handleError passes the stack trace to an optional second parameter [2026-07-28]',
      () async {
        // The pre-existing handleError implementation selected on `arity`
        // (required positional only), so it called `(e, [st])` with one argument
        // and dropped the stack trace where native Dart passes it. This is the
        // regression that motivated using `maxPositionalArity` everywhere rather
        // than copying the existing check.
        final result =
            await executeAsync('''
        import 'dart:async';
        main() async {
          final seen = [];
          await Stream.error(StateError('boom'))
              .handleError((e, [st]) => seen.add('h:\$e st:\${st != null}'))
              .toList();
          return seen;
        }
      ''')
                as List;
        expect(result, orderedEquals(['h:Bad state: boom st:true']));
      },
    );
  });

  group('SCB9: the fix does not swallow genuine arity errors', () {
    test(
      'F-SCB9-12: a three-parameter error handler still fails [2026-07-28]',
      () async {
        // The guard the todo explicitly asked for. The fix must not become a
        // general "call with as many arguments as the callee happens to accept"
        // rule — that would turn every real signature mismatch in the stdlib into
        // a silent no-op. A 3-parameter handler is not a valid error handler in
        // any SDK arity, so it must still be reported.
        //
        // Asserted through `catchError` rather than `Stream.listen` — not a style
        // choice. An error raised inside a *stream* callback adapter escapes to
        // the host zone instead of the returned future (see F-SCB9-14), so a
        // listen-based version of this test cannot observe the failure with
        // try/catch at all and would pass vacuously. `catchError`'s handler runs
        // inside the future chain, so the error propagates to the awaiting script
        // and out through `execute`.
        Object? caught;
        try {
          await executeAsync('''
          import 'dart:async';
          main() async {
            return await Future.error(StateError('boom'))
                .catchError((a, b, c) => 'unreachable');
          }
        ''');
        } catch (e) {
          caught = e;
        }
        expect(
          caught,
          isNotNull,
          reason: 'a 3-parameter error handler must still be an error',
        );
        // The *under*-supplied path, not the "Too many positional arguments" one:
        // errorHandlerArgs passes 2 arguments to a handler that requires 3.
        expect(caught.toString(), contains('Missing required'));
        expect(caught.toString(), contains("'c'"));
      },
    );

    test(
      'F-SCB9-14: a bad handler in a stream callback still reports, via the zone [2026-07-28]',
      () async {
        // Pins where the error *goes*, which is the part that surprised: the
        // 3-parameter handler above is equally invalid here, but `listen`'s
        // adapter is invoked by the platform outside the script's future chain,
        // so the error surfaces as an uncaught zone error while `main()` returns
        // normally. The fix must not swallow it — but "not swallowed" means
        // "reaches the zone", not "reaches the script".
        //
        // This asymmetry is a defect in its own right (a script cannot catch a
        // mistake in its own stream callback) and is tracked separately; it is
        // asserted here so the guarantee F-SCB9-12 provides is not silently
        // assumed to extend to stream callbacks.
        final zoneErrors = <Object>[];
        final finished = Completer<Object?>();
        runZonedGuarded(() async {
          finished.complete(
            await executeAsync('''
          import 'dart:async';
          main() async {
            final c = StreamController();
            c.stream.listen((v) {}, onError: (a, b, cc) => null);
            c.sink.addError(StateError('boom'));
            await c.sink.close();
            await Future.delayed(Duration(milliseconds: 10));
            return 'script-completed';
          }
        '''),
          );
        }, (error, _) => zoneErrors.add(error));

        final result = await finished.future;
        await Future.delayed(const Duration(milliseconds: 20));

        expect(
          result,
          'script-completed',
          reason: 'the script itself cannot observe the failure',
        );
        expect(
          zoneErrors,
          isNotEmpty,
          reason: 'but the error must still be reported to the zone',
        );
        expect(zoneErrors.first.toString(), contains('Missing required'));
      },
    );

    test(
      'F-SCB9-13: StreamTransformer.fromHandlers still receives all three arguments [2026-07-28]',
      () async {
        // Regression guard for the one error handler whose arity is NOT variable:
        // `fromHandlers`' handleError is `(error, stackTrace, sink)` in the SDK,
        // a fixed 3-argument shape. It must keep getting three, which is why it
        // is deliberately NOT routed through errorHandlerArgs.
        final result =
            await executeAsync('''
        import 'dart:async';
        main() async {
          final t = StreamTransformer.fromHandlers(
            handleError: (e, st, sink) => sink.add('h:\$e st:\${st != null}'),
          );
          return await Stream.error(StateError('boom')).transform(t).toList();
        }
      ''')
                as List;
        expect(result, orderedEquals(['h:Bad state: boom st:true']));
      },
    );
  });
}
