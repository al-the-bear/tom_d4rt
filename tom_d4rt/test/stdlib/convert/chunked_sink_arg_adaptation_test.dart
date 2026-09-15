// `startChunkedConversion` accepts a sink a SCRIPT built.
//
// THE DEFECT, and it is the contravariant twin of SCC68. The interpreter
// erases type arguments, so `ChunkedConversionSink.withCallback(cb)` evaluates
// to a native `ChunkedConversionSink<Object?>`. Dart generics are covariant, so
// `Sink<Object?>` is NOT a `Sink<String>` — and every `startChunkedConversion`
// adapter in `stdlib/convert` guarded on `is! Sink<T>` and then cast to
// `Sink<T>`. Fourteen such guards across nine files, each rejecting every sink
// a script could construct, which made the whole chunked surface unreachable
// exactly as `Converter.bind` was before SCC68.
//
// WHY A WRAPPER AND NOT A COERCION. `D4.coerceStream` maps a stream's elements
// on the way out; a `Stream<T>` is a PRODUCER and there is something to map. A
// `Sink<T>` is a CONSUMER — nothing has been produced, only a method that will
// later be called with a `T`. So `D4.adaptSink` returns a forwarding
// `Sink<T>` that delegates `add` and `close` to the erased sink underneath.
//
// ONE WRAPPER COVERS ALL FOURTEEN, which was measured rather than assumed. The
// todo anticipated needing `ChunkedConversionSink<T>` / `ByteConversionSink` /
// `StringConversionSink` variants; in fact every one of the guarded sites casts
// the ARGUMENT to a plain `Sink<T>` — the casts to those subtypes in the same
// files are all on the RECEIVER (`target as ByteConversionSink`), which this
// change does not touch.
//
// THE GUARD STAYS, NARROWED TO `is! Sink`. SCC68 established why and it is
// unchanged: `D4.*` helpers throw `ArgumentD4rtException` while stdlib adapters
// throw `RuntimeD4rtException`, and those are SIBLINGS under `D4rtException`,
// not parent and child. Routing the whole check through the helper would
// silently change what a script's `catch` dispatches on. F-SCD181-5 pins that
// the non-sink case still raises the adapter's own exception.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Every family with a `startChunkedConversion` a script can now reach.
///
/// Both element types are represented — `String` sinks and `List<int>` sinks —
/// because the erasure bites identically on each and a table of one would leave
/// the other unproven.
const _chunkedCases = <String, ({String script, Object? expected})>{
  'utf8.decoder': (
    script: '''
      var out = [];
      var sink = ChunkedConversionSink.withCallback((c) { out.add(c); });
      var inner = utf8.decoder.startChunkedConversion(sink);
      inner.add([104, 105]);
      inner.close();
      return out.toString();
    ''',
    expected: '[[hi]]',
  ),
  'utf8.encoder': (
    script: '''
      var out = [];
      var sink = ChunkedConversionSink.withCallback((c) { out.add(c); });
      var inner = utf8.encoder.startChunkedConversion(sink);
      inner.add('hi');
      inner.close();
      return out.length;
    ''',
    expected: 1,
  ),
  'LineSplitter': (
    script: '''
      var out = [];
      var sink = ChunkedConversionSink.withCallback((c) { out.add(c); });
      var inner = LineSplitter().startChunkedConversion(sink);
      inner.add('a\\nb\\n');
      inner.close();
      return out.toString();
    ''',
    expected: '[[a, b]]',
  ),
  'JsonEncoder': (
    script: '''
      var out = [];
      var sink = ChunkedConversionSink.withCallback((c) { out.add(c); });
      var inner = JsonEncoder().startChunkedConversion(sink);
      inner.add({'a': 1});
      inner.close();
      return out.length;
    ''',
    expected: 1,
  ),
  'ascii.decoder': (
    script: '''
      var out = [];
      var sink = ChunkedConversionSink.withCallback((c) { out.add(c); });
      var inner = ascii.decoder.startChunkedConversion(sink);
      inner.add([104, 105]);
      inner.close();
      return out.toString();
    ''',
    expected: '[[hi]]',
  ),
  'latin1.decoder': (
    script: '''
      var out = [];
      var sink = ChunkedConversionSink.withCallback((c) { out.add(c); });
      var inner = latin1.decoder.startChunkedConversion(sink);
      inner.add([104, 105]);
      inner.close();
      return out.toString();
    ''',
    expected: '[[hi]]',
  ),
  'HtmlEscape': (
    script: '''
      var out = [];
      var sink = ChunkedConversionSink.withCallback((c) { out.add(c); });
      var inner = HtmlEscape().startChunkedConversion(sink);
      inner.add('<a>');
      inner.close();
      return out.toString();
    ''',
    expected: '[[&lt;a&gt;]]',
  ),
  'base64.encoder': (
    script: '''
      var out = [];
      var sink = ChunkedConversionSink.withCallback((c) { out.add(c); });
      var inner = base64.encoder.startChunkedConversion(sink);
      inner.add([104, 105]);
      inner.close();
      return out.length;
    ''',
    expected: 1,
  ),
};

