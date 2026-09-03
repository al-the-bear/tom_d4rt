// SC11: the "Intentionally-Unbridged SDK Classes" section of
// doc/d4rt_limitations.md makes a claim about the code — that these names are
// absent on purpose. Prose cannot hold that claim: the moment someone bridges
// one of them the doc starts lying, and a limitations doc that lies is worse
// than no limitations doc.
//
// So the section is pinned here. Each case asserts the name is unresolvable
// AND that the failure is the message the doc tells readers to search for.
//
// IF ONE OF THESE FAILS you have probably just bridged the class — which is
// allowed, and for the "deferred pending a concrete consumer" group it is the
// expected end state. The fix is not to loosen the test: move the row out of
// the doc's table and delete the case here, in the same change.
//
// SCB29 added the SIMD group and, with it, the rule that makes this file
// complete rather than merely correct: every unbridged SDK name the gap audit
// records must carry a disposition — a tracked todo, or a row in the
// limitations table with a case here. The SIMD block had neither, which is
// why it went nine names unmissed. See the audit's "Disposition" rule in
// doc/stdlib_sdk_gap_audit.md § Recommended next actions.

import 'package:test/test.dart';

import '../interpreter_test.dart';

void main() {
  /// Asserts that [expression] fails because [reported] is not defined.
  ///
  /// [reported] is the identifier the interpreter names — which is not always
  /// the class. A script reaches `Zone` by writing `runZoned`, and the
  /// `dart:io` compression codecs by writing the `gzip` / `zlib` globals, so
  /// those are the names a reader actually greps for.
  void expectUnbridged(String expression, String reported, {String? imports}) {
    final source = '''
      ${imports ?? ''}
      main() {
        return $expression;
      }
    ''';
    expect(() => execute(source),
        throwsRuntimeError(contains('Undefined variable: $reported')));
  }

  group('SC11: cannot be honoured meaningfully', () {
    test('F-SC11-1: Zone is unreachable, including via runZoned [2026-07-27]',
        () {
      // Three names, one decision: scripts almost never write `Zone` directly,
      // so the doc has to be findable from the runZoned* spellings too.
      expectUnbridged('Zone.current', 'Zone', imports: "import 'dart:async';");
      expectUnbridged(
          'runZoned(() => 1)', 'runZoned', imports: "import 'dart:async';");
      expectUnbridged('runZonedGuarded(() => 1, (e, s) {})', 'runZonedGuarded',
          imports: "import 'dart:async';");
      // Anchor: without this the three above would also pass if `dart:async`
      // were simply unreachable, and the claim would be vacuous.
      const anchor = '''
      import 'dart:async';
      main() => Completer<int>().isCompleted;
      ''';
      expect(execute(anchor), isFalse);
    });

    test('F-SC11-2: the identity/GC trio is unreachable [2026-07-27]', () {
      // Expando, WeakReference and Finalizer all depend on native object
      // identity or GC timing, neither of which survives the bridge boundary.
      expectUnbridged('Expando()', 'Expando');
      expectUnbridged('WeakReference(Object())', 'WeakReference');
      expectUnbridged('Finalizer((v) {})', 'Finalizer');
    });
  });

  group('SC11: deferred pending a concrete consumer', () {
    test('F-SC11-3: the dart:io entries are unreachable [2026-07-27]', () {
      expectUnbridged("Link('x')", 'Link', imports: "import 'dart:io';");
      expectUnbridged("WebSocket.connect('ws://x')", 'WebSocket',
          imports: "import 'dart:io';");
    });

    test('F-SC11-4: the compression codecs are unreachable under every '
        'spelling [2026-07-27]', () {
      // The globals matter more than the class names here — `gzip.encode(...)`
      // is what a script writes, and it is the message that sends a reader to
      // the doc. Unrelated to the gzip AstBundle uses internally, which is
      // below the bridge boundary and gives scripts nothing.
      expectUnbridged('gzip.encode([1, 2, 3])', 'gzip',
          imports: "import 'dart:io';");
      expectUnbridged('zlib.encode([1, 2, 3])', 'zlib',
          imports: "import 'dart:io';");
      expectUnbridged('GZipCodec()', 'GZipCodec', imports: "import 'dart:io';");
      expectUnbridged('ZLibCodec()', 'ZLibCodec', imports: "import 'dart:io';");
      expectUnbridged('ZLibEncoder()', 'ZLibEncoder',
          imports: "import 'dart:io';");
      expectUnbridged('ZLibDecoder()', 'ZLibDecoder',
          imports: "import 'dart:io';");
    });

    test('F-SC11-5: MutableRectangle is unreachable but Rectangle covers the '
        'common case [2026-07-27]', () {
      // The second half is the doc's stated justification for deferring the
      // mutable variant, so it has to hold for the row to stay honest.
      expectUnbridged('MutableRectangle(0, 0, 1, 1)', 'MutableRectangle',
          imports: "import 'dart:math';");
      const source = '''
      import 'dart:math';
      main() {
        final r = Rectangle(0, 0, 4, 3);
        return [r.width, r.height, r.right, r.bottom];
      }
      ''';
      expect(execute(source), equals([4, 3, 4, 3]));
    });
  });

  group('SCB29: the SIMD block', () {
    // SCB29 found this block unbridged, untracked and undocumented — the
    // "neither" state the reconciliation exists to remove. It is nine names,
    // not the three the gap audit's ByteBuffer row implied: the scalars, the
    // three lists built from them, and the three views that return those.
    test('F-SCB29-1: the three SIMD scalars are unreachable [2026-09-03]', () {
      const td = "import 'dart:typed_data';";
      expectUnbridged('Float32x4(1, 2, 3, 4)', 'Float32x4', imports: td);
      expectUnbridged('Int32x4(1, 2, 3, 4)', 'Int32x4', imports: td);
      expectUnbridged('Float64x2(1, 2)', 'Float64x2', imports: td);
    });

    test('F-SCB29-2: the three SIMD lists are unreachable too — the audit '
        'named only the scalars [2026-09-03]', () {
      // These are the reason the count is nine rather than six: they are
      // typed-data views like the eleven that ARE bridged, so their absence
      // reads as an oversight in that set rather than as this decision.
      const td = "import 'dart:typed_data';";
      expectUnbridged('Float32x4List(2)', 'Float32x4List', imports: td);
      expectUnbridged('Int32x4List(2)', 'Int32x4List', imports: td);
      expectUnbridged('Float64x2List(2)', 'Float64x2List', imports: td);
    });

    test('F-SCB29-3: the three ByteBuffer SIMD views fail with a DIFFERENT '
        'message than the classes [2026-09-03]', () {
      // `ByteBuffer` is bridged, so these are missing *members*, not missing
      // names: they raise an SDK-shaped `NoSuchMethodError` rather than the
      // `RuntimeD4rtException` every other case here expects. The doc has to
      // send readers to the right string, so the distinction is pinned.
      for (final view in const [
        'asFloat32x4List',
        'asInt32x4List',
        'asFloat64x2List'
      ]) {
        expect(
          () => execute("import 'dart:typed_data';\n"
              'main() => Uint8List(64).buffer.$view();'),
          throwsA(isA<NoSuchMethodError>().having((e) => e.toString(),
              'toString', contains("has no instance method named '$view'"))),
          reason: 'ByteBuffer.$view should report a missing member',
        );
      }
    });

    test('F-SCB29-4: the eleven non-SIMD typed lists still work, so the block '
        'above is a decision and not a dead library [2026-09-03]', () {
      // Without this anchor every claim above would also hold if
      // `dart:typed_data` were simply unreachable.
      const source = '''
      import 'dart:typed_data';
      main() {
        final f = Float32List(2);
        f[0] = 1.5;
        return [f.length, f[0], Uint8List(64).buffer.asUint8List().length];
      }
      ''';
      expect(execute(source), equals([2, 1.5, 64]));
    });
  });

  group('SC11: the section is reachable from the message', () {
    test('F-SC11-6: dart:io itself still works, so the absences above are '
        'per-class and not a dead library [2026-07-27]', () {
      // Without this the group above would also pass if `dart:io` were simply
      // unreachable, which would make every claim in the doc vacuous.
      const source = '''
      import 'dart:io';
      main() => File('x').path;
      ''';
      expect(execute(source), equals('x'));
    });
  });
}
