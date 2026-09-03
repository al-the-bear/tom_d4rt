/// SCB28: wrong-arity calls into hand-written stdlib bridges.
///
/// The hand-written bridges under `lib/src/stdlib/` read their arguments as
/// `positionalArgs[0]`, `positionalArgs[1]`, … A measured 601 of the 1203
/// adapters that index the list do so without first establishing that the
/// index is in range, so a call with too few arguments reaches the raw index
/// and the script author is shown a list `RangeError` that names neither the
/// class nor the member:
///
///     UriData.parse()
///     → Native error during static bridged method call 'parse' on UriData:
///       RangeError (length): Invalid value: Valid value range is empty: 0
///
/// This is not hypothetical: Cluster E #9 (`stdlib/async/timer_test.dart`) was
/// a production instance of exactly this shape.
///
/// Rather than hand-patch 601 adapters twice over, the too-few half is fixed
/// generically at the dispatch boundary — [D4.describeArityError] recognises a
/// `RangeError` raised by indexing the argument list itself and restates it in
/// terms the script author can act on. The too-many half cannot be recognised
/// generically (the dispatcher holds no arity metadata for an adapter), so it
/// stays a per-adapter guard; `UriData` is guarded here as the reference.
library;

import 'package:test/test.dart';
import '../interpreter_test.dart';

/// Fails the test with the actual message when [source] does not throw.
String _messageOf(String source) {
  try {
    final result = execute(source);
    fail('expected a RuntimeD4rtException, but the call returned: $result');
  } catch (e) {
    return e.toString();
  }
}

void main() {
  group('SCB28 — too few arguments names the member (generic)', () {
    test(
        'F-SCB28-1: static bridged method — DateTime.parse() names the member '
        'and the counts [2026-09-03]', () {
      final message = _messageOf("main() { return DateTime.parse(); }");
      expect(message, contains('DateTime.parse'));
      expect(message, contains('at least 1'));
      expect(message, contains('called with 0'));
      expect(message, isNot(contains('RangeError')));
    });

    test(
        'F-SCB28-2: instance bridged method — "ab".padLeft() names the member '
        '[2026-09-03]', () {
      final message = _messageOf("main() { return 'ab'.padLeft(); }");
      expect(message, contains('String.padLeft'));
      expect(message, isNot(contains('RangeError')));
    });

    test('F-SCB28-3: static on a core scalar — int.parse() [2026-09-03]', () {
      final message = _messageOf("main() { return int.parse(); }");
      expect(message, contains('int.parse'));
      expect(message, isNot(contains('RangeError')));
    });

    test('F-SCB28-4: instance on a core collection — sublist() [2026-09-03]',
        () {
      final message =
          _messageOf("main() { var l = [1,2,3]; return l.sublist(); }");
      expect(message, contains('sublist'));
      expect(message, isNot(contains('RangeError')));
    });

    test('F-SCB28-5: bridged constructor — UriData.fromString() [2026-09-03]',
        () {
      final message = _messageOf("main() { return UriData.fromString(); }");
      expect(message, contains('UriData.fromString'));
      expect(message, isNot(contains('RangeError')));
    });

    test(
        'F-SCB28-6: a multi-argument member reports the count it actually '
        'needs, not just "one more" [2026-09-03]', () {
      // `String.replaceRange(start, end, replacement)` reads three slots. The
      // count in the message comes from the slot the adapter reached, so a
      // one-argument call names 3 rather than the 2 a naive "first missing
      // slot" reading would give.
      final message =
          _messageOf("main() { return 'abcdef'.replaceRange(1); }");
      expect(message, contains('String.replaceRange'));
      expect(message, contains('at least 3'));
      expect(message, contains('called with 1'));
    });
  });

  group('SCB28 — the generic diagnostic does not over-report', () {
    test(
        'F-SCB28-7: correctly-arity\'d calls are untouched — UriData.parse '
        'still parses [2026-09-03]', () {
      expect(
        execute("main() { return UriData.parse('data:,hello').contentText; }"),
        equals('hello'),
      );
    });

    test(
        'F-SCB28-8: a genuine out-of-range inside the native call is still '
        'reported as a RangeError, not as an arity error [2026-09-03]', () {
      // sublist(0, 99) passes the right *number* of arguments; the RangeError
      // comes from the native call and must survive as one.
      final message =
          _messageOf("main() { var l = [1,2,3]; return l.sublist(0, 99); }");
      expect(message, contains('RangeError'));
      expect(message, isNot(contains('positional argument')));
    });
  });

  group('SCB28 — too many arguments is rejected (per-adapter, UriData)', () {
    test(
        'F-SCB28-9: UriData.parse(source, extra) no longer silently discards '
        'the extra [2026-09-03]', () {
      final message = _messageOf(
          "main() { return UriData.parse('data:,a', 'extra').contentText; }");
      expect(message, contains('UriData.parse'));
    });

    test('F-SCB28-10: instance method — isMimeType(type, extra) [2026-09-03]',
        () {
      final message = _messageOf(
          "main() { return UriData.parse('data:,a').isMimeType('text/plain', 'x'); }");
      expect(message, contains('UriData.isMimeType'));
    });

    test(
        'F-SCB28-11: a method that takes no positional arguments rejects one '
        '[2026-09-03]', () {
      final message = _messageOf(
          "main() { return UriData.parse('data:,a').contentAsString('x'); }");
      expect(message, contains('UriData.contentAsString'));
    });

    test('F-SCB28-12: bridged constructor — fromUri(uri, extra) [2026-09-03]',
        () {
      final message = _messageOf(
          "main() { return UriData.fromUri(Uri.parse('data:,a'), 'x').contentText; }");
      expect(message, contains('UriData.fromUri'));
    });

    test(
        'F-SCB28-13: an explicit per-adapter guard takes precedence over the '
        'generic diagnostic for too few, too [2026-09-03]', () {
      // The generic path would say "expects at least 1 positional argument";
      // because UriData.parse is explicitly guarded it never reaches the
      // index, so the adapter's own — more specific, type-naming — message is
      // what the author sees. Both name the member, which is the contract.
      final message = _messageOf("main() { return UriData.parse(); }");
      expect(message, contains('UriData.parse'));
      expect(message, contains('exactly one String argument'));
      expect(message, isNot(contains('RangeError')));
    });
  });
}
