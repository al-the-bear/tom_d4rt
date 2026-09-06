import 'package:test/test.dart';
import '../../interpreter_test.dart';

/// SCB21 — what a `dart:io`-only script can name.
///
/// SCB21 reported that `import 'dart:io'; BytesBuilder()` fails with
/// `Undefined variable`, and that `Uint8List` is likewise unreachable, and
/// proposed building a re-export aliasing mechanism in the module loader to
/// fix it. **Both halves were wrong**, and this file is the regression guard
/// that stops the claim being made a third time.
///
/// **The names were already reachable.** `TypedDataStdlib` has been registered
/// EAGERLY, for every script regardless of imports, since GEN-106 (2026-04-25)
/// — three months before SCB21 was written. `BytesBuilder` joined that
/// registrar in SC8 (2026-07-27), the same day SCB21 was authored *during*
/// SC8. So one half was wrong when written and the other was fixed by the very
/// commit whose work surfaced it.
///
/// **There is no re-export scoping problem to solve.** Bridges live in one flat
/// environment; an `import` decides whether a *registrar runs*, not which names
/// a script may then see. Once `TypedDataStdlib` has run — which for every
/// script it has — its names are visible. The proposed mechanism would have
/// been machinery for a condition that does not occur, so it was deliberately
/// not built.
///
/// The `noSuchImport` group pins the other side of that model, because a
/// permissive registry could just as easily have made everything visible to
/// everyone, and that would NOT match Dart.
///
/// NOT COVERED HERE: two of the 32 names `dart:io` re-exports are not bridged,
/// and both by decision rather than omission.
///
/// `BadCertificateCallback` is a `typedef`, not a class — an alias for
/// `bool Function(X509Certificate, String, int)`. Everything a script does with
/// it already works: `HttpClient.badCertificateCallback` takes a plain function
/// value, and the interpreter does not resolve type annotations at all, so the
/// alias is usable as an annotation whether or not anything defines it. A
/// `BridgedClass` would add only `x is BadCertificateCallback`, which is a
/// function-shape question `BridgedClass` cannot answer honestly.
///
/// `HttpOverrides` is left unbridged on sandbox grounds: its `global` setter
/// swaps the `HttpClient` implementation process-wide and outlives the script
/// that set it, which is the uncontrolled host access the interpreter exists to
/// prevent. Both are recorded in [d4rt_limitations.md](../../../doc/d4rt_limitations.md).
void main() {
  group('SCB21: dart:io-only scripts can name the typed_data re-exports', () {
    test('F-SCB21-1: BytesBuilder is nameable and usable under dart:io alone '
        '[2026-07-28]', () {
      // The exact script SCB21 reported as failing.
      const source = '''
      import 'dart:io';
      main() {
        var b = BytesBuilder();
        b.addByte(1);
        b.addByte(2);
        return b.length;
      }
      ''';
      expect(execute(source), equals(2));
    });

    test('F-SCB21-2: BytesBuilder.toBytes returns a usable Uint8List '
        '[2026-07-28]', () {
      // SCB21's second concern: dart:io APIs *return* typed_data values, so a
      // script needs the name for what it gets back, not only for what it
      // constructs.
      const source = '''
      import 'dart:io';
      main() {
        var b = BytesBuilder();
        b.add([1, 2, 3]);
        var bytes = b.toBytes();
        return [bytes.length, bytes is Uint8List, bytes[1]];
      }
      ''';
      expect(execute(source), equals([3, true, 2]));
    });

    test(
      'F-SCB21-3: Uint8List is nameable under dart:io alone [2026-07-28]',
      () {
        const source = '''
      import 'dart:io';
      main() {
        var u = Uint8List.fromList([1, 2, 3]);
        return u.length;
      }
      ''';
        expect(execute(source), equals(3));
      },
    );

    test('F-SCB21-4: ByteData and Endian are nameable under dart:io alone '
        '[2026-07-28]', () {
      const source = '''
      import 'dart:io';
      main() {
        var d = ByteData(8);
        d.setInt32(0, 7, Endian.little);
        return d.getInt32(0, Endian.little);
      }
      ''';
      expect(execute(source), equals(7));
    });

    test('F-SCB21-5: the typed_data registrar is eager, so no import is needed '
        'at all [2026-07-28]', () {
      // This is the mechanism behind the four cases above, asserted directly.
      // It is also a deliberate deviation from Dart, which would reject this
      // script — GEN-106 chose reachability over strictness because Flutter
      // scripts reach these types through re-exports constantly. Pinned so the
      // deviation is a decision on the record rather than an accident.
      const source = '''
      main() {
        var b = BytesBuilder();
        b.addByte(9);
        return [b.length, Uint8List.fromList([1, 2]).length];
      }
      ''';
      expect(execute(source), equals([1, 2]));
    });
  });

  group('SCB21: imports still gate the lazily-registered libraries', () {
    test('F-SCB21-6: dart:io does not make dart:convert names visible '
        '[2026-07-28]', () {
      // The control that gives F-SCB21-5 its meaning. `dart:io` imports
      // `dart:convert` but does not re-export it, so real Dart rejects this
      // too — the interpreter agreeing is what shows the flat environment is
      // not simply making everything visible to everyone.
      const source = '''
      import 'dart:io';
      main() { return LineSplitter().toString(); }
      ''';
      expect(
        () => execute(source),
        throwsRuntimeError(contains('Undefined variable: LineSplitter')),
      );
    });

    test('F-SCB21-7: the same name resolves once dart:convert is imported '
        '[2026-07-28]', () {
      const source = '''
      import 'dart:convert';
      main() { return LineSplitter().toString(); }
      ''';
      expect(execute(source), contains('LineSplitter'));
    });
  });

  group('SCB21: the HTTP re-exports that are bridged stay reachable', () {
    // 30 of the 32 re-exported names resolve as real bridged *types* — every
    // one except the two the header explains are unbridged by decision. They
    // are pinned as a set because they all come out of one registrar, and
    // silently losing one would look like unrelated breakage.
    const bridgedTypes = <String>[
      'HttpClient',
      'HttpClientRequest',
      'HttpClientResponse',
      'HttpServer',
      'HttpHeaders',
      'HeaderValue',
      'ContentType',
      'Cookie',
      // The server half (SCC62). `HttpServer` above has been bridged all along,
      // so these six are what turned it from a name into something that can
      // answer a request; `http_server_test.dart` pins the round trip.
      'HttpRequest',
      'HttpResponse',
      'HttpSession',
      'HttpConnectionInfo',
      'HttpConnectionsInfo',
      // Reached as `Cookie.sameSite`'s value type rather than named directly,
      // which is how it stayed missing while the property it belongs to was
      // bridged on both sides.
      'SameSite',
      // The exception surface (SCC61). Reachability is the whole point of
      // bridging these: an unresolvable name in a catch clause is not an error,
      // it is a handler that silently never matches. `http_exception_test.dart`
      // pins the catching behaviour; this row pins that the name exists at all.
      'HttpException',
      'RedirectException',
      // A constants holder with no instances, so `1 is HttpStatus` is a strange
      // question to ask of it — but it is the same question as every other row,
      // and answering `false` rather than throwing is what says the name is a
      // type rather than a callable. `http_exception_test.dart` covers the
      // constants themselves.
      'HttpStatus',
      // The WebSocket block (SCC63). The last group that was unreachable in
      // its entirety rather than partly — nothing WebSocket-shaped was bridged,
      // so unlike the rows above these five closed a gap no script could have
      // been part-way through. `websocket_test.dart` pins the handshake.
      'WebSocket',
      'WebSocketTransformer',
      'WebSocketException',
      'WebSocketStatus',
      'CompressionOptions',
      // The credentials family (SCC64). These four were the last names that
      // "resolved" without being types: registered as bare `NativeFunction`s,
      // so they constructed but could not be asked about. `1 is X` throwing —
      // or, for the zero-arity marker, answering a silent always-wrong
      // `false` — is what moved them out of their own group and into this one.
      // `http_credentials_test.dart` pins the type questions that matter.
      'HttpClientCredentials',
      'HttpClientBasicCredentials',
      'HttpClientBearerCredentials',
      'HttpClientDigestCredentials',
      // The last three (SCC65). `RedirectInfo` and
      // `HttpClientResponseCompressionState` are dead ends of the kind SCC62
      // named: `HttpClientResponse.redirects` and `.compressionState` were
      // bridged all along, so a script could reach a value and then not name,
      // test or read it — a failure that surfaces one call after the one that
      // caused it. `HttpDate` had no such excuse; nothing had registered it.
      // `http_date_test.dart` and `http_response_details_test.dart` pin the
      // behaviour.
      'HttpDate',
      'RedirectInfo',
      'HttpClientResponseCompressionState',
      // Reaches a dart:io script through the eager typed_data registrar rather
      // than through the io one — but from the script's side it is simply
      // another name that resolves.
      'BytesBuilder',
    ];

    for (final name in bridgedTypes) {
      test('F-SCB21-8-$name: $name is usable as a type under dart:io '
          '[2026-07-28]', () {
        // `is` is the discriminating demand, not `.toString()`. Every name in
        // scope answers `.toString()`, including a callable that merely shares
        // a class name — which is what the credentials four used to be — so a
        // toString-based check would report a healthy surface that isn't one.
        final source =
            '''
        import 'dart:io';
        main() { return 1 is $name; }
        ''';
        expect(execute(source), isFalse);
      });
    }
  });
}
