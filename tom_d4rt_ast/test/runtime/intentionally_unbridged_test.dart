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

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math.dart';

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
        expect(env.findBridgedClassByName(name), isNull,
            reason: '$name is listed as intentionally unbridged in '
                'd4rt_limitations.md but is registered in this tree');
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
        expect(env.findBridgedClassByName(name), isNull,
            reason: '$name is listed as deferred in d4rt_limitations.md but '
                'is registered in this tree');
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
        expect(env.findBridgedClassByName(name), isNull,
            reason: '$name is listed as deferred in d4rt_limitations.md but '
                'is registered in this tree');
      }
    });

    test('F-SCB29-AST-2: ByteBuffer is registered but carries none of the '
        'three SIMD views [2026-09-03]', () {
      // The other half of the block, and the reason this group is shaped
      // differently from the rest of the file: these are missing members on a
      // present class, so `findBridgedClassByName` would answer isNotNull and
      // prove nothing.
      final byteBuffer = env.findBridgedClassByName('ByteBuffer');
      expect(byteBuffer, isNotNull,
          reason: 'ByteBuffer must be registered for the member check below '
              'to mean anything');
      for (final view in const [
        'asFloat32x4List',
        'asInt32x4List',
        'asFloat64x2List',
      ]) {
        expect(byteBuffer!.methods, isNot(contains(view)),
            reason: 'ByteBuffer.$view is listed as deferred in '
                'd4rt_limitations.md but is registered in this tree');
      }
    });

    test('F-SCB29-AST-3: the non-SIMD typed lists and the other ByteBuffer '
        'views ARE registered [2026-09-03]', () {
      // Anchor. Without it every claim above would also hold if
      // `TypedDataStdlib` had simply not run.
      expect(env.findBridgedClassByName('Float32List'), isNotNull);
      expect(env.findBridgedClassByName('Uint8List'), isNotNull);
      expect(env.findBridgedClassByName('ByteBuffer')!.methods,
          contains('asUint8List'));
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
}
