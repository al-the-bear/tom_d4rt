// SCD26: an over-narrow cast rejects arguments a script is entitled to pass.
//
// d4rt evaluates a list literal to `List<Object?>` and a map literal to
// `Map<Object?, Object?>` — element and key types are erased — and values that
// came from bridged code arrive as `BridgedInstance` wrappers. So an adapter
// written `positionalArgs[0] as Iterable<int>` tests the CONTAINER's type
// argument, which never matches, rather than its CONTENTS, which usually do.
//
// THE ASYMMETRY IS WHY THESE SURVIVE REVIEW. `Runes('ab').followedBy(Runes('c'))`
// passes the cast and `Runes('ab').followedBy([99])` does not, so the natural
// spot-check reaches for the typed form and sees nothing wrong. Every case below
// therefore passes a LITERAL, which is the shape that was broken.
//
// SCC9 fixed this across eleven typed-data bridges; SCD26 measured how far it
// reaches beyond them and fixed the `core` and `convert` sites. Probed before
// changing anything, because the todo was explicit that not every site is
// broken: `Function.apply` and `latin1.encode` were already correct and are
// asserted here so a future sweep does not "fix" them into a regression.
//
// COERCION MUST NOT WIDEN, which is the half that needs its own cases. An
// element whose type genuinely does not fit must still fail — accepting an
// argument the SDK rejects makes a script green here that cannot compile as
// Dart, and that is the one bridge defect no passing test can catch.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  dynamic run(String source) {
    final d4rt = D4rt();
    d4rt.grant(FilesystemPermission.any);
    return d4rt.execute(source: source);
  }

  group(
    'SCD26: a literal is a valid argument where the SDK takes a collection',
    () {
      test('F-SCD26-1: Runes.followedBy accepts a list literal [2026-09-12] '
          '(PASS)', () {
        expect(
          run("main() => Runes('ab').followedBy([99]).toList();"),
          equals([97, 98, 99]),
        );
      });

      test('F-SCD26-2: RegExpMatch.groups accepts a list literal [2026-09-12] '
          '(PASS)', () {
        expect(
          run(
            r"main() { var m = RegExp('(a)(b)').firstMatch('ab'); "
            r"return m.groups([1, 2]); }",
          ),
          equals(['a', 'b']),
        );
      });

      test('F-SCD26-3: Uri accepts a map literal for queryParameters '
          '[2026-09-12] (PASS)', () {
        expect(
          run(
            "main() => Uri(scheme: 'x', host: 'y', "
            "queryParameters: {'a': 'b'}).toString();",
          ),
          equals('x://y?a=b'),
        );
      });

      test('F-SCD26-4: Uri accepts a list literal for pathSegments '
          '[2026-09-12] (PASS)', () {
        expect(
          run(
            "main() => Uri(scheme: 'x', host: 'y', "
            "pathSegments: ['a', 'b']).toString();",
          ),
          equals('x://y/a/b'),
        );
      });

      test('F-SCD26-5: latin1.decode accepts a list literal [2026-09-12] '
          '(PASS)', () {
        expect(
          run("import 'dart:convert'; main() => latin1.decode([104, 105]);"),
          equals('hi'),
        );
      });
    },
  );

  group('SCD26: coercion does not widen', () {
    test('F-SCD26-6: an element of the wrong type still fails [2026-09-12] '
        '(PASS)', () {
      // `Runes.followedBy` takes `Iterable<int>`. A String element is a type
      // error in Dart and must stay one here — this is the assertion that
      // separates a coercion from a blanket cast to dynamic.
      expect(
        () => run("main() => Runes('ab').followedBy(['x']).toList();"),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCD26-7: a map key of the wrong type still fails [2026-09-12] '
        '(PASS)', () {
      expect(
        () => run(
          "main() => Uri(scheme: 'x', host: 'y', "
          "queryParameters: {1: 'b'}).toString();",
        ),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCD26-8: a non-collection argument still fails [2026-09-12] '
        '(PASS)', () {
      expect(
        () => run("main() => Runes('ab').followedBy(7).toList();"),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });

  group('SCD26: the sites that were already correct stay correct', () {
    // Anti-regression for the probe result. Both of these were measured
    // WORKING before any change, so a later sweep that "fixes" every cast it
    // greps for would be changing code that was never broken — and these two
    // are the evidence that the sweep must probe rather than assume.
    test('F-SCD26-9: Function.apply took a list literal already [2026-09-12] '
        '(PASS)', () {
      expect(
        run("main() { f(a, b) => a + b; return Function.apply(f, [1, 2]); }"),
        equals(3),
      );
    });

    test(
      'F-SCD26-10: latin1.encode was never affected [2026-09-12] (PASS)',
      () {
        expect(
          run("import 'dart:convert'; main() => latin1.encode('hi').toList();"),
          equals([104, 105]),
        );
      },
    );
  });
}
