import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart` —
// see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';

/// SCB21 mirror coverage for `tom_d4rt_ast` — what a `dart:io` script can name.
///
/// SCB21 claimed `import 'dart:io'; BytesBuilder()` fails, that `Uint8List` is
/// likewise unreachable, and proposed a re-export aliasing mechanism in the
/// module loader. **Both halves were wrong**; the script-level proof lives in
/// `tom_d4rt/test/stdlib/io/io_reexport_visibility_test.dart`, and this file is
/// its registration-level twin.
///
/// Registration level is the honest level for *this* tree — the same reason the
/// SC5..SC8 mirrors give. `tom_d4rt_exec` is the only runner that could execute
/// a script here, and it resolves `tom_d4rt_ast` from pub.dev rather than by
/// path, so it cannot see unpublished local edits.
///
/// It is also the level at which SCB21's error actually lives. The mechanism is
/// not a scoping rule that only shows up when a script runs: bridges live in one
/// flat environment, and an `import` decides whether a *registrar runs*, not
/// which names a script may then see. That is fully observable from an
/// `Environment` and a choice of which registrars to call — which is exactly
/// what these tests do.
///
/// NOT COVERED HERE, deliberately: 5 of the 32 names `dart:io` re-exports are
/// still unreachable — the client-side detail types (`HttpDate`,
/// `HttpOverrides`, `BadCertificateCallback`, `RedirectInfo`,
/// `HttpClientResponseCompressionState`). That is a real gap, but a *bridging*
/// gap (those classes are bridged nowhere at all), not the re-export gap SCB21
/// described. It is tracked separately rather than pinned here as a failing
/// expectation, so that closing it does not require deleting assertions.
void main() {
  group('SCB21: the typed_data names are eager, so no import gates them', () {
    test('F-SCB21-AST-1: Stdlib.register alone defines the names SCB21 '
        'reported missing [2026-07-28]', () {
      // `Stdlib.register()` is what every script gets. GEN-106 (2026-04-25) put
      // `TypedDataStdlib` in it — three months before SCB21 was written — and
      // SC8 (2026-07-27) added `BytesBuilder` to that registrar on the very day
      // SCB21 was authored. So one half of the claim was wrong when written and
      // the other was fixed by the work that surfaced it.
      final env = Environment();
      Stdlib(env).register();

      for (final name in const <String>[
        'BytesBuilder',
        'Uint8List',
        'ByteData',
        'ByteBuffer',
        // `Endian` is bridged as a class rather than an enum — its members are
        // static const fields on an abstract class in the SDK.
        'Endian',
      ]) {
        expect(
          env.findBridgedClassByName(name),
          isNotNull,
          reason: '$name must be reachable with no import at all',
        );
      }
    });

    test('F-SCB21-AST-2: IoStdlib registers no typed_data names of its own '
        '[2026-07-28]', () {
      // The point that makes F-SCB21-AST-1 load-bearing rather than incidental:
      // `dart:io` does not carry these names itself. If the eager registrar
      // were ever made lazy again, this pair of tests separates "io lost them"
      // from "nothing registers them", which is the confusion SCB21 fell into.
      final env = Environment();
      IoStdlib.register(env);

      for (final name in const <String>[
        'BytesBuilder',
        'Uint8List',
        'ByteData',
        'ByteBuffer',
      ]) {
        expect(
          env.findBridgedClassByName(name),
          isNull,
          reason: '$name comes from TypedDataStdlib, not IoStdlib',
        );
      }
    });
  });

  group('SCB21: visibility is flat, so there is nothing to alias', () {
    test('F-SCB21-AST-3: a registered bridge is visible without regard to '
        'which library asked for it [2026-07-28]', () {
      // SCB21 proposed teaching the module loader that `dart:io` re-exports
      // `dart:typed_data`, so that a dart:io-only script could see those names.
      // The mechanism it assumed — per-library name scoping — does not exist:
      // one environment holds every bridge, and a name is visible once its
      // registrar has run. That is why the proposed machinery was not built.
      final env = Environment();
      IoStdlib.register(env);
      expect(env.findBridgedClassByName('HttpClient'), isNotNull);
      expect(env.findBridgedClassByName('LineSplitter'), isNull);

      // Running the convert registrar into the *same* environment makes its
      // names visible to everything, with no re-export declaration anywhere.
      ConvertStdlib.register(env);
      expect(env.findBridgedClassByName('LineSplitter'), isNotNull);
      expect(env.findBridgedClassByName('HttpClient'), isNotNull);
    });

    test('F-SCB21-AST-4: imports gate registrars, which is what keeps '
        'dart:convert out of a dart:io script [2026-07-28]', () {
      // The control. Real Dart rejects `import "dart:io"; LineSplitter()` too —
      // dart:io imports dart:convert but does not re-export it. A permissive
      // registry could just as easily have made everything visible to everyone;
      // that this does not happen is what shows the flat environment still
      // models Dart's import rules, by choosing which registrars to run.
      final env = Environment();
      Stdlib(env).register();
      IoStdlib.register(env);
      expect(env.findBridgedClassByName('LineSplitter'), isNull);
    });
  });

  group('SCB21: the HTTP re-exports that are bridged stay reachable', () {
    late Environment env;

    setUp(() {
      env = Environment();
      Stdlib(env).register();
      IoStdlib.register(env);
    });

    // 27 of the 32 re-exported names resolve as real bridged *types*. They are
    // pinned because the follow-up work that bridges the other names will touch
    // this registrar, and silently losing one would look like unrelated
    // breakage.
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
      // answer a request. The round trip is pinned script-level in
      // `tom_d4rt/test/stdlib/io/http_server_test.dart` (DGUC6: this tree
      // cannot run scripts).
      'HttpRequest',
      'HttpResponse',
      'HttpSession',
      'HttpConnectionInfo',
      'HttpConnectionsInfo',
      // Reached as `Cookie.sameSite`'s value type rather than named directly,
      // which is how it stayed missing while the property it belongs to was
      // bridged on both sides. Not an enum despite reading like one — a final
      // class with a private constructor and three static const instances.
      'SameSite',
      // The exception surface (SCC61). An unresolvable name in a catch clause
      // is not an error, it is a handler that silently never matches — so the
      // name existing at all is the load-bearing fact. The script-level
      // behaviour is pinned in `tom_d4rt/test/stdlib/io/http_exception_test.dart`
      // (DGUC6: this tree cannot run scripts).
      'HttpException',
      'RedirectException',
      // A constants holder with no instances. It is bridged as an abstract
      // class carrying only static getters, so the thing to assert is that the
      // *name* resolves to a bridge rather than to a callable.
      'HttpStatus',
      // The WebSocket block (SCC63). The last group that was unreachable in its
      // entirety rather than partly — nothing WebSocket-shaped was bridged, so
      // unlike the rows above these five closed a gap no script could have been
      // part-way through. `WebSocketStatus` and `CompressionOptions` are only
      // ever reached through the socket itself, so they would have been the
      // easiest to leave behind; pinning them here is what stops that. The
      // handshake round trip is pinned script-level in
      // `tom_d4rt/test/stdlib/io/websocket_test.dart` (DGUC6: this tree cannot
      // run scripts).
      'WebSocket',
      'WebSocketTransformer',
      'WebSocketException',
      'WebSocketStatus',
      'CompressionOptions',
      // The credentials family (SCC64). These four were registered with
      // `define(..., NativeFunction(...))` rather than `defineBridge`, so they
      // resolved as callable values that merely shared a class name — the last
      // names in this list that "resolved" without being types. The script-side
      // consequences are pinned in `tom_d4rt/test/stdlib/io/
      // http_credentials_test.dart` (DGUC6: this tree cannot run scripts).
      'HttpClientCredentials',
      'HttpClientBasicCredentials',
      'HttpClientBearerCredentials',
      'HttpClientDigestCredentials',
      // Comes from the eager typed_data registrar rather than `IoStdlib`, but
      // lands in the same environment — which is the whole point above.
      'BytesBuilder',
    ];

    for (final name in bridgedTypes) {
      test('F-SCB21-AST-5-$name: $name is bridged as a type [2026-07-28]', () {
        expect(env.findBridgedClassByName(name), isNotNull);
      });
    }

    // SCC64 — the credentials family, at the registration level.
    //
    // What this tree can see and a script cannot: the *shape* each name is
    // registered with. Before SCC64 all four were `NativeFunction`s, and the
    // script-level symptom — `x is HttpClientBasicCredentials` executing the
    // constructor instead of testing a type — was only explicable once you
    // knew that. Pinning the shape here is what keeps the two halves connected.
    const credentials = <String>[
      'HttpClientCredentials',
      'HttpClientBasicCredentials',
      'HttpClientBearerCredentials',
      'HttpClientDigestCredentials',
    ];

    for (final name in credentials) {
      test('F-SCB21-AST-6-$name: $name resolves to a bridge rather than a '
          'callable [2026-09-06]', () {
        expect(env.findBridgedClassByName(name), isNotNull);
        expect(
          env.get(name),
          isNot(isA<NativeFunction>()),
          reason: '$name must no longer be a callable value',
        );
      });
    }

    test('F-SCB21-AST-7: the marker carries no constructor and the three '
        'concrete forms do [2026-09-06]', () {
      // `abstract interface class HttpClientCredentials {}` in the SDK has no
      // factory, so `HttpClientCredentials()` must fail. The three concrete
      // forms each declare one, and losing a constructor while gaining a type
      // is exactly the trade the conversion had to avoid.
      expect(
        env.findBridgedClassByName('HttpClientCredentials')!.isAbstract,
        isTrue,
      );
      expect(
        env.findBridgedClassByName('HttpClientCredentials')!.constructors,
        isEmpty,
      );
      for (final name in const <String>[
        'HttpClientBasicCredentials',
        'HttpClientBearerCredentials',
        'HttpClientDigestCredentials',
      ]) {
        expect(
          env.findBridgedClassByName(name)!.constructors,
          contains(''),
          reason: '$name must keep its unnamed constructor',
        );
      }
    });

    test('F-SCB21-AST-8: the three concrete forms declare the marker as a '
        'supertype [2026-09-06]', () {
      // `isAssignable` is consulted only for the pair being asked about and
      // never walks the target's own supertypes, so without these registered
      // edges `concrete is HttpClientCredentials` answers false while
      // `concrete is ConcreteType` passes — and the marker is precisely the
      // type `addCredentials` accepts, so it is the question worth asking.
      for (final name in const <String>[
        'HttpClientBasicCredentials',
        'HttpClientBearerCredentials',
        'HttpClientDigestCredentials',
      ]) {
        expect(
          BridgedClass.transitiveSupertypeNames(name),
          contains('HttpClientCredentials'),
          reason: '$name must declare the marker interface',
        );
      }
    });
  });
}
