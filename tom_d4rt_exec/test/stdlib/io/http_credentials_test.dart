// SCC64 — the four `HttpClient*Credentials` names are types, not callables.
//
// WHAT WAS WRONG. `IoHttpStdlib.register` defined all four with
// `environment.define(..., NativeFunction(...))` rather than `defineBridge`.
// That makes construction work — which is the common script use, and presumably
// why it was written that way — while leaving them as callable values that
// merely share a class name. So `x is HttpClientBasicCredentials` did not test
// a type: the interpreter's `is` handling *invoked* the callable to see whether
// it returned a `Type`, the two-argument constructor rejected the empty
// argument list, and a type test threw "requires username and password
// arguments". The zero-arity `HttpClientCredentials` failed more quietly: it
// really did return a `Type`, so `is` compared `runtimeType == Type` and
// answered a silent, always-wrong `false` — even for a genuine credentials
// instance.
//
// The general form of that hazard (any callable on the right-hand side of `is`)
// is fixed in the interpreter and pinned by
// `test/scc64_callable_is_operand_test.dart`. This file is about the four
// registrations.
//
// WHY THE `is` QUESTION IS WORTH ASKING AT ALL of a marker interface with no
// members. `HttpClientCredentials` is what `addCredentials` accepts, so a
// script that wraps that call — a helper taking `dynamic` and validating before
// forwarding — has exactly one way to check its argument, and it is this one.
// A silent `false` turns that guard into a rejection of every valid value.
import 'package:test/test.dart';
import '../../interpreter_test.dart';