const String _libPath = 'd4rt-mem:/chunked_sink_arg_adaptation_test.dart';

dynamic _run(String body) {
  final source = "import 'dart:convert';\nmain() {\n$body\n}";
  return D4rt().execute(
    library: _libPath,
    name: 'main',
    sources: {_libPath: source},
  );
}

void main() {
  group('SCD181: a script-built sink reaches startChunkedConversion', () {
    test('F-SCD181-1: the table covers both element types '
        '[2026-09-15] (PASS)', () {
      // Anti-vacuity. The erasure is identical for `Sink<String>` and
      // `Sink<List<int>>`, but a table of only one leaves the other unproven,
      // and the guards were split roughly evenly between them.
      expect(_chunkedCases, hasLength(greaterThanOrEqualTo(6)));
      expect(
        _chunkedCases.keys.where((k) => k.contains('decoder')),
        isNotEmpty,
        reason: 'no byte-consuming sink (Sink<String> after decode)',
      );
      expect(
        _chunkedCases.keys.where((k) => k.contains('encoder')),
        isNotEmpty,
        reason: 'no string-consuming sink (Sink<List<int>> after encode)',
      );
    });

    for (final entry in _chunkedCases.entries) {
      test('F-SCD181-2-${entry.key}: chunked conversion runs end to end '
          '[2026-09-15] (PASS)', () {
        expect(_run(entry.value.script), entry.value.expected);
      });
    }

    test('F-SCD181-3: ByteConversionSink.from takes a script sink '
        '[2026-09-15] (PASS)', () {
      // The static that is not a `startChunkedConversion` but carried the same
      // guard — the one the todo names beside the chunked family.
      expect(
        _run('''
            var sink = ChunkedConversionSink.withCallback((c) {});
            return ByteConversionSink.from(sink) != null;
        '''),
        isTrue,
      );
    });

    test('F-SCD181-4: the adapted sink forwards close, not just add '
        '[2026-09-15] (PASS)', () {
      // `close` is the half a wrapper is most likely to drop, and dropping it
      // loses the final chunk rather than failing — the callback never fires
      // and the script sees an empty result it cannot explain.
      expect(
        _run('''
            var closed = false;
            var sink = ChunkedConversionSink.withCallback((c) { closed = true; });
            var inner = utf8.decoder.startChunkedConversion(sink);
            inner.add([104]);
            if (closed) { return 'closed too early'; }
            inner.close();
            return closed;
        '''),
        isTrue,
      );
    });

    test('F-SCD181-5: a non-sink still raises the ADAPTER\'s exception '
        '[2026-09-15] (PASS)', () {
      // SCC68's rule, unchanged: `D4.*` throws ArgumentD4rtException and stdlib
      // adapters throw RuntimeD4rtException, and those are SIBLINGS under
      // D4rtException. Narrowing the guard to `is! Sink` rather than deleting
      // it is what keeps a script's `catch` dispatching on the same type.
      expect(
        () => _run('return utf8.decoder.startChunkedConversion(42);'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains('requires a Sink'),
          ),
        ),
      );
    });
  });
}
