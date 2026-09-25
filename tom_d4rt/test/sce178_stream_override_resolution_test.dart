/// SCE178 — the two private SDK types the Stream bridge used to claim resolve
/// to the bridge they actually belong to, in the LIVE registry.
///
/// Measured with the SDK: `_StreamIterator` is what `StreamIterator(...)`
/// returns and `_HandlerEventSink` implements `EventSink`; neither is a Stream.
/// Both were on the Stream bridge's `nativeNames`. The first was inert, because
/// its name reaches `StreamIterator` first. The second was ALSO on EventSink's
/// list, and registration order made the Stream entry win, so the live
/// registry answered `Stream` for a type that is not one.
///
/// `_HandlerEventSink` never reaches script code (the SDK builds it inside
/// `StreamTransformer.fromHandlers` and consumes it itself), so the classes
/// below borrow the private names: resolution goes by the runtime type's NAME,
/// which is exactly what these reproduce. The same technique as SCF26's test.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

// ignore: unused_element
class _HandlerEventSink<S, T> {}

// ignore: unused_element
class _StreamIterator<T> {}

void main() {
  late Environment env;

  setUpAll(() async {
    final d4rt = D4rt();
    await d4rt.execute(source: 'dynamic main() => 1;');
    env = d4rt.visitor!.globalEnvironment;
  });

  group('SCE178: the Stream bridge claims no non-Stream', () {
    test(
      'F-SCE178-1: _HandlerEventSink resolves to EventSink [2026-09-25]',
      () {
        expect(
          env.toBridgedClass(_HandlerEventSink<int, int>().runtimeType).name,
          'EventSink',
        );
      },
    );

    test('F-SCE178-2 (control): _StreamIterator resolves to StreamIterator '
        '[2026-09-25]', () {
      expect(
        env.toBridgedClass(_StreamIterator<int>().runtimeType).name,
        'StreamIterator',
      );
    });
  });
}