void main() {
  group('SCC64: the credentials names are usable as types', () {
    test('F-SCC64-1: a basic-credentials value satisfies its own type '
        '[2026-09-06]', () {
      // The assertion that threw before the fix, rather than answering false —
      // a type test executing a constructor.
      const source = '''
      import 'dart:io';
      main() {
        var c = HttpClientBasicCredentials('user', 'pass');
        return c is HttpClientBasicCredentials;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test(
      'F-SCC64-2: and satisfies the interface it implements [2026-09-06]',
      () {
        // The edge in `IoHierarchyIo`, not the predicate: `isAssignable` is
        // consulted for the pair being asked about and does not then walk the
        // target's own supertypes, so without the declared edge this stays false
        // while F-SCC64-1 passes. That asymmetry is what makes it worth a
        // separate case.
        const source = '''
      import 'dart:io';
      main() {
        var c = HttpClientBasicCredentials('user', 'pass');
        return c is HttpClientCredentials;
      }
      ''';
        expect(execute(source), isTrue);
      },
    );

    test('F-SCC64-3: all three concrete forms answer both questions '
        '[2026-09-06]', () {
      // Bearer takes one argument and Digest two, so a fix that only repaired
      // the arity the interpreter happened to call with would pass F-SCC64-1
      // and fail here.
      const source = '''
      import 'dart:io';
      main() {
        var b = HttpClientBasicCredentials('u', 'p');
        var d = HttpClientDigestCredentials('u', 'p');
        var t = HttpClientBearerCredentials('tok');
        return [
          b is HttpClientBasicCredentials, b is HttpClientCredentials,
          d is HttpClientDigestCredentials, d is HttpClientCredentials,
          t is HttpClientBearerCredentials, t is HttpClientCredentials,
        ];
      }
      ''';
      expect(execute(source), equals([true, true, true, true, true, true]));
    });

    test(
      'F-SCC64-4: the three concrete forms are not each other [2026-09-06]',
      () {
        // The control. Every row above is a `true`, and a bridge whose
        // `isAssignable` was too loose — or an edge declared in the wrong
        // direction — would satisfy all of them while making the type test
        // useless. `HttpClientCredentials` is a bare marker interface with no
        // members, so nothing else in this file would notice.
        const source = '''
      import 'dart:io';
      main() {
        var b = HttpClientBasicCredentials('u', 'p');
        var t = HttpClientBearerCredentials('tok');
        return [
          b is HttpClientBearerCredentials,
          b is HttpClientDigestCredentials,
          t is HttpClientBasicCredentials,
        ];
      }
      ''';
        expect(execute(source), equals([false, false, false]));
      },
    );

    test('F-SCC64-5: an unrelated value is not credentials [2026-09-06]', () {
      // The second control, and the one the whole surface used to fail: before
      // the fix `1 is HttpClientBasicCredentials` threw rather than answering.
      const source = '''
      import 'dart:io';
      main() {
        return [
          1 is HttpClientCredentials,
          'x' is HttpClientBasicCredentials,
          null is HttpClientCredentials,
        ];
      }
      ''';
      expect(execute(source), equals([false, false, false]));
    });

    test('F-SCC64-6: `is!` negates rather than answering the un-negated result '
        '[2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() {
        var c = HttpClientBasicCredentials('u', 'p');
        return [c is! HttpClientCredentials, 1 is! HttpClientCredentials];
      }
      ''';
      expect(execute(source), equals([false, true]));
    });
  });

  group('SCC64: construction keeps working', () {
    // The behaviour the callable shape did deliver. Bridging is only an
    // improvement if none of it is lost, so each constructor is exercised
    // rather than assumed to follow from the first.

    test(
      'F-SCC64-7: all three constructors still produce values [2026-09-06]',
      () {
        const source = '''
      import 'dart:io';
      main() {
        return [
          HttpClientBasicCredentials('u', 'p').toString(),
          HttpClientDigestCredentials('u', 'p').toString(),
          HttpClientBearerCredentials('tok').toString(),
        ];
      }
      ''';
        final result = execute(source) as List<Object?>;
        expect(result[0], contains('HttpClientBasicCredentials'));
        expect(result[1], contains('HttpClientDigestCredentials'));
        expect(result[2], contains('HttpClientBearerCredentials'));
      },
    );

    test('F-SCC64-8: the value still reaches HttpClient.addCredentials '
        '[2026-09-06]', () {
      // The reason the four exist. `addCredentials` type-checks its third
      // argument with a native `is HttpClientCredentials`, so it only accepts
      // the unwrapped native object — which makes this a test of the bridge's
      // *unwrapping* as much as of its construction. Returning normally is the
      // assertion; the call throws on a wrong-shaped argument.
      const source = '''
      import 'dart:io';
      main() {
        var client = HttpClient();
        client.addCredentials(
          Uri.parse('http://127.0.0.1:1/'),
          'realm',
          HttpClientBasicCredentials('u', 'p'),
        );
        client.close();
        return 'ok';
      }
      ''';
      expect(execute(source), equals('ok'));
    });

    test('F-SCC64-9: addProxyCredentials takes the same value [2026-09-06]', () {
      // The second call site, which takes the credentials in position 3 rather
      // than position 2 — a bridge that unwrapped by argument index would pass
      // F-SCC64-8 and fail here.
      const source = '''
      import 'dart:io';
      main() {
        var client = HttpClient();
        client.addProxyCredentials(
          '127.0.0.1',
          1,
          'realm',
          HttpClientDigestCredentials('u', 'p'),
        );
        client.close();
        return 'ok';
      }
      ''';
      expect(execute(source), equals('ok'));
    });

    test(
      'F-SCC64-10: the marker interface cannot be constructed [2026-09-06]',
      () {
        // `abstract interface class HttpClientCredentials {}` — no factory, so
        // real Dart rejects `HttpClientCredentials()` at compile time. Before the
        // fix this call *succeeded* and handed the script a `Type` object, which
        // is the same defect as the silent `false`, seen from the other side.
        const source = '''
      import 'dart:io';
      main() { return HttpClientCredentials(); }
      ''';
        expect(
          () => execute(source),
          throwsRuntimeError(contains('HttpClientCredentials')),
        );
      },
    );
  });

  group('SCC64: the bridge selected for a credentials value', () {
    test('F-SCC64-11: a basic-credentials value dispatches through its own '
        'bridge, not the marker [2026-09-06]', () {
      // Both bridges answer `isAssignable` true for the same native object, and
      // hand-written bridges carry `hierarchyDepth == 0` — so the tie is broken
      // by the name-based supertype walk over the edge F-SCC64-2 relies on. If
      // the marker won, `is HttpClientBasicCredentials` would be answered by
      // the wrong bridge and the whole group above would rest on a coincidence.
      //
      // Asked through the undefined-member diagnostic, because that message
      // names the *selected* bridge rather than re-asking the same predicate.
      // `runtimeType` cannot answer it: a bridged instance reports the
      // wrapper's own type (`BridgedInstance<Object>`), naming neither bridge.
      const source = '''
      import 'dart:io';
      main() { return HttpClientBasicCredentials('u', 'p').noSuchMember; }
      ''';
      expect(
        () => execute(source),
        throwsRuntimeError(
          allOf(
            contains('HttpClientBasicCredentials'),
            isNot(contains("of 'HttpClientCredentials'")),
          ),
        ),
      );
    });
  });
}
