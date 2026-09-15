// The one surviving `_notAuditable` reason names its own expiry. This checks it.
//
// WHY THIS FILE EXISTS. `_notAuditable` in `tool/stdlib_member_diff.dart` is the
// table of classes the member audit cannot measure, each with a stated reason.
// Its own doc comment calls every entry "a pointer at work to do rather than a
// permanent exemption". The trouble is that a reason is PROSE: nothing re-reads
// it, so it stays believed until somebody happens to test it.
//
// THE TABLE'S TRACK RECORD IS THE ARGUMENT. It held four entries. Three of the
// four stated reasons turned out to be FALSE, and each took a dedicated piece of
// work to discover:
//
//   | entry                 | stated reason                          | verdict |
//   | --------------------- | -------------------------------------- | ------- |
//   | `HttpClientRequest`   | arrives bridged as its `IOSink`        | WRONG   |
//   |                       | supertype, hiding every member         | (SCD44) |
//   | `HttpHeaders`         | unreachable, same misbridging          | WRONG   |
//   |                       |                                        | (SCD44) |
//   | `HttpClientResponse`  | needs a round trip that does not       | WRONG   |
//   |                       | finish — the probe hangs               | (SCD45) |
//   | `Stdin`               | no constructor; the only instance is   | RIGHT   |
//   |                       | the process's own fd 0                 |         |
//
// Three wrong out of four, and the wrong ones had been believed long enough to
// be quoted in other documents. `HttpClientRequest` in fact resolves correctly —
// bridge selection canonicalizes `_HttpClientRequest` to `HttpClientRequest`
// before any ancestor scan ever runs.
//
// WHAT CAN AND CANNOT BE MECHANISED. No test can verify an arbitrary prose
// reason, and pretending otherwise would be worse than the prose. But the
// surviving entry does something the three wrong ones did not: it states a
// CONDITION under which it stops being true. Quoting it —
//
//     That is survivable while `Stdin` exposes nothing but `readLineSync` and
//     `hasTerminal`; it stops being survivable the moment `Stdin` gains a
//     `Stream` supertype, because the probe then bare-reads `stdin.length`,
//     `stdin.first`, `stdin.last` — and a bare read of a `Stream` getter
//     SUBSCRIBES.
//
// That is checkable, and this file checks it. It is the shape the other three
// entries lacked: had they named a condition, the condition could have been
// tested and the three findings would have arrived years earlier than they did.
//
// THE CONSEQUENCE IS NOT THEORETICAL. Subscribing to fd 0 inside `dart test`
// does not fail one probe — it destroys the descriptor for the whole PROCESS,
// and every suite registering `dart:io` afterwards dies in
// `IoStdioStdlib.register`. So this guard fails BEFORE the audit is widened,
// which is the only useful time for it to fail.
//
// BOTH HALVES SEEN TO FAIL, at different lines:
//
//   | Injected fault                                  | Fires            |
//   | ----------------------------------------------- | ---------------- |
//   | a `first` getter added to the `Stdin` bridge     | the intersection |
//   | `hasTerminal` renamed away                       | the anti-vacuity |
//
// The second row is why the anti-vacuity check is here rather than assumed: an
// intersection with an empty set is empty, so without it this file would go
// green by measuring nothing at all.

import 'package:test/test.dart';
import 'package:tom_d4rt/src/stdlib/io/stdio.dart';

/// `Stream` getters whose BARE READ subscribes to the stream.
///
/// Reading any of these off `stdin` consumes the process's standard input. They
/// are named explicitly rather than derived from the `Stream` bridge, because
/// the subject is which members a PROBE would bare-read, and the audit's probe
/// reads getters — so deriving the set from the bridge would silently widen it
/// to methods, which the probe calls rather than reads.
const _subscribingGetters = <String>{
  'first',
  'last',
  'single',
  'length',
  'isEmpty',
};

void main() {
  group('SCD188: the Stdin audit reason has not expired', () {
    test('F-SCD188-1: Stdin exposes no getter a probe could subscribe through '
        '[2026-09-15] (PASS)', () {
      final definition = StdinIo.definition;

      // Anti-vacuity, and it is load-bearing here rather than ceremonial: the
      // assertion below is an emptiness check over a set intersection, and an
      // empty or renamed getter map would satisfy it while measuring nothing.
      expect(
        definition.getters.keys,
        containsAll(<String>['hasTerminal', 'echoMode']),
        reason:
            'The Stdin bridge no longer declares the getters this guard was '
            'written against, so the intersection below proves nothing.',
      );

      final reachable = <String>{
        ...definition.getters.keys,
        ...definition.methods.keys,
      };

      expect(
        reachable.intersection(_subscribingGetters),
        isEmpty,
        reason:
            'The `Stdin` entry in `_notAuditable` (tool/stdlib_member_diff.dart) '
            'says it is survivable only while `Stdin` exposes nothing a probe '
            'would bare-read. One of ${_subscribingGetters.join(', ')} is now '
            'on the bridge, so the audit probe would SUBSCRIBE to fd 0 — which '
            'does not fail one probe, it destroys standard input for the whole '
            'test process and every later suite registering dart:io dies in '
            'IoStdioStdlib.register.\n\n'
            'The entry has expired. Either keep the member off this bridge, or '
            'rewrite the reason to say what is true now — it is the last '
            'surviving entry in a table whose other three reasons were all '
            'found false.',
      );
    });

    test('F-SCD188-2: `listen` is present, and is not a counter-example '
        '[2026-09-15] (PASS)', () {
      // Worth pinning because it looks like one. `Stdin` DOES bridge `listen`,
      // which subscribes — but a probe calls methods rather than bare-reading
      // them, and calling `listen` needs an argument the probe has no way to
      // supply. So the member is safe for the audit while the getters above
      // are not, and the distinction is the whole reason `_subscribingGetters`
      // is a hand-written getter list rather than everything `Stream` supplies.
      expect(StdinIo.definition.methods.keys, contains('listen'));
    });
  });
}
