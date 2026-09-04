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
/// NOT COVERED HERE, deliberately: 19 of the 32 names `dart:io` re-exports are
/// unreachable — the whole `dart:_http` server/WebSocket surface plus
/// `HttpStatus`. That is a real gap, but a *bridging* gap (those classes are
/// bridged nowhere at all), not the re-export gap SCB21 described. It is tracked
/// separately rather than pinned here as a failing expectation, so that closing
/// it does not require deleting assertions.
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

    // 9 of the 32 re-exported names resolve as real bridged *types*. They are
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
      // Comes from the eager typed_data registrar rather than `IoStdlib`, but
      // lands in the same environment — which is the whole point above.
      'BytesBuilder',
    ];

    for (final name in bridgedTypes) {
      test('F-SCB21-AST-5-$name: $name is bridged as a type [2026-07-28]', () {
        expect(env.findBridgedClassByName(name), isNotNull);
      });
    }

    test('F-SCB21-AST-6: the four credentials names are callables, not types '
        '[2026-07-28]', () {
      // The distinction this tree can see more sharply than a script can. They
      // are registered with `define(..., NativeFunction(...))` rather than
      // `defineBridge`, so they are values that happen to share a class name.
      // A script calling `HttpClientBasicCredentials('u', 'p')` works; a script
      // writing `x is HttpClientBasicCredentials` *invokes* the callable
      // instead of testing a type. Pinning the registration shape here is what
      // makes that script-level defect explicable rather than mysterious.
      for (final name in const <String>[
        'HttpClientCredentials',
        'HttpClientBasicCredentials',
        'HttpClientBearerCredentials',
        'HttpClientDigestCredentials',
      ]) {
        expect(
          env.findBridgedClassByName(name),
          isNull,
          reason: '$name is defined as a NativeFunction, not a bridge',
        );
        expect(
          env.get(name),
          isA<NativeFunction>(),
          reason: '$name must still resolve as a callable value',
        );
      }
    });
  });
}
