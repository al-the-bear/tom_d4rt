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
/// NOT COVERED HERE, deliberately: 19 of the 32 names `dart:io` re-exports are
/// unreachable — the whole `dart:_http` server/WebSocket surface plus
/// `HttpStatus`. That is a genuine gap, but it is a *bridging* gap (those
/// classes are bridged nowhere at all), not the re-export gap SCB21 described.
/// It is tracked separately rather than pinned here as a failing expectation,
/// so that closing it does not require deleting assertions.
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
      // Reaches a dart:io script through the eager typed_data registrar rather
      // than through the io one — but from the script's side it is simply
      // another name that resolves.
      'BytesBuilder',
    ];

    for (final name in bridgedTypes) {
      test('F-SCB21-8-$name: $name is usable as a type under dart:io '
          '[2026-07-28]', () {
        // `is` is the discriminating demand, not `.toString()`. Every name in
        // scope answers `.toString()` — including the four credentials names
        // below, which are not types at all — so a toString-based check would
        // report a healthy surface that isn't one.
        final source =
            '''
        import 'dart:io';
        main() { return 1 is $name; }
        ''';
        expect(execute(source), isFalse);
      });
    }
  });

  group('SCB21: the credentials names are functions, not types', () {
    // The remaining four of the 13 names that "resolve" are registered with
    // `environment.define(..., NativeFunction(...))` rather than
    // `defineBridge`, so they are callable values that happen to share a class
    // name. Separated into their own group because that distinction is exactly
    // what a `.toString()`-shaped audit misses — and because the difference is
    // observable, so it should be stated rather than averaged away.
    const credentials = <String>[
      'HttpClientCredentials',
      'HttpClientBasicCredentials',
      'HttpClientBearerCredentials',
      'HttpClientDigestCredentials',
    ];

    for (final name in credentials) {
      test('F-SCB21-9-$name: $name resolves to a callable [2026-07-28]', () {
        final source =
            '''
        import 'dart:io';
        main() { return $name.toString(); }
        ''';
        expect(execute(source), contains('native fn'));
      });
    }

    test(
      'F-SCB21-10: constructing through the callable works [2026-07-28]',
      () {
        // What the function shape does deliver, and the reason it was written
        // this way: the common script use is to hand credentials to an
        // HttpClient, which only needs the value.
        const source = '''
      import 'dart:io';
      main() {
        var c = HttpClientBasicCredentials('user', 'pass');
        return c.toString();
      }
      ''';
        expect(execute(source), contains('HttpClientBasicCredentials'));
      },
    );

    // NOT pinned here: `x is HttpClientBasicCredentials` currently *invokes*
    // the callable instead of testing a type, so it throws "requires username
    // and password arguments"; the zero-arity `HttpClientCredentials` instead
    // answers a silent, always-wrong `false`. Both are defects, and the fix is
    // to bridge these as real classes — which would make an assertion pinned to
    // today's behaviour something to delete rather than repair. Tracked as a
    // follow-up instead.
  });
}
