// SC11 mirror: doc/d4rt_limitations.md § Intentionally-Unbridged SDK Classes
// says its list applies to BOTH interpreter trees, "by construction", because
// the two share one stdlib bridge set mirrored file-for-file.
//
// That claim is only load-bearing if someone checks it. The script-level pin
// lives in `tom_d4rt/test/stdlib/intentionally_unbridged_test.dart`; this file
// pins the same list on the analyzer-free side at registration level, which is
// as far as this tree can go on its own — driving a script needs the
// analyzer-based front end in `tom_d4rt_exec`, and that resolves this package
// from pub.dev rather than by path.
//
// Each group registers the library that WOULD own the class before asserting
// it is absent. Checking a stock environment instead would make the dart:io
// and dart:math cases pass vacuously — those registrars are lazy, so their
// classes are missing from a stock environment whether they are bridged or
// not, and the assertions would hold even if someone bridged every one of
// them.
//
// IF ONE OF THESE FAILS you have probably just bridged the class. That is
// allowed; the fix is to move the row out of the doc's table and delete the
// entry here, in the same change — not to loosen the test.
//
// SCB29 added the SIMD group. It is the only group here that also checks a
// *member* map: six of its nine names are absent classes, but the three
// ByteBuffer views are absent members of a class that IS registered, and at
// registration level those are two different assertions.
//
// SCB30 added the last group, which pins the reverse direction. The rest of the
// file walks a list of names and asserts each is absent; SCB30 walks the
// `kUnbridgedReasons` map that now supplies the *reason* in the error message
// and asserts the same thing of every key. That is the pin this tree can hold
// and the analyzer tree cannot: it needs a fully-registered environment, not a
// doc. (The doc-to-map equality is pinned on the analyzer side, where the doc
// lives.) The failure it catches is the one that matters — a class gets bridged
// and the interpreter carries on explaining why it is not.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math.dart';
import 'package:tom_d4rt_ast/src/runtime/unbridged_reasons.dart';

