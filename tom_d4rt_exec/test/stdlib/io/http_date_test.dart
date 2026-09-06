import 'package:test/test.dart';
import '../../interpreter_test.dart';

/// SCC65 — `HttpDate`, the RFC-1123 date codec `dart:io` re-exports.
///
/// The simplest of the five names SCB21's audit left unreachable: a class with
/// exactly two public members, both static, and no instances at all. Every
/// other member of `HttpDate` is private, so bridging it is the whole class.
///
/// **Why a script needs it.** `HttpHeaders` stores dates as strings on the wire
/// (`date`, `expires`, `ifModifiedSince` are `Set-Cookie`-adjacent header
/// values), and a script that reads a header the bridge does not parse for it —
/// `Last-Modified`, `Retry-After`, any custom one — has no other way to turn
/// that string into a `DateTime`. Hand-rolling RFC-1123 parsing in interpreted
/// Dart is both tedious and wrong in the corners (three accepted formats, all
/// of which the SDK handles), so the absence of this name pushed scripts toward
/// a worse implementation rather than toward a workaround.
void main() {
  group('SCC65: HttpDate.format', () {
    test('F-SCC65-1: formats a UTC DateTime as RFC-1123 [2026-09-06]', () {
      // The exact string the SDK produces, not a `contains` — the format is the
      // point of the class, and a bridge that returned `toString()` would pass
      // a looser assertion.
      const source = '''
      import 'dart:io';
      main() {
        return HttpDate.format(DateTime.utc(2026, 1, 2, 3, 4, 5));
      }
      ''';
      expect(execute(source), equals('Fri, 02 Jan 2026 03:04:05 GMT'));
    });

    test('F-SCC65-2: converts a local DateTime to GMT before formatting '
        '[2026-09-06]', () {
      // `format` calls `toUtc()` itself. Asserted because the bridge passes the
      // value straight through, so this is really a check that nothing in the
      // bridging path (unwrapping, in particular) substitutes a different
      // moment — and a local-time value is the case where that would show.
      const source = '''
      import 'dart:io';
      main() {
        var utc = DateTime.utc(2026, 6, 1, 12, 0, 0);
        return HttpDate.format(utc.toLocal()) == HttpDate.format(utc);
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('F-SCC65-3: rejects a non-DateTime argument [2026-09-06]', () {
      // `isNot(contains('Undefined'))` is doing real work in every throwing
      // case in this file: while the name was unbridged these assertions
      // passed on `Undefined variable: HttpDate`, which contains the class
      // name and says nothing about the argument. A throw is only evidence
      // if it is the throw the bridge meant.
      const source = '''
      import 'dart:io';
      main() { return HttpDate.format('not a date'); }
      ''';
      expect(
        () => execute(source),
        throwsRuntimeError(
          allOf(contains('HttpDate'), isNot(contains('Undefined'))),
        ),
      );
    });
  });

  group('SCC65: HttpDate.parse', () {
    test('F-SCC65-4: parses the RFC-1123 form back to a UTC DateTime '
        '[2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() {
        var d = HttpDate.parse('Fri, 02 Jan 2026 03:04:05 GMT');
        return [d.year, d.month, d.day, d.hour, d.minute, d.second, d.isUtc];
      }
      ''';
      expect(execute(source), equals([2026, 1, 2, 3, 4, 5, true]));
    });

    test('F-SCC65-5: parses the other two accepted formats [2026-09-06]', () {
      // RFC-850 and asctime. These are the reason the class is worth bridging
      // rather than telling a script to split the string itself: a hand-rolled
      // parser handles RFC-1123 and silently fails the other two, and a server
      // that emits them is not misbehaving.
      //
      // The `26` is not a typo and not a bridge defect. The SDK reads the
      // RFC-850 year as written and applies no century windowing, so
      // `02-Jan-26` really is the year 26 — measured natively before this was
      // asserted. Pinned in that shape rather than "corrected" to 2026,
      // because the bridge's contract is to pass the SDK's answer through
      // unchanged, and a bridge that silently windowed would be a bridge that
      // disagreed with the platform it wraps.
      const source = '''
      import 'dart:io';
      main() {
        var short = HttpDate.parse('Friday, 02-Jan-26 03:04:05 GMT');
        var long = HttpDate.parse('Friday, 02-Jan-2026 03:04:05 GMT');
        var asctime = HttpDate.parse('Fri Jan  2 03:04:05 2026');
        return [short.year, long.year, asctime.year, asctime.day];
      }
      ''';
      expect(execute(source), equals([26, 2026, 2026, 2]));
    });

    test('F-SCC65-6: format and parse round-trip [2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() {
        var original = DateTime.utc(2030, 12, 25, 23, 59, 58);
        return HttpDate.parse(HttpDate.format(original)) == original;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('F-SCC65-7: an unparseable date throws rather than answering null '
        '[2026-09-06]', () {
      // The SDK throws `HttpException` here. What matters to a script is that
      // it is a throw and not a null or an epoch date, either of which would
      // flow onward and be discovered somewhere else entirely.
      const source = '''
      import 'dart:io';
      main() {
        try {
          HttpDate.parse('definitely not a date');
          return 'no throw';
        } on HttpException catch (e) {
          return 'caught: \${e.message}';
        }
      }
      ''';
      expect(execute(source), startsWith('caught:'));
    });

    test('F-SCC65-8: rejects a non-String argument [2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() { return HttpDate.parse(42); }
      ''';
      expect(
        () => execute(source),
        throwsRuntimeError(
          allOf(contains('HttpDate'), isNot(contains('Undefined'))),
        ),
      );
    });
  });

  group('SCC65: HttpDate is a type, not a callable', () {
    test('F-SCC65-9: the name answers a type test rather than throwing '
        '[2026-09-06]', () {
      // The distinction SCC64 established: a name registered as a bare
      // `NativeFunction` constructs but cannot be asked about, and `1 is X`
      // is what separates the two. `HttpDate` has no instances, so this is
      // the only type question that can be asked of it.
      const source = '''
      import 'dart:io';
      main() { return 1 is HttpDate; }
      ''';
      expect(execute(source), isFalse);
    });

    test('F-SCC65-10: it cannot be constructed [2026-09-06]', () {
      // `class HttpDate { HttpDate._(); }` — the SDK's constructor is private,
      // so real Dart rejects this at compile time.
      const source = '''
      import 'dart:io';
      main() { return HttpDate(); }
      ''';
      expect(
        () => execute(source),
        throwsRuntimeError(
          allOf(contains('HttpDate'), isNot(contains('Undefined'))),
        ),
      );
    });
  });
}