void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    // The public façade, i.e. the path the runner takes — so this pins what a
    // stock environment really offers, not what one registrar happens to hold.
    Stdlib(env).register();
  });

  group('SC11: cannot be honoured meaningfully', () {
    // Grouped exactly as the doc groups them, so a reader moving a row between
    // the two tables knows which list to edit here. These four live in
    // dart:core / dart:async, both of which `Stdlib.register` loads eagerly —
    // so a stock environment is the right place to look.
    const cannotHonour = <String>[
      'Zone',
      'Expando',
      'WeakReference',
      'Finalizer',
    ];

    test('F-SC11-AST-1: none of the identity/control-flow classes are '
        'registered [2026-07-27]', () {
      for (final name in cannotHonour) {
        expect(
          env.findBridgedClassByName(name),
          isNull,
          reason:
              '$name is listed as intentionally unbridged in '
              'd4rt_limitations.md but is registered in this tree',
        );
      }
    });

    test('F-SC11-AST-2: dart:core and dart:async are loaded, so the absences '
        'above are per-class [2026-07-27]', () {
      // Without this the group would also pass if the eager registrars had
      // simply not run, which would make every claim above vacuous.
      expect(env.findBridgedClassByName('Uri'), isNotNull);
      expect(env.findBridgedClassByName('Future'), isNotNull);
    });
  });

  group('SC11: deferred pending a concrete consumer — dart:io', () {
    setUp(() => IoStdlib.register(env));

    const deferred = <String>[
      'Link',
      'WebSocket',
      'GZipCodec',
      'ZLibCodec',
      'ZLibEncoder',
      'ZLibDecoder',
    ];

    test('F-SC11-AST-3: none of the deferred dart:io classes are registered '
        '[2026-07-27]', () {
      for (final name in deferred) {
        expect(
          env.findBridgedClassByName(name),
          isNull,
          reason:
              '$name is listed as deferred in d4rt_limitations.md but '
              'is registered in this tree',
        );
      }
    });

    test('F-SC11-AST-4: the dart:io registrar really ran [2026-07-27]', () {
      // `File` is the anchor: if this is null the group above proves nothing.
      expect(env.findBridgedClassByName('File'), isNotNull);
    });
  });

  group('SCB29: the SIMD block — dart:typed_data', () {
    // `TypedDataStdlib` is eager (GEN-106), so a stock environment is the right
    // place to look and no extra registrar call is needed.

    test('F-SCB29-AST-1: none of the six SIMD types are registered '
        '[2026-09-03]', () {
      // Three scalars and the three lists built on them. The lists are the
      // half that reads as an oversight rather than a decision, because they
      // are typed-data views exactly like the eleven that ARE registered.
      for (final name in const [
        'Float32x4',
        'Int32x4',
        'Float64x2',
        'Float32x4List',
        'Int32x4List',
        'Float64x2List',
      ]) {
        expect(
          env.findBridgedClassByName(name),
          isNull,
          reason:
              '$name is listed as deferred in d4rt_limitations.md but '
              'is registered in this tree',
        );
      }
    });

    test('F-SCB29-AST-2: ByteBuffer is registered but carries none of the '
        'three SIMD views [2026-09-03]', () {
      // The other half of the block, and the reason this group is shaped
      // differently from the rest of the file: these are missing members on a
      // present class, so `findBridgedClassByName` would answer isNotNull and
      // prove nothing.
      final byteBuffer = env.findBridgedClassByName('ByteBuffer');
      expect(
        byteBuffer,
        isNotNull,
        reason:
            'ByteBuffer must be registered for the member check below '
            'to mean anything',
      );
      for (final view in const [
        'asFloat32x4List',
        'asInt32x4List',
        'asFloat64x2List',
      ]) {
        expect(
          byteBuffer!.methods,
          isNot(contains(view)),
          reason:
              'ByteBuffer.$view is listed as deferred in '
              'd4rt_limitations.md but is registered in this tree',
        );
      }
    });

    test('F-SCB29-AST-3: the non-SIMD typed lists and the other ByteBuffer '
        'views ARE registered [2026-09-03]', () {
      // Anchor. Without it every claim above would also hold if
      // `TypedDataStdlib` had simply not run.
      expect(env.findBridgedClassByName('Float32List'), isNotNull);
      expect(env.findBridgedClassByName('Uint8List'), isNotNull);
      expect(
        env.findBridgedClassByName('ByteBuffer')!.methods,
        contains('asUint8List'),
      );
    });
  });

  group('SC11: deferred pending a concrete consumer — dart:math', () {
    // dart:math stays lazy and isolated on purpose (`min` / `max` / `pi` would
    // collide with user code), so it has to be registered explicitly here.
    setUp(() => MathStdlib.register(env));

    test('F-SC11-AST-5: MutableRectangle is absent from the registrar that '
        'would own it [2026-07-27]', () {
      expect(env.findBridgedClassByName('MutableRectangle'), isNull);
    });

    test('F-SC11-AST-6: Rectangle is registered, which is what lets '
        'MutableRectangle be deferred [2026-07-27]', () {
      // The doc defers the mutable variant *because* the immutable one covers
      // the common case. If Rectangle ever disappeared that reasoning would be
      // gone and the row would need rewriting rather than keeping.
      expect(env.findBridgedClassByName('Rectangle'), isNotNull);
    });
  });

  group('SCB30: the reason map agrees with the registry', () {
    // Register everything the two doc tables span, so a key that IS bridged is
    // actually visible here. Without the lazy registrars this group would pass
    // vacuously for the dart:io and dart:math halves — the same trap the file
    // header describes for the SC11 groups.
    setUp(() {
      IoStdlib.register(env);
      MathStdlib.register(env);
    });

    test('F-SCB30-AST-1: every name the interpreter explains as unbridged is '
        'genuinely unbridged [2026-09-03]', () {
      // The direction that rots: someone bridges `MutableRectangle`, the class
      // resolves, and the map is simply never consulted — silently stale until
      // the next reader wonders why the doc lists a class that works. Nothing
      // else in either tree would notice.
      for (final name in kUnbridgedReasons.keys) {
        // `lookup`, not `findBridgedClassByName`: six of the keys — `gzip`,
        // `zlib` and the `runZoned*` pair among them — are top-level globals
        // and functions rather than classes, so a class-only check would let
        // them be registered without noticing. `lookup` is the exact path
        // `get` takes, which is the path that produces the message.
        expect(
          env.lookup(name),
          same(Environment.kNotFound),
          reason:
              '$name now resolves, but kUnbridgedReasons still explains '
              'why it does not — drop the entry and the doc row together',
        );
      }
    });

    test('F-SCB30-AST-2: the lookup failure carries the reason, an ordinary '
        'miss does not [2026-09-03]', () {
      // Through `Environment.get`, i.e. the real failure path — not by calling
      // the message builder, which F-SCB30-AST-3 covers separately.
      expect(
        () => env.get('Zone'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            allOf(
              contains('Undefined variable: Zone'),
              contains('not bridged:'),
              contains('d4rt_limitations.md'),
            ),
          ),
        ),
      );
      expect(
        () => env.get('Zoen'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            equals('Undefined variable: Zoen'),
          ),
        ),
      );
    });

    test('F-SCB30-AST-3: the prefix is a prefix, so every matcher in this file '
        'and the analyzer tree still holds [2026-09-03]', () {
      for (final name in kUnbridgedReasons.keys) {
        expect(
          undefinedVariableMessage(name),
          startsWith('Undefined variable: $name ('),
          reason: '$name must keep the bare prefix followed by the reason',
        );
      }
    });

    test('F-SCB30-AST-4: the registrars really ran, so the absences above are '
        'per-class [2026-09-03]', () {
      // Anchor for this group's own setUp, matching F-SC11-AST-4 / -6.
      expect(env.findBridgedClassByName('File'), isNotNull);
      expect(env.findBridgedClassByName('Rectangle'), isNotNull);
      expect(env.findBridgedClassByName('Float32List'), isNotNull);
    });
  });
}
